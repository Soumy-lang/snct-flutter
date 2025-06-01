require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');
const authRoutes = require('./routes/auth');
const trajet = require('./routes/trajet');
const cors = require('cors');

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Connexion à MongoDB
mongoose.connect(process.env.MONGO_URI, {
   
})
  .then(() => console.log("Connecté à MongoDB"))
  .catch(err => console.error(err));

// Routes
app.use('/api/auth', authRoutes);

app.use('/api/trajet', trajet);


const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Serveur démarré sur le port ${PORT}`));