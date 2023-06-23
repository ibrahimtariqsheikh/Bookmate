import 'package:book_mate/blocs/auth/bloc/auth_bloc.dart';
import 'package:book_mate/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Home Page'),
              SizedBox(height: size.height * .02),
              CustomButton(
                buttonText: 'Log Out',
                buttonWidth: size.width * .8,
                buttonHeight: size.height * .05,
                isSubmitting: false,
                isOutlined: false,
                buttonAction: () {
                  context.read<AuthBloc>().add(LogOutRequestedEvent());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
