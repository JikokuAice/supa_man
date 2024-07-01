part of 'cat_bloc.dart';

@immutable
sealed class CatEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadCat extends CatEvent {}

class LoadMore extends CatEvent {
  final int index;
  LoadMore(this.index);
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
