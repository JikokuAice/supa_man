import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supa_man/Bloc/bloc/cat_bloc.dart';
import 'package:supa_man/model/cat.dart';
import 'package:supa_man/repository/catRepo.dart';

class Updateitem extends StatefulWidget {
  const Updateitem({super.key, required this.itemName});
  final String itemName;
  @override
  State<Updateitem> createState() => _UpdateitemState();
}

class _UpdateitemState extends State<Updateitem> {
  @override
  final _formkey = GlobalKey<FormState>();
  final _updateCatName = TextEditingController();
  final _updateCatBreed = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context, true);
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
                        controller: _updateCatName,
                        validator: (value) {
                          return _validateOne();
                        },
                        maxLength: 15,
                        decoration: const InputDecoration(
                            label: Text("Update Cat Name"),
                            icon: Text(
                              "😺✏️",
                              style: TextStyle(fontSize: 20),
                            )),
                      ),
                      TextFormField(
                        controller: _updateCatBreed,
                        validator: (value) {
                          return _validateOne();
                        },
                        maxLength: 20,
                        decoration: const InputDecoration(
                            label: Text("Update cat Breed"),
                            icon: Text(
                              "🐈✏️",
                              style: TextStyle(fontSize: 20),
                            )),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            upgrade(widget.itemName);
                          },
                          child: const Text('Update'))
                    ],
                  )),
            )
          ],
        ));
  }

  String? _validateOne() {
    if (_updateCatBreed.text.isEmpty && _updateCatName.text.isEmpty) {
      return "at least one field should required";
    } else {
      return null;
    }
  }

  Future upgrade(String item) async {
    if (_formkey.currentState!.validate()) {
      var cat = Cat(breed: _updateCatBreed.text, name: _updateCatName.text);
      BlocProvider.of<CatBloc>(context).add(UpdateCat(cat));
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _updateCatName.dispose();
    _updateCatBreed.dispose();
    super.dispose();
  }
}
