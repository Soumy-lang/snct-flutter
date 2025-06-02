const express = require('express');
const User = require('../models/search');
const router = express.Router();


router.post('/', async (req, res) => {
  try {
    const { depart, destination } = req.body;

    // 🔍 Rechercher dans MongoDB
    const trajetsTrouves = await User.find({ depart, destination });

    if (trajetsTrouves.length === 0) {
      return res.status(404).json({ message: "Aucun trajet trouvé." });
    }

    res.status(200).json(trajetsTrouves); 
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});




module.exports = router;