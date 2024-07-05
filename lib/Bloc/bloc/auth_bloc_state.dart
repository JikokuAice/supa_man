part of 'auth_bloc_bloc.dart';

sealed class AuthBlocState {}

final class Unauthenticated extends AuthBlocState {}

final class AuthLoading extends AuthBlocState {}

final class RegisterSuccessfull extends AuthBlocState {
  final String msg;
  RegisterSuccessfull({required this.msg});
}

final class RegisterFaliure extends AuthBlocState {
  final String messsage;
  RegisterFaliure({required this.messsage});
}
