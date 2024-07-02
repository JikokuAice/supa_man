import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supa_man/Bloc/bloc/cat_bloc.dart';
import 'package:supa_man/model/cat.dart';
import 'package:supa_man/repository/connectivity.dart';
import 'package:supa_man/repository/local.dart';
import 'package:supa_man/screen/List.dart';
import 'package:supa_man/screen/shimmer.dart';
import '../repository/catRepo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'Form.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late CatBloc _catBloc;
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  int _page = 1;

  @override
  void initState() {
    super.initState();
    _catBloc = CatBloc(repository: Supa());
    _scrollController.addListener(_onScroll);
    _catBloc.add(LoadCat(page: 1));
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetchNextPage();
    }
  }

  _fetchNextPage() {
    if (!_isLoading) {
      _isLoading = true;
      _page++;
      _catBloc.add(LoadCat(page: _page));
    }
  }

  @override
  void dispose() {
    _catBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _catBloc,
      child: BlocBuilder<CatBloc, CatState>(
        builder: (context, state) {
          if (state is CatLoading) {
            return const Scaffold(body: ShimmerUI());
          } else if (state is DeletingCat) {
            return const Scaffold(body: ShimmerUI());
          } else if (state is AddingCat) {
            return const Scaffold(body: ShimmerUI());
          } else if (state is UpdatingCat) {
            return const Scaffold(body: ShimmerUI());
          } else if (state is CatLoaded) {
            return Scaffold(
              body: List(
                items: state.cat.toList(),
                catBloc: _catBloc,
                scrollController: _scrollController,
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Forms(
                                catBloc: _catBloc,
                              )));
                },
                child: Icon(Icons.add),
              ),
            );
          } else if (state is CatError) {
            return Scaffold(
              body: Center(child: Text("${state.msg}")),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: Text("Cat not found"),
              ),
            );
          }
        },
      ),
    );
  }

  Future _reload(BuildContext context) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Forms(
                  catBloc: _catBloc,
                )));
    setState(() {});
  }
}
