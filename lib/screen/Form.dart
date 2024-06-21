import 'package:flutter/material.dart';
import 'package:supa_man/repository/supa.dart';

class Forms extends StatelessWidget {
  Forms({super.key});
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _catname = TextEditingController();
  final TextEditingController _catbreed = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _catname,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Give a cat name 😿";
                          }
                          return null;
                        },
                        maxLength: 15,
                        decoration: const InputDecoration(
                            label: Text("Cat Name"),
                            icon: Text(
                              "😺",
                              style: TextStyle(fontSize: 20),
                            )),
                      ),
                      TextFormField(
                        controller: _catbreed,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "enter cat breed name 😼";
                          }
                          return null;
                        },
                        maxLength: 20,
                        decoration: const InputDecoration(
                            label: Text("Cat Breed"),
                            icon: Text(
                              "🐈",
                              style: TextStyle(fontSize: 20),
                            )),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              Supa().insertData(
                                  name: _catname.text, breed: _catbreed.text);
                            }
                            Navigator.pop(context);
                          },
                          child: Text('Click'))
                    ],
                  )),
            )
          ],
        ));
  }
}
