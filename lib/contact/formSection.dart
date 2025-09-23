import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:port_folio/utils/popup.dart';
import 'dart:convert';

import '../theme/theme.dart';
import 'package:port_folio/home/social_links.dart';

class FormSection extends StatefulWidget {
  const FormSection({super.key});

  @override
  State<FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<FormSection> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  bool isSubmitting = false;
  String? errorMessage;

  final RegExp emailRegex = RegExp(
    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
  );

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isSubmitting = true;
      errorMessage = null;
    });

    final Uri apiUrl = Uri.parse("https://apinilesh.vercel.app/api/send_email");

    try {
      final response = await http.post(
        apiUrl,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": _nameController.text.trim(),
          "email": _emailController.text.trim(),
          "message": _messageController.text.trim(),
        }),
      );

      if (response.statusCode == 200) {
        _showSuccessPopup();
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
      } else {
        setState(() =>
        errorMessage = "Failed to send email. Please try again.");
      }
    } catch (e) {
      setState(() => errorMessage = "An error occurred. Please try again. $e");
    } finally {
      setState(() => isSubmitting = false);
    }
  }

  void _showSuccessPopup() {
    showDialog(
      context: context,
      builder: (context) =>
          Popup(
            containerWidth: 320,
            xPos: MediaQuery.of(context).size.width / 2 - 160,
            yPos: MediaQuery.of(context).size.height / 3,
            discription: "Your message has been submitted successfully.",
            icon: Icons.check_circle_outline,
            title: "Submitted",
            lock: 1.18,
            popupType: 'submit',
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final double baseFontSize = (screenWidth * 0.013).clamp(16.0, 24.0);
    final double headingFontSize = (baseFontSize * 1.3).clamp(22.0, 42.0);
    final bool isLargeScreen = screenWidth >= 850;
    final double sectionSpacing = (screenHeight * 0.06).clamp(30, 90);

    // Use bundled SpaceMono font
    final TextStyle textStyle = TextStyle(
      fontFamily: 'SpaceMono',
      fontSize: baseFontSize,
      color: isDarkMode ? darkTextColor : lightTextColor,
    );

    return Padding(
      padding: EdgeInsets.all(isLargeScreen ? 16.0 : 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isLargeScreen ? "Drop a Mail" : "Contact Me",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: 'SpaceMono',
              fontWeight: FontWeight.bold,
              fontSize: headingFontSize,
              letterSpacing: 1,
              color: isDarkMode ? primaryColor : primaryColorLight,
            ),
          ),
          SizedBox(height: sectionSpacing * 0.8),

          if (errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text(
                errorMessage!,
                style: TextStyle(
                  fontFamily: 'SpaceMono',
                  color: Colors.redAccent,
                  fontSize: baseFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

          Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTextField("Name", _nameController, textStyle, isDarkMode),
                const SizedBox(height: 16),
                _buildTextField(
                    "Email", _emailController, textStyle, isDarkMode,
                    isEmail: true),
                const SizedBox(height: 16),
                _buildTextField(
                    "Message", _messageController, textStyle, isDarkMode,
                    maxLines: 5),
                SizedBox(height: sectionSpacing * 0.8),

                ElevatedButton(
                  onPressed: isSubmitting ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDarkMode
                        ? primaryColor
                        : primaryColorLight,
                    disabledBackgroundColor: isDarkMode
                        ? primaryColor.withOpacity(0.6)
                        : primaryColorLight.withOpacity(0.6),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: isSubmitting
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2),
                  )
                      : Text("Submit",
                      style: textStyle.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                ),

                if (!isLargeScreen) ...[
                  SizedBox(height: sectionSpacing * 0.8),
                  SocialLinksWidget(
                      isLargeScreen: false,
                      screenWidth: screenWidth,
                      isDarkMode: isDarkMode),
                  SizedBox(height: sectionSpacing * 0.8),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label,
      TextEditingController controller,
      TextStyle textStyle,
      bool isDarkMode, {
        bool isEmail = false,
        int maxLines = 1,
      }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: textStyle,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      validator: (value) {
        if (value == null || value.trim().isEmpty) return "$label is required";
        if (isEmail && !emailRegex.hasMatch(value.trim()))
          return "Enter a valid email";
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        labelStyle: textStyle,
        alignLabelWithHint: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(
            vertical: 16, horizontal: 12),
      ),
    );
  }
}
