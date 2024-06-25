import 'package:flutter/material.dart';
import 'package:supa_man/repository/catRepo.dart';


class Updateitem extends StatefulWidget {
  const Updateitem({super.key, required this.itemName});
  final itemName;
  @override
  State<Updateitem> createState() => _UpdateitemState();

}

class _UpdateitemState extends State<Updateitem> {
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
                            if (_formkey.currentState!.validate()) {
                              if (widget.itemName == null) return;
                              Supa().update(widget.itemName,
                                  _updateCatName.text, _updateCatBreed.text);

                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('item updated Sucessfully')));
                            }
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
}
