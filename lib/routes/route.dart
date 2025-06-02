import 'package:flutter/material.dart';
import 'package:snct_app/vues/auth/forgot_password.dart';
import 'package:snct_app/vues/auth/reset_password.dart';
import 'package:snct_app/vues/auth/verify_otp.dart';
import '../vues/auth/login.dart';
import '../vues/auth/register.dart';

import '../vues/admin/home_page_admin.dart';
import '../vues/admin/train_list_page.dart';
import '../vues/admin/reservation_list_page.dart';
import '../vues/admin/nouveau_train.dart';
import '../vues/user/horairesView.dart';
import '../vues/user/userView.dart';
import '../vues/user/titreView.dart';


final Map<String, WidgetBuilder> appRoutes = {

  '/login': (context) => LoginPage(),
  '/register': (context) => RegisterPage(),
  "/forgot-password" : (context) => SendOtpScreen(),
  '/verify-otp': (context) => VerifyOtpScreen(),
  '/reset-password': (context) => ResetPasswordScreen(),

  '/admin': (context) => HomePageAdmin(),
  '/admin/trains': (context) => TrainListPage(),
  '/admin/reservations': (context) => ReservationListPage(),
  '/admin/tous_les_trains': (context) => NewTrainFormPage(),

  '/user': (context) => UserPage(),
  '/user/titres': (context) => AchatPage(),
  '/user/horaires': (context) => HorairesPage(),

};
