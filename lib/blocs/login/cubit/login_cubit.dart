import 'package:bloc/bloc.dart';
import 'package:book_mate/blocs/auth/repository/auth_repository.dart';
import 'package:book_mate/models/custom_error.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LogInCubit extends Cubit<LogInState> {
  final AuthRepository authRepository;
  LogInCubit({
    required this.authRepository,
  }) : super(LogInState.initial());

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(
      logInStatus: LogInStatus.submitting,
    ));
    try {
      await authRepository.logInWithEmail(email: email, password: password);
      emit(state.copyWith(
        logInStatus: LogInStatus.success,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(logInStatus: LogInStatus.error, error: e));
    }
  }

  Future<void> logInWithGoogle() async {
    emit(state.copyWith(
      logInStatus:LogInStatus.submitting,
    ));
    try {
      await authRepository.logInWithGoogle();
      emit(state.copyWith(
        logInStatus: LogInStatus.success,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(logInStatus: LogInStatus.error, error: e));
    }
  }

  Future<void> logInWithTwitter() async {
    emit(state.copyWith(
      logInStatus: LogInStatus.submitting,
    ));
    try {
      await authRepository.logInWithTwitter();
      emit(state.copyWith(
        logInStatus: LogInStatus.success,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(logInStatus: LogInStatus.error, error: e));
    }
  }

  Future<void> logInWithFacebook() async {
    emit(state.copyWith(
      logInStatus: LogInStatus.submitting,
    ));
    try {
      await authRepository.logInWithFacebook();
      emit(state.copyWith(
        logInStatus: LogInStatus.success,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(logInStatus: LogInStatus.error, error: e));
    }
  }
}