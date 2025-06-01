const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');

const UserSchema = new mongoose.Schema({
  email: { type: String, required: true, unique: true },
  password: { type: String, required: true },
  role: {type: String, required: true, default: "user", enum: ["user","admin"]}
});



module.exports = mongoose.model('User', UserSchema);