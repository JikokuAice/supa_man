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
  var _isOnline = true;
  late CatBloc _catBloc;
  @override
  void initState() {
    super.initState();
    _catBloc = CatBloc(repository: Supa());
    _catBloc.add(LoadCat());
    //  updateStatus();
  }

  updateStatus() async {
    _isOnline = await Checkconnectivity().connectionStatus;
    setState(() {
      _isOnline = _isOnline;
    });
    //storing data in hive is we are online so we fetch data from supabase.
    if (_isOnline) {
      storeInLocal();
    }
  }

  Future storeInLocal() async {
    final fetchs = await Supa().fetch();

    for (int i = 0; i < fetchs.length; i++) {
      await Hive.box<Cat>('localStorage').put(i, fetchs[i]);
    }
  }

  Future getLocalData() async {
    return Hive.box<Cat>('localStorage').values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _catBloc,
      child: BlocBuilder<CatBloc, CatState>(
        builder: (context, state) {
          if (state is CatLoading) {
            return const Scaffold(body: ShimmerUI());
          } else if (state is CatLoaded) {
            return Scaffold(
              body: List(value: state.cat.toList()),
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
                child: Text("cat not found 404"),
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
