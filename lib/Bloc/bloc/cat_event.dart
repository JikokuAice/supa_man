part of 'cat_bloc.dart';

@immutable
sealed class CatEvent {}

class LoadCat extends CatEvent {}

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
