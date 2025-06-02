const express = require('express');
const Ligne = require('../models/ligne');
const router = express.Router();

router.get('/', async (req, res) => {
  try {
    const lignes = await Ligne.find();
    res.status(200).json(lignes);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
