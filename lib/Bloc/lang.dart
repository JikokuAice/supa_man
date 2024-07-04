import 'package:bloc/bloc.dart';

sealed class LangEvent {}

final class ChangeLang extends LangEvent {}

final class RevertLang extends LangEvent {}

class LangBloc extends Bloc<LangEvent, String> {
  LangBloc() : super("en") {
    on<ChangeLang>((event, emit) => emit("npi"));
    on<RevertLang>((event, emit) => emit('en'));
  }

  @override
  void onChange(Change<String> change) {
    super.onChange(change);
    print(change);
  }
}
