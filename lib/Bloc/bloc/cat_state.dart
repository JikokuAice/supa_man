part of 'cat_bloc.dart';

@immutable
sealed class CatState {}

//cat fetching state
final class CatInitial extends CatState {}

final class CatLoading extends CatState {}

final class CatLoaded extends CatState {
  final cat;
  CatLoaded(this.cat);
}

final class CatError extends CatState {
  final String msg;
  CatError(this.msg);
}

//cat adding state

final class AddingCat extends CatState {}

final class AddedCat extends CatState {
  final Cat cat;
  AddedCat(this.cat);
}

// cat updating State

final class UpdatingCat extends CatState {}

final class UpdatedCat extends CatState {
  final Cat cat;
  UpdatedCat(this.cat);
}

// cat deleting State

final class DeletingCat extends CatState {}

final class DeletedCat extends CatState {
  final Cat cat;
  DeletedCat(this.cat);
}

