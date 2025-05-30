import 'package:flutter/material.dart';
import '../vues/admin/home_page_admin.dart';
import '../vues/admin/train_list_page.dart';
import '../vues/admin/reservation_list_page.dart';
import '../vues/admin/nouveau_train.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/admin': (context) => HomePageAdmin(),
  '/admin/trains': (context) => TrainListPage(),
  '/admin/reservations': (context) => ReservationListPage(),
  '/admin/tous_les_trains': (context) => NewTrainFormPage(),
};
