import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../theme/theme.dart';
import 'package:port_folio/home/social_links.dart';
import 'package:port_folio/contact/submision_popup.dart';

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
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "name": _nameController.text.trim(),
          "email": _emailController.text.trim(),
          "message": _messageController.text.trim(),
        }),
      );

      if (response.statusCode == 200) {
        _showSuccessPopup();
      } else {
        setState(() {
          errorMessage = "Failed to send email. Please try again.";
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "An error occurred. Please try again. $e";
      });
    }

    setState(() {
      isSubmitting = false;
    });
  }

  void _showSuccessPopup() {
    showDialog(
      context: context,
      builder: (context) {
        return SubmissionPopup(
          message: "Thank you for reaching out. I'll get back to you soon!",
        );
      },
    );

    _nameController.clear();
    _emailController.clear();
    _messageController.clear();
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

    final TextStyle textStyle = GoogleFonts.spaceMono(
      fontSize: baseFontSize,
      color: isDarkMode ? darkTextColor : lightTextColor,
    );

    return Padding(
      padding: EdgeInsets.all(isLargeScreen ? 16.0 : 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: sectionSpacing * 0.8),
          Text(
            isLargeScreen ? "Drop a Review" : "Contact Me",
            textAlign: TextAlign.start,
            style: GoogleFonts.spaceMono(
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
                style: GoogleFonts.spaceMono(
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
                SizedBox(height: 16),
                _buildTextField("Email", _emailController, textStyle, isDarkMode, isEmail: true),
                SizedBox(height: 16),
                _buildTextField("Message", _messageController, textStyle, isDarkMode, maxLines: 5),
                SizedBox(height: sectionSpacing * 0.8),

                ElevatedButton(
                  onPressed: isSubmitting ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSubmitting
                        ? (isDarkMode ? primaryColor.withOpacity(0.6) : primaryColorLight.withOpacity(0.6))
                        : (isDarkMode ? primaryColor : primaryColorLight),
                    disabledBackgroundColor: isDarkMode ? primaryColor.withOpacity(0.6) : primaryColorLight.withOpacity(0.6),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: isSubmitting
                      ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                      : Text(
                    "Submit",
                    style: textStyle.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),

                SizedBox(height: sectionSpacing * 0.8),
                if (!isLargeScreen) ...[
                  SocialLinksWidget(isLargeScreen: false, screenWidth: screenWidth, isDarkMode: isDarkMode),
                  SizedBox(height: sectionSpacing * 0.8),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, TextStyle textStyle, bool isDarkMode, {bool isEmail = false, int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: textStyle,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "$label is required";
        }
        if (isEmail && !emailRegex.hasMatch(value.trim())) {
          return "Enter a valid email";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        labelStyle: textStyle,
        alignLabelWithHint: true, // Keeps label top-aligned
        floatingLabelBehavior: FloatingLabelBehavior.always, // Ensures label stays visible
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
