import 'package:book_mate/screens/auth_landing_screen.dart';
import 'package:book_mate/screens/home_page.dart';
import 'package:book_mate/screens/login_screen.dart';
import 'package:book_mate/screens/signup_screen.dart';
import 'package:book_mate/screens/splash_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> buildAppRoutes(RouteSettings settings) {
  WidgetBuilder builder;
  switch (settings.name) {
    case LoginScreen.routeName:
      builder = (BuildContext _) => const LoginScreen();
      break;
    case SignUpScreen.routeName:
      builder = (BuildContext _) => const SignUpScreen();
      break;
    case SplashScreen.routeName:
      builder = (BuildContext _) => const SplashScreen();
      break;
    case AuthLandingScreen.routeName:
      builder = (BuildContext _) => const AuthLandingScreen();
      break;
case HomePage.routeName:
      builder = (BuildContext _) => const HomePage();
      break;
    default:
      throw Exception('Invalid route: ${settings.name}');
  }
  return MaterialPageRoute(builder: builder, settings: settings);
}
