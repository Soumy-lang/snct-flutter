import 'package:flutter/material.dart';
import '../vues/home_page_admin.dart';
import '../vues/train_list_page.dart';
import '../vues/reservation_list_page.dart';
import '../vues/nouveau_train.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => HomePageAdmin(),
  '/trains': (context) => TrainListPage(),
  '/reservations': (context) => ReservationListPage(),
  '/tous_les_trains': (context) => Train2FormPage(),
};
