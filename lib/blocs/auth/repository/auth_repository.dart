import 'package:book_mate/config/constants.dart';
import 'package:book_mate/models/custom_error.dart';
import 'package:book_mate/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_login/twitter_login.dart';

class AuthRepository {
  final FirebaseFirestore firebaseFirestore;
  final fb_auth.FirebaseAuth firebaseAuth;

  AuthRepository({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  Stream<fb_auth.User?> get user => firebaseAuth.userChanges();

  Future<void> logInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on fb_auth.FirebaseAuthException catch (e) {
      throw CustomError(code: e.code, message: e.message!, plugin: e.plugin);
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  Future<void> logInWithTwitter() async {
    final twitterLogin = TwitterLogin(
      apiKey: '',
      apiSecretKey: '',
      redirectURI: '',
    );

    final authResult = await twitterLogin.login();

    switch (authResult.status) {
      case TwitterLoginStatus.loggedIn:
        final credential = fb_auth.TwitterAuthProvider.credential(
          accessToken: authResult.authToken!,
          secret: authResult.authTokenSecret!,
        );

        try {
          final userCredential =
              await firebaseAuth.signInWithCredential(credential);

          final fb_auth.User? signedInUser = userCredential.user;
          final docRef = usersRef.doc(signedInUser!.uid);

          final docSnapshot = await docRef.get();

          if (!docSnapshot.exists) {
            User user = User(
                id: signedInUser.uid,
                age: 0,
                name: signedInUser.displayName ?? '',
                email: signedInUser.email ?? '');
            await docRef.set(user.toJson());
          }
        } on fb_auth.FirebaseAuthException catch (e) {
          throw CustomError(
            code: e.code,
            message: e.message!,
            plugin: e.plugin,
          );
        } catch (e) {
          throw CustomError(
            code: 'Exception',
            message: e.toString(),
            plugin: 'flutter_error/server_error',
          );
        }
        break;
      case TwitterLoginStatus.cancelledByUser:
        throw const CustomError(
          code: 'Twitter Sign In Cancelled',
          message: 'Twitter login was cancelled by the user.',
          plugin: 'flutter_error/twitter_login',
        );
      case TwitterLoginStatus.error:
        throw CustomError(
          code: 'TwitterAuthError',
          message: authResult.errorMessage!,
          plugin: 'flutter_error/twitter_login',
        );
      default:
        throw const CustomError(
          code: 'UnknownError',
          message: 'An unknown error occurred while logging in with Twitter.',
          plugin: 'flutter_error/twitter_login',
        );
    }
  }

  Future<void> logInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount == null) {
      throw const CustomError(
        code: 'Google Sign In Cancelled',
        message: 'User cancelled Google sign-in',
        plugin: 'flutter_error/google_error',
      );
    }

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final fb_auth.AuthCredential credential =
        fb_auth.GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    try {
      final fb_auth.UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);

      final fb_auth.User? signedInUser = userCredential.user;
      final docRef = usersRef.doc(signedInUser!.uid);

      final docSnapshot = await docRef.get();

      if (!docSnapshot.exists) {
        User user = User(
            id: signedInUser.uid,
            age: 0,
            name: signedInUser.displayName ?? '',
            email: signedInUser.email ?? '',
            profilePicture: '');
        await docRef.set(user.toJson());
      }
    } on fb_auth.FirebaseAuthException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  Future<void> logInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      if (loginResult.status == LoginStatus.success) {
        final AccessToken accessToken = loginResult.accessToken!;
        final fb_auth.AuthCredential credential =
            fb_auth.FacebookAuthProvider.credential(accessToken.token);
        final fb_auth.UserCredential userCredential =
            await firebaseAuth.signInWithCredential(credential);
        final fb_auth.User? signedInUser = userCredential.user;
        final docRef = usersRef.doc(signedInUser!.uid);

        final docSnapshot = await docRef.get();

        if (!docSnapshot.exists) {
          User user = User(
            id: signedInUser.uid,
            name: signedInUser.displayName ?? '',
           age: 0,
            email: signedInUser.email ?? '',
            profilePicture: ''
          );
          await docRef.set(user.toJson());
        }
      } else if (loginResult.status == LoginStatus.cancelled) {
        throw const CustomError(
          code: 'Facebook Sign In Cancelled',
          message: 'User cancelled Facebook sign-in',
          plugin: 'flutter_error/facebook_error',
        );
      }
    } on fb_auth.FirebaseAuthException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  Future<void> signUpWithEmail({
    required String name,
 required int age,
    required String email,
    required String password,
  }) async {
    try {
      final fb_auth.UserCredential userCredentail =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final signedInUser = userCredentail.user!;
      User user = User(
        id: signedInUser.uid,
        name: name,
age:age,
        email: email,
        profilePicture: signedInUser.photoURL,
      );
      await usersRef.doc(signedInUser.uid).set(user.toJson());
    } on fb_auth.FirebaseAuthException catch (e) {
      throw CustomError(code: e.code, message: e.message!, plugin: e.plugin);
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  Future<void> logOut() async {
    await firebaseAuth.signOut();
  }
}
