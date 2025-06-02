const mongoose = require('mongoose');

const LigneSchema = new mongoose.Schema({
  name: { type: String, required: true },
  accessible: { type: Boolean, required: true },
  number: { type: String, required: true },
  color: { type: String, required: true } 
});

module.exports = mongoose.model('lignes', LigneSchema);
