const express = require('express');
const cors = require('cors');
const { MongoClient, ObjectId } = require('mongodb');

const app = express();
const port = 3000;

app.use(cors());
app.use(express.json());

const url = 'mongodb://localhost:27017';
const dbName = 'snct';

app.get('/trains', async (req, res) => {
  const client = new MongoClient(url);
  try {
    await client.connect();
    const db = client.db(dbName);
    const trains = await db.collection('trains').find().toArray();
    res.json(trains);
  } catch (err) {
    res.status(500).send(err.toString());
  } finally {
    await client.close();
  }
});

app.post('/trains', async (req, res) => {
  const client = new MongoClient(url);
  try {
    const train = req.body;
    await client.connect();
    const db = client.db(dbName);
    const result = await db.collection('trains').insertOne(train);
    res.json(result);
  } catch (err) {
    res.status(500).send(err.toString());
  } finally {
    await client.close();
  }
});

app.put('/trains/:id', async (req, res) => {
  const client = new MongoClient(url);
  try {
    const id = req.params.id;
    const updatedTrain = req.body;

    await client.connect();
    const db = client.db(dbName);

    const result = await db.collection('trains').updateOne(
      { _id: new ObjectId(id) },
      { $set: updatedTrain }
    );

    if (result.modifiedCount === 0) {
      return res.status(404).json({ message: "Train non trouvé" });
    }

    res.status(200).json({ message: "Train modifié avec succès" });
  } catch (error) {
    console.error('Erreur PUT /trains/:id =>', error);
    res.status(500).json({ message: "Erreur serveur" });
  } finally {
    await client.close();
  }
});

app.get('/reservations', async (req, res) => {
  const client = new MongoClient(url);
  try {
    await client.connect();
    const db = client.db(dbName);
    const reservations = await db.collection('reservations').find().toArray();
    res.json(reservations);
  } catch (err) {
    res.status(500).send(err.toString());
  } finally {
    await client.close();
  }
});

app.post('/reservations', async (req, res) => {
  const client = new MongoClient(url);
  try {
    const reservation = req.body;
    await client.connect();
    const db = client.db(dbName);
    const result = await db.collection('reservations').insertOne(reservation);
    res.json(result);
  } catch (err) {
    res.status(500).send(err.toString());
  } finally {
    await client.close();
  }
});

app.get('/trains-simple', async (req, res) => {
  const client = new MongoClient(url);
  try {
    await client.connect();
    const db = client.db(dbName);
    const trains = await db.collection('trains-simple').find().toArray();
    res.json(trains);
  } catch (err) {
    res.status(500).send(err.toString());
  } finally {
    await client.close();
  }
});

app.post('/trains-simple', async (req, res) => {
  const client = new MongoClient(url);
  try {
    const train = req.body;
    await client.connect();
    const db = client.db(dbName);
    const result = await db.collection('trains-simple').insertOne(train);
    res.status(201).json(result);
  } catch (err) {
    res.status(500).send(err.toString());
  } finally {
    await client.close();
  }
});

app.put('/trains-simple/:id', async (req, res) => {
  const client = new MongoClient(url);
  try {
    const id = req.params.id;
    const update = req.body;
    await client.connect();
    const db = client.db(dbName);
    const result = await db.collection('trains-simple').updateOne(
      { _id: new ObjectId(id) },
      { $set: update }
    );
    if (result.modifiedCount === 0) {
      return res.status(404).json({ message: "Train non trouvé" });
    }
    res.status(200).json({ message: "Modifié avec succès" });
  } catch (err) {
    res.status(500).send(err.toString());
  } finally {
    await client.close();
  }
});

app.listen(port, () => {
  console.log(`SNCT API server listening at http://localhost:${port}`);
});
