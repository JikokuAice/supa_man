import 'dart:io';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:supa_man/repository/connectivity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../repository/catRepo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class Forms extends StatefulWidget {
  const Forms({super.key});

  @override
  State<Forms> createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  File? _image;
  final _formkey = GlobalKey<FormState>();
  final supabase = Supabase.instance.client;

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
                      OutlinedButton(
                        onPressed: () {
                          getImage();
                        },
                        child: const Text("Select Image"),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            bool isOnline =
                                await Checkconnectivity().connectionStatus;
                            if (!isOnline) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Cant insert data you are offline 📴")));
                              return;
                            }
                            setState(() {
                              uploadAndSave();
                            });
                          },
                          child: const Text('Confirm'))
                    ],
                  )),
            )
          ],
        ));
  }

  void getImage() async {
    final xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xFile == null) {
      return;
    }
    setState(() {
      _image = File(xFile.path);
    });
  }

  Future<void> uploadAndSave() async {
    if (_image == null) return;
    final filename =
        '${DateTime.now().millisecondsSinceEpoch}${path.extension(_image!.path)}';

    final upload = await supabase.storage.from('imgs').upload(
          filename,
          _image!,
        );

    final _imageUrl =
        await supabase.storage.from('imgs').getPublicUrl(filename);

    await uploadFormDetail(_imageUrl);
  }

  Future uploadFormDetail(String imageUrl) async {
    final upload = await Supa().insertData(
        name: _catbreed.text, breed: _catbreed.text, image: imageUrl);

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All data uploaded sucessfully")));
  }
}
