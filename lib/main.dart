import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:supa_man/Bloc/bloc/cat_bloc.dart';
import 'package:supa_man/repository/catRepo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import "./screen/mainUI.dart";
import 'package:hive_flutter/hive_flutter.dart';
import './model/cat.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: 'https://lqevkoivmmqwzumdfgef.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxxZXZrb2l2bW1xd3p1bWRmZ2VmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTg4NjExNDMsImV4cCI6MjAzNDQzNzE0M30.QYnGKTBuyUjFFGGcJmCH-CABN4mcKndOc2hzw12SU_M');

  await Hive.initFlutter();
  Hive.registerAdapter(CatAdapter());
  await Hive.openBox<Cat>("localStorage");

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
          create: (BuildContext context) => CatBloc(repository: Supa()))
    ],
    child: const MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ),
  ));
}
