part of 'cat_bloc.dart';

@immutable
sealed class CatEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadCat extends CatEvent {
  final int page;
  LoadCat({required this.page});
  @override
  List<Object> get props => [page];
}

class AddCat extends CatEvent {
  final Cat cat;
  AddCat(this.cat);
}

class UpdateCat extends CatEvent {
  final Cat cat;
  UpdateCat(this.cat);
}

class DeleteCat extends CatEvent {
  final Cat cat;
  DeleteCat(this.cat);
}

