const mongoose = require('mongoose');

const ArretSchema = new mongoose.Schema({
  name: { type: String, required: true },
  accessible: { type: Boolean, required: true },
  ligne: { type: String, required: true } 
});

module.exports = mongoose.model('arret', ArretSchema);
