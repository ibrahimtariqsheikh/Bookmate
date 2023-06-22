// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'signup_cubit.dart';

enum SignUpStatus {
  initial,
  submitting,
  success,
  error,
}

class SignUpState extends Equatable {
  final SignUpStatus signUpStatus;
  final CustomError error;

  const SignUpState(
      {required this.signUpStatus,
      required this.error});

  @override
  List<Object> get props => [signUpStatus, error];

  factory SignUpState.initial() {
    return const SignUpState(
      signUpStatus: SignUpStatus.initial,
      error: CustomError(),
    );
  }

  @override
  bool get stringify => true;

  SignUpState copyWith({
    SignUpStatus? signUpStatus,
    String? selectedGender,
    CustomError? error,
  }) {
    return SignUpState(
      signUpStatus: signUpStatus ?? this.signUpStatus,
      error: error ?? this.error,
    );
  }
}