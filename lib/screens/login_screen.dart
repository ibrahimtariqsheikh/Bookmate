import 'package:book_mate/blocs/login/cubit/login_cubit.dart';
import 'package:book_mate/screens/home_page.dart';
import 'package:book_mate/screens/signup_screen.dart';
import 'package:book_mate/widgets/custom_button.dart';
import 'package:book_mate/widgets/custom_text_field.dart';
import 'package:book_mate/widgets/error_dialog.dart';
import 'package:book_mate/widgets/lined_text.dart';
import 'package:book_mate/widgets/social_auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:validators/validators.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _submit() {
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;
    form.save();
    context.read<LogInCubit>().logIn(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<LogInCubit, LogInState>(listener: (context, state) {
      if (state.logInStatus == LogInStatus.error) {
        errorDialog(context, state.error);
      }
      if (state.logInStatus == LogInStatus.success) {
        Navigator.pushNamedAndRemoveUntil(
            context, HomePage.routeName, (route) => false);
      }
    }, builder: (context, state) {
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: size.height * .9,
                  width: size.width,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: Row(
                            children: [
                              const Spacer(),
                              IconButton(
                                icon: Icon(FontAwesomeIcons.arrowLeft,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.color as Color),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                              const Spacer(
                                flex: 3,
                              ),
                              Text(
                                'Log In',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const Spacer(
                                flex: 6,
                              ),
                            ],
                          ),
                        ),
                        const Spacer(
                          flex: 4,
                        ),
                        CustomTextField(
                          title: 'Email',
                          hintText: "Enter your email here",
                          maxLength: 50,
                          prefixIcon:
                              const Icon(Icons.email, color: Colors.grey),
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Email is Required';
                            }
                            if (!isEmail(value.trim())) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: size.height * .015,
                        ),
                        CustomTextField(
                          title: 'Password',
                          hintText: "Enter your password here",
                          obscureText: true,
                          maxLength: 20,
                          prefixIcon: const Icon(
                            FontAwesomeIcons.lock,
                            color: Colors.grey,
                          ),
                          passwordSuffix: true,
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Password is Required';
                            }
                            if (value.length < 6) {
                              return 'Password must be atleast 6 characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: size.height * .01,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: size.width * 0.05,
                          ),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(
                                  color: Colors.redAccent,
                                ),
                              ),
                              child: Text(
                                "Forgot Password?",
                                style: GoogleFonts.urbanist(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(28, 102, 238, 1)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * .01,
                        ),
                        CustomButton(
                          buttonText: 'Log In',
                          buttonWidth: size.width * 0.90,
                          buttonHeight: size.height * .06,
                          buttonAction:
                              state.logInStatus == LogInStatus.submitting
                                  ? null
                                  : _submit,
                          isSubmitting:
                              state.logInStatus == LogInStatus.submitting
                                  ? true
                                  : false,
                          isOutlined: false,
                        ),
                        const Spacer(
                          flex: 3,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: LinedText(text: "or continue with"),
                        ),
                        const Spacer(),
                        const SocialSignIn(
                            calledFrom: SocialAuthCalledFrom.login),
                        const Spacer(),
                        const SizedBox(
                          height: 20,
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't Have an Account?",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, SignUpScreen.routeName);
                              },
                              child:  Text(
                                ' Sign Up',
                                style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.tertiaryContainer),
                            ),
                            ),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
