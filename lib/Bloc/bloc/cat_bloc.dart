import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:supa_man/model/cat.dart';
import 'package:supa_man/repository/catRepo.dart';
import 'package:dartz/dartz.dart';
import 'package:supa_man/main.dart';
part 'cat_event.dart';

part 'cat_state.dart';

class CatBloc extends Bloc<CatEvent, CatState> {
  final Supa repository;

  final hive = Hive.box<Cat>("localStorage");
// calling Bloc class giving initial state
  CatBloc({required this.repository}) : super(CatInitial()) {
    // event handling
    on<LoadCat>(_onLoadCat);
    on<AddCat>(_onAddCat);
    on<UpdateCat>(_onUpdateCat);
    on<DeleteCat>(_onDeleteCat);
  }

  _onLoadCat(LoadCat event, Emitter<CatState> emit) async {
    emit(CatLoading());
    try {
      final fetch = await repository.fetch(page: event.page);
      fetch.forEach((e) async {
        await hive.put(e.id, e);
      });
      emit(CatLoaded(hive.values.toList()));
    } catch (e) {
      emit(CatError(e.toString()));
    }
  }

  _onAddCat(AddCat event, Emitter<CatState> emit) async {
    emit(AddingCat());
    try {
      final add = await repository.insertData(event.cat);
      final fetch = await repository.fetch();
      emit(CatLoaded(fetch));
    } catch (e) {
      emit(CatError(e.toString()));
    }
  }

  _onUpdateCat(UpdateCat event, Emitter<CatState> emit) async {
    emit(UpdatingCat());
    try {
      final update = await repository.update(event.cat);
      hive.put(event.cat.id, event.cat);
      emit(CatLoaded(hive.values.toList()));
    } catch (e) {
      emit(CatError(e.toString()));
    }
  }

  _onDeleteCat(DeleteCat event, Emitter<CatState> emit) async {
    emit(DeletingCat());
    try {
      final delete = await repository.delete(event.cat);
      hive.delete(event.cat.id);
      print(hive.containsKey(event.cat.id));
      emit(CatLoaded(hive.values.toList()));
    } catch (e) {
      emit(CatError(e.toString()));
    }
  }
}
