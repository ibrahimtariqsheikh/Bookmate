import 'package:book_mate/blocs/signup/signup_cubit.dart';
import 'package:book_mate/screens/home_page.dart';
import 'package:book_mate/screens/login_screen.dart';
import 'package:book_mate/widgets/custom_button.dart';
import 'package:book_mate/widgets/custom_text_field.dart';
import 'package:book_mate/widgets/error_dialog.dart';
import 'package:book_mate/widgets/lined_text.dart';
import 'package:book_mate/widgets/social_auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:validators/validators.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/signup';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _ageController.dispose();
  }

  void _signUp() {
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;
    form.save();
    context.read<SignUpCubit>().signUp(
        name: _nameController.text.trim(),
        age: _ageController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.signUpStatus == SignUpStatus.error) {
          errorDialog(context, state.error);
        }
        if (state.signUpStatus == SignUpStatus.success) {
          Navigator.pushNamedAndRemoveUntil(
              context, HomePage.routeName, (route) => false);
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            body: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: size.height * .9,
                    width: size.width,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 50.0),
                            child: Row(
                              children: [
                                const Spacer(),
                                IconButton(
                                  icon: Icon(
                                    FontAwesomeIcons.arrowLeft,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.color as Color,
                                  ),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                                const Spacer(
                                  flex: 3,
                                ),
                                Text(
                                  'Sign Up',
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
                            flex: 3,
                          ),
                          SizedBox(
                            height: size.height * .015,
                          ),
                          CustomTextField(
                            title: 'Name',
                            hintText: "Enter your name",
                            maxLength: 20,
                            prefixIcon:
                                const Icon(Icons.person, color: Colors.grey),
                            controller: _nameController,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'First Name is Required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: size.height * .015,
                          ),
                          CustomTextField(
                            title: 'Email',
                            hintText: "Enter your email address",
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
                            title: 'Age',
                            hintText: "Enter your age",
                            maxLength: 3,
                            keyboardType: TextInputType.number,
                            prefixIcon: const Icon(Icons.calendar_today,
                                color: Colors.grey),
                            controller: _ageController,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Age is Required';
                              }
                              if (!isNumeric(value.trim())) {
                                return 'Enter a valid age';
                              }
                              int age = int.parse(value.trim());
                              if (age < 0 || age > 120) {
                                return 'Enter a valid age between 0 and 120';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: size.height * .015,
                          ),
                          CustomTextField(
                            title: 'Password',
                            hintText: "Enter your password",
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
                            height: size.height * .03,
                          ),
                          CustomButton(
                            buttonText: 'Sign Up',
                            buttonColor: Theme.of(context).colorScheme.primary,
                            buttonWidth: size.width * 0.90,
                            buttonHeight: size.height * .06,
                            buttonAction: _signUp,
                            isSubmitting:
                                state.signUpStatus == SignUpStatus.submitting
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
                            calledFrom: SocialAuthCalledFrom.signUp,
                          ),
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
                                      context, LoginScreen.routeName);
                                },
                                child: Text(
                                  ' Log In',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiaryContainer),
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
      },
    );
  }
}
