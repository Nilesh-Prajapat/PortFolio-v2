export default async function handler(req, res) {
  if (req.method !== "POST") {
    return res.status(405).json({ error: "Method Not Allowed" });
  }

  const apiKey = process.env.RESEND_API_KEY; // ✅ Secure API Key
  if (!apiKey) {
    return res.status(500).json({ error: "Missing Resend API Key" });
  }

  const { name, email, message } = req.body;

  const response = await fetch("https://api.resend.com/emails", {
    method: "POST",
    headers: {
      "Authorization": `Bearer ${apiKey}`,
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      from: "nilesh@resend.dev", // ✅ Must be a verified email from Resend
      to: ["work.nilesh.pr@gmail.com"], // ✅ Your email
      subject: "New Contact Form Submission",
      html: `
        <h2>Contact Form Submission</h2>
        <p><b>Name:</b> ${name}</p>
        <p><b>Email:</b> ${email}</p>
        <p><b>Message:</b> ${message}</p>
      `,
    }),
  });

  const data = await response.json();
  return res.status(response.status).json(data);
}
