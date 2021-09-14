part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoginSPSuccess extends AuthState {
  final SPModel spUser;

  AuthLoginSPSuccess({
    required this.spUser,
  });

  // Map<String, dynamic> toMap() {
  //   return {
  //     'spUser': spUser.toMap(),
  //     'srUser': srUser.toMap(),
  //     'userType': userType,
  //   };
  // }

  // factory AuthLoginSuccess.fromMap(Map<String, dynamic> map) {
  //   return AuthLoginSuccess(
  //     spUser: SPModel.fromMap(map['spUser']),
  //     srUser: SRModel.fromMap(map['srUser']),
  //     userType: map['userType'],
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory AuthLoginSuccess.fromJson(String source) => AuthLoginSuccess.fromMap(json.decode(source));

}

class AuthLoginSRSuccess extends AuthState {
  final SRModel srUser;

  AuthLoginSRSuccess({
    required this.srUser,
  });
}

class AuthSignUpSPSuccess extends AuthState {}

class AuthSignUpSRSuccess extends AuthState {}

class AuthForgetSendOTPSuccess extends AuthState {}

class AuthPasswordChangedSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String erroMsg;

  AuthFailure({
    required this.erroMsg,
  });
}
