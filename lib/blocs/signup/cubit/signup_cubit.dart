import 'package:bloc/bloc.dart';
import 'package:book_mate/blocs/auth/repository/auth_repository.dart';
import 'package:book_mate/models/custom_error.dart';
import 'package:equatable/equatable.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository authRepository;
  SignUpCubit({required this.authRepository}) : super(SignUpState.initial());

  Future<void> signUp({
    required String name,
    required String age,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(signUpStatus: SignUpStatus.submitting));
    try {
      await authRepository.signUpWithEmail(
          name: name, age: int.parse(age), email: email, password: password);
      emit(state.copyWith(signUpStatus: SignUpStatus.success));
    } on CustomError catch (e) {
      emit(state.copyWith(signUpStatus: SignUpStatus.error, error: e));
    }
  }


  Future<void> signUpWithGoogle() async {
    emit(state.copyWith(
      signUpStatus: SignUpStatus.submitting,
    ));
    try {
      await authRepository.logInWithGoogle();
      emit(state.copyWith(
        signUpStatus: SignUpStatus.success,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(signUpStatus: SignUpStatus.error, error: e));
    }
  }

  Future<void> signUpWithTwitter() async {
    emit(state.copyWith(
      signUpStatus: SignUpStatus.submitting,
    ));
    try {
      await authRepository.logInWithTwitter();
      emit(state.copyWith(
        signUpStatus: SignUpStatus.success,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(signUpStatus: SignUpStatus.error, error: e));
    }
  }

  Future<void> signUpWithFacebook() async {
    emit(state.copyWith(
      signUpStatus: SignUpStatus.submitting,
    ));
    try {
      await authRepository.logInWithFacebook();
      emit(state.copyWith(
        signUpStatus: SignUpStatus.success,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(signUpStatus: SignUpStatus.error, error: e));
    }
  }
}
