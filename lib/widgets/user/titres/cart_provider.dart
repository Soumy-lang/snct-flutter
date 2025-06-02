import 'package:flutter/material.dart';
import '../../../models/user/PassModel.dart';
import '../../../models/user/TrajetModel.dart';
import 'package:flutter/foundation.dart';

class CartProvider with ChangeNotifier {
  final List<PassModel> _items = [];
  final List<TrajetModel> _itemsTrajet = [];

  List<TrajetModel> get billets => _itemsTrajet;
  List<PassModel> get items => _items;

  void addToCart(PassModel pass) {
    _items.add(pass);
    notifyListeners();
  }

  void removeFromCart(PassModel pass) {
    _items.remove(pass);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  double get total {
    return _items.fold(0.0, (sum, item) {
      final numericPrice = double.tryParse(item.price.replaceAll(',', '.').replaceAll('€', '').trim()) ?? 0;
      return sum + numericPrice;
    });
  }
  bool get isEmpty => _items.isEmpty;


//pour les trajets

  void addToCarts(TrajetModel trajet) {
    _itemsTrajet.add(trajet);
    notifyListeners();
  }

  void removeFromCarts(TrajetModel trajet) {
    _itemsTrajet.remove(trajet);
    notifyListeners();
  }

  void clearCarts() {
    _itemsTrajet.clear();
    notifyListeners();
  }

  double get totals {
    return _itemsTrajet.fold(0.0, (sum, billet) {
      final numericPrice = double.tryParse(billet.price.replaceAll(',', '.').replaceAll('€', '').trim()) ?? 0;
      return sum + numericPrice;
    });
  }

bool get isEmptytrajet => _itemsTrajet.isEmpty;
}
