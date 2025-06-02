const mongoose = require('mongoose');

const TrajetSchema = new mongoose.Schema({
  departureTime: { type: String, required: true },
  arrivalTime: { type: String, required: true },
  from: { type: String, required: true },
  to: { type: String, required: true },
  trainLabel: { type: String, required: true },
  company: { type: String, required: true },
  duration: { type: String, required: true },
  price: { type: String, required: true },
  isAvailable: { type: Boolean, required: true }
});

module.exports = mongoose.model('trajets', TrajetSchema);
