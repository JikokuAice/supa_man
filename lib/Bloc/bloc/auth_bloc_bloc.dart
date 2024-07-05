import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supa_man/auth_repo/user_auth.dart';

import 'package:supa_man/model/user_model/Users.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final UserAuth repository;
  AuthBlocBloc({required this.repository}) : super(Unauthenticated()) {
    on<SignIn>(_onSignIn);
  }

  _onSignIn(SignIn event, Emitter<AuthBlocState> emit) async {
    emit(AuthLoading());
    try {
      final add = await repository.Register(event.users);
      emit(RegisterSuccessfull(msg: "Registration sucessfull"));
    } catch (e) {
      emit(RegisterFaliure(messsage: e.toString()));
    }
  }
}
