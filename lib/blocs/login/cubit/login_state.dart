part of 'login_cubit.dart';

enum LogInStatus {
  initial,
  submitting,
  success,
  error,
}

class LogInState extends Equatable {
  final LogInStatus logInStatus;
  final CustomError error;

  const LogInState({
    required this.logInStatus,
    required this.error,
  });

  factory LogInState.initial() {
    return const LogInState(
      logInStatus: LogInStatus.initial,
      error: CustomError(),
    );
  }

  @override
  String toString() =>
      'LogInState(LogInStatus: $LogInStatus, error: $error)';

  @override
  List<Object?> get props => [logInStatus, error];

  LogInState copyWith({
    LogInStatus? logInStatus,
    CustomError? error,
  }) {
    return LogInState(
      logInStatus: logInStatus ?? this.logInStatus,
      error: error ?? this.error,
    );
  }
}