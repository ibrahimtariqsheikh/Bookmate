import 'package:book_mate/blocs/auth/bloc/auth_bloc.dart';
import 'package:book_mate/blocs/auth/repository/auth_repository.dart';
import 'package:book_mate/blocs/login/cubit/login_cubit.dart';
import 'package:book_mate/blocs/signup/cubit/signup_cubit.dart';
import 'package:book_mate/config/app_theme.dart';
import 'package:book_mate/config/build_routes.dart';
import 'package:book_mate/firebase_options.dart';
import 'package:book_mate/screens/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  setPortraitOrientation();
  runApp(const MyApp());
}

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void setPortraitOrientation() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(
            firebaseAuth: _firebaseAuth,
            firebaseFirestore: _firebaseFirestore,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) =>
                AuthBloc(authRepository: context.read<AuthRepository>()),
          ),
          BlocProvider<LogInCubit>(
            create: (context) =>
                LogInCubit(authRepository: context.read<AuthRepository>()),
          ),
          BlocProvider<SignUpCubit>(
            create: (context) =>
                SignUpCubit(authRepository: context.read<AuthRepository>()),
          ),
        ],
        child: MaterialApp(
          title: 'Bookmate',
          theme: AppTheme.lightTheme(),
          darkTheme: AppTheme.darkTheme(),
          themeMode: ThemeMode.dark,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: buildAppRoutes,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
