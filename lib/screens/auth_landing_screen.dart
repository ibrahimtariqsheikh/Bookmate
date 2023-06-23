import 'package:book_mate/screens/login_screen.dart';
import 'package:book_mate/screens/signup_screen.dart';
import 'package:book_mate/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AuthLandingScreen extends StatelessWidget {
  static const routeName = '/auth-landing';
  const AuthLandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const assetName = 'assets/icons/logo.svg';
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          const Spacer(flex: 2),
          SvgPicture.asset(assetName,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onPrimary,
                BlendMode.srcIn,
              ),
              semanticsLabel: 'Book Mate Logo'),
          const SizedBox(height: 15),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: size.width * 0.6,
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Text(
                    'Unleash the power of reading with',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Bookmate',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const Spacer(flex: 2),
          CustomButton(
            buttonText: 'Log In',
            buttonWidth: size.width * 0.8,
            buttonHeight: size.height * 0.06,
            isSubmitting: false,
            isOutlined: false,
            buttonAction: () =>
                Navigator.pushNamed(context, LoginScreen.routeName)
          ),
          const SizedBox(height: 15),
          CustomButton(
            buttonText: 'Sign Up',
            buttonWidth: size.width * 0.8,
            buttonHeight: size.height * 0.06,
            isSubmitting: false,
            isOutlined: true,
            buttonAction: () =>
                Navigator.pushNamed(context, SignUpScreen.routeName)
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
