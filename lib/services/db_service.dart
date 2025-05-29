import 'package:mongo_dart/mongo_dart.dart';

class DBService {
  static Db? _db;
  static DbCollection? trainCollection;
  static DbCollection? reservationCollection;

  static Future<void> connect() async {
    try {
      _db = await Db.create('mongodb://localhost:27017/snct');
      await _db!.open();
      trainCollection = _db!.collection('trains');
      reservationCollection = _db!.collection('reservations');
      print('MongoDB connecté !');
    } catch (e) {
      print('Erreur connexion MongoDB : $e');
    }
  }


  static void close() {
    _db?.close();
  }
}
