const express = require('express');
const Trajet = require('../models/Trajet');
const router = express.Router();

// GET tous les trajets
router.get('/', async (req, res) => {
  try {
    const trajets = await Trajet.find();
    res.status(200).json(trajets);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
