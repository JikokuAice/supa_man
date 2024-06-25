import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supa_man/model/cat.dart';
import 'package:supa_man/repository/connectivity.dart';
import 'package:supa_man/repository/local.dart';
import 'package:supa_man/screen/List.dart';
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
  @override
  void initState() {
    super.initState();
    updateStatus();
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
    return FutureBuilder(
        future: _isOnline ? Supa().fetch() : getLocalData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    _reload(context);
                  },
                  child: const Icon(Icons.add),
                ),
                body: List(value: snapshot.data));
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text(snapshot.error.toString()),
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  Future _reload(BuildContext context) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => Forms()));
    setState(() {});
  }
}
