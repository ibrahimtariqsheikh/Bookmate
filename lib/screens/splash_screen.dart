import 'package:book_mate/blocs/auth/bloc/auth_bloc.dart';
import 'package:book_mate/screens/auth_landing_screen.dart';
import 'package:book_mate/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state.authStatus == AuthStatus.unauthenticated) {
          final currentRoute = ModalRoute.of(context)?.settings.name;
          await Future.delayed(const Duration(seconds: 3));
          // ignore: use_build_context_synchronously
          Navigator.restorablePushNamedAndRemoveUntil(
              context, AuthLandingScreen.routeName, (route) {
            return route.settings.name == currentRoute ? true : false;
          });
        } else if (state.authStatus == AuthStatus.authenticated) {
          Navigator.pushReplacementNamed(context, HomePage.routeName);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: SvgPicture.asset(
              'assets/icons/logo.svg',
              colorFilter: ColorFilter.mode(
                Theme.of(context).primaryColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        );
      },
    );
  }
}