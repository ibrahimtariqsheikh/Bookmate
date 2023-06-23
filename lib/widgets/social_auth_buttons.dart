import 'package:book_mate/blocs/login/cubit/login_cubit.dart';
import 'package:book_mate/blocs/signup/cubit/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum SocialAuthCalledFrom { login, signUp }

class SocialSignIn extends StatelessWidget {
  final SocialAuthCalledFrom calledFrom;
  const SocialSignIn({
    required this.calledFrom,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(children: [
      const Spacer(
        flex: 3,
      ),
      SocialButton(
        height: size.height * .07,
        width: size.width * .20,
        icon: FontAwesomeIcons.facebook,
        action: () {
     if (calledFrom == SocialAuthCalledFrom.login) {
            context.read<LogInCubit>().logInWithFacebook();
          }
          if (calledFrom == SocialAuthCalledFrom.signUp) {
            context.read<SignUpCubit>().signUpWithFacebook();
          }
        },
      ),
      const Spacer(),
      SocialButton(
        height: size.height * .07,
        width: size.width * .20,
        icon: FontAwesomeIcons.google,
        action: () {
         if (calledFrom == SocialAuthCalledFrom.login) {
            context.read<LogInCubit>().logInWithGoogle();
          }
          if (calledFrom == SocialAuthCalledFrom.signUp) {
            context.read<SignUpCubit>().signUpWithGoogle();
          }
        },
      ),
      const Spacer(),
      SocialButton(
        height: size.height * .07,
        width: size.width * .20,
        icon: FontAwesomeIcons.twitter,
        action: () {
          if (calledFrom == SocialAuthCalledFrom.login) {
            context.read<LogInCubit>().logInWithTwitter();
          }
          if (calledFrom == SocialAuthCalledFrom.signUp) {
            context.read<SignUpCubit>().signUpWithTwitter();
          }
        },
      ),
      const Spacer(
        flex: 3,
      ),
    ]);
  }
}

class SocialButton extends StatelessWidget {
  final Function() action;
  final IconData icon;
  final String? text;
  final double width;
  final double height;
  const SocialButton({
    super.key,
    required this.width,
    required this.height,
    required this.icon,
    required this.action,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      splashColor: Colors.white,
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Theme.of(context).colorScheme.secondary,
          border: Border.all(
            color: Theme.of(context).colorScheme.secondaryContainer,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Theme.of(context).iconTheme.color,
            ),
            text != null
                ? const SizedBox(
                    width: 10,
                  )
                : const SizedBox(),
            text != null
                ? Text(
                    text!,
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}