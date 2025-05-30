const express = require('express');
const User = require('../models/search');
const router = express.Router();


router.get('/trajet', async (req, res) => {
  try {
    const { depart, destination } = req.body;
    const trajet = new User({ depart, destination });
    await trajet.save();
    res.status(200).json({ message: "votre trajet est là" });
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});



module.exports = router;