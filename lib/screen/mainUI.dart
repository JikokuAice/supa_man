import 'package:flutter/material.dart';
import 'package:supa_man/screen/List.dart';
import '../repository/catRepo.dart';

import 'Form.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Supa().fetch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    _reload(context);
                  },
                  child: Icon(Icons.add),
                ),
                body:List(value: snapshot.data));
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
