const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');

const TrajetSchema = new mongoose.Schema({
  depart: { type: String, required: true },
  destionation: { type: String, required: true }
});



module.exports = mongoose.model('Trajet', TrajetSchema);