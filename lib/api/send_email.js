import nodemailer from "nodemailer";
import dotenv from "dotenv";

dotenv.config(); // Load environment variables locally

export default async function handler(req, res) {
    if (req.method !== "POST") {
        return res.status(405).json({ message: "Method not allowed" });
    }

    const { name, email, message } = req.body;

    if (!name || !email || !message) {
        return res.status(400).json({ message: "All fields are required." });
    }

    const transporter = nodemailer.createTransport({
        service: "gmail",
        auth: {
            user: process.env.EMAIL_USER,
            pass: process.env.EMAIL_PASS,
        },
    });

    const mailOptions = {
        from: email,
        to: process.env.EMAIL_USER,
        subject: "New Contact Form Submission",
        text: `Name: ${name}\nEmail: ${email}\nMessage: ${message}`,
    };

    try {
        await transporter.sendMail(mailOptions);
        return res.status(200).json({ message: "Email sent successfully!" });
    } catch (error) {
        return res.status(500).json({ message: "Failed to send email", error: error.toString() });
    }
}
