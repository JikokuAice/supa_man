part of 'auth_bloc_bloc.dart';

sealed class AuthBlocEvent extends Equatable {
  const AuthBlocEvent();

  @override
  List<Object> get props => [];
}

final class SignIn extends AuthBlocEvent {
  final Users users;
  const SignIn({required this.users});
}
