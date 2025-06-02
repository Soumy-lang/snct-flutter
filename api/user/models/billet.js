const mongoose = require('mongoose');

const BilletSchema = new mongoose.Schema({
  from: String,
  to: String,
  train: String,
  nom: String,
  email: String,
  date: String,
});

module.exports = mongoose.model('Billet', BilletSchema);
