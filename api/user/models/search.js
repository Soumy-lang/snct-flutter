const mongoose = require('mongoose');

const TrajetSchema = new mongoose.Schema({
  depart: { type: String, required: true },
  destination: { type: String, required: true } // <-- Corrigé ici
});

module.exports = mongoose.model('Trajet', TrajetSchema);
