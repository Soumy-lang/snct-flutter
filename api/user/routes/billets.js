const express = require('express');
const router = express.Router();
const Billet = require('../models/billet');

// POST /api/billets
router.post('/', async (req, res) => {
  try {
    const billet = new Billet(req.body);
    await billet.save();
    res.status(201).json({ message: 'Billet enregistré' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// GET /api/billets?email=...
router.get('/', async (req, res) => {
  const email = req.query.email;
  if (!email) return res.status(400).json({ error: 'Email requis' });

  try {
    const billets = await Billet.find({ email });
    res.status(200).json(billets);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
