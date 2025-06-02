const express = require('express');
const router = express.Router();
const crypto = require('crypto');
const bcrypt = require('bcryptjs');
const nodemailer = require('nodemailer');
const Otp = require('../models/Otp');
const User = require('../models/User'); 


const transporter = nodemailer.createTransport({
  host: "sandbox.smtp.mailtrap.io",
  port: 2525,
  auth: {
    user: process.env.MAILTRAP_USER,
    pass: process.env.MAILTRAP_PASS  
  }
});


const generateOTP = () => crypto.randomInt(100000, 999999).toString();


router.post('/send', async (req, res) => {
  try {
    const { email } = req.body;
    
    await Otp.deleteMany({ email });
    const otp = generateOTP();
    const newOtp = new Otp({ email, otp });
    await newOtp.save();

    await transporter.sendMail({
      from: `"SNCT " <${process.env.EMAIL_USER}>`,
      to: email,
      subject: 'Votre code de vérification',
      text: `Votre code OTP est: ${otp}\nCe code expirera dans 5 minutes.`,
      html: `<p>Votre code OTP est: <b>${otp}</b></p><p>Ce code expirera dans 5 minutes.</p>`
    });

    res.status(200).json({ message: 'OTP envoyé avec succès' });
  } catch (error) {
    console.error('Erreur envoi OTP:', error);
    res.status(500).json({ message: "Erreur lors de l'envoi de l'OTP" });
  }
});

router.post('/verify', async (req, res) => {
  try {
    const { email, otp } = req.body;

    const otpRecord = await Otp.findOne({ email, otp });
    
    if (!otpRecord) {
      return res.status(400).json({ message: "OTP invalide ou expiré" });
    }
    
    await Otp.deleteOne({ _id: otpRecord._id });
    
    res.status(200).json({ message: "OTP vérifié avec succès" });
  } catch (error) {
    console.error('Erreur vérification OTP:', error);
    res.status(500).json({ message: "Erreur lors de la vérification" });
  }
});

router.post('/reset-password', async (req, res) => {
  try {
    const { email, newPassword, resetToken } = req.body;

    if (!email || !newPassword) {
      return res.status(400).json({ message: "Email et mot de passe requis" });
    }

    const user = await User.findOne({ email });
    if (!user) {
      return res.status(404).json({ message: "Utilisateur non trouvé" });
    }

    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(newPassword, salt);
    user.password = hashedPassword;
    await user.save();

    await transporter.sendMail({
      from: `"SNCT " <${process.env.EMAIL_USER}>`,
      to: email,
      subject: 'Confirmation de réinitialisation',
      text: 'Votre mot de passe a été réinitialisé avec succès.',
      html: '<p>Votre mot de passe a été réinitialisé avec succès.</p>'
    });

    res.status(200).json({ message: "Mot de passe réinitialisé avec succès" });
  } catch (error) {
    console.error('Erreur réinitialisation:', error);
    res.status(500).json({ message: "Erreur lors de la réinitialisation" });
  }
});

module.exports = router;