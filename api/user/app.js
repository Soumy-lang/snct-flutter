require("dotenv").config();
const express = require("express");
const mongoose = require("mongoose");
const authRoutes = require("./routes/auth");
const trajet = require("./routes/trajet");
const lignesRoute = require("./routes/lignes");
const arretRoute = require("./routes/arrets");
const billetRoutes = require("./routes/billets");
const trajetRoutes = require('./routes/trajets');
const cors = require("cors");

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Connexion à MongoDB
mongoose
  .connect(process.env.MONGO_URI, {})
  .then(() => console.log("Connecté à MongoDB"))
  .catch((err) => console.error(err));

// Routes
app.use("/api/auth", authRoutes);
app.use("/api/lignes", lignesRoute);
app.use("/api/trajet", trajet);
app.use("/api/arrets", arretRoute);
app.use("/api/billets", billetRoutes);
app.use('/api/trajets', trajetRoutes);

const PORT = process.env.PORT || 4000;
app.listen(PORT, () => console.log(`Serveur démarré sur le port ${PORT}`));
