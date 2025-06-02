const express = require('express');
const Arret = require('../models/arret');
const router = express.Router();

router.get('/', async (req, res) => {
  try {
    const arrets = await Arret.find();
    res.status(200).json(arrets);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// GET /api/arrets/ligne/:name
router.get('/ligne/:name', async (req, res) => {
  try {
    const ligneName = req.params.name;
    const arrets = await Arret.find({ ligne: ligneName });
    res.status(200).json(arrets);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});


module.exports = router;
