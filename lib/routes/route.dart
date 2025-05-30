import 'package:flutter/material.dart';
import 'package:snct_app/vues/auth/forgot_password.dart';
import 'package:snct_app/vues/auth/reset_password.dart';
import 'package:snct_app/vues/auth/verify_otp.dart';
import '../vues/auth/login.dart';
import '../vues/auth/register.dart';

final Map<String, WidgetBuilder> appRoutes = {

  '/login': (context) => LoginPage(),
  '/register': (context) => RegisterPage(),
  "/forgot-password" : (context) => SendOtpScreen(),
  '/verify-otp': (context) => VerifyOtpScreen(),
  '/reset-password': (context) => ResetPasswordScreen(),
};