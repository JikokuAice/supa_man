import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supa_man/Bloc/bloc/cat_bloc.dart';
import 'package:supa_man/Bloc/lang.dart';
import 'package:supa_man/model/cat.dart';
import 'package:supa_man/repository/catRepo.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class Updateitem extends StatefulWidget {
  const Updateitem({super.key, required this.itemId, required this.catBloc});
  final int itemId;
  final CatBloc catBloc;
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
    return BlocBuilder<LangBloc, String>(
      builder: (context, state) {
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
                            decoration: InputDecoration(
                                label: Localizations.override(
                                    context: context,
                                    locale: Locale(state),
                                    child: Builder(builder: (context) {
                                      return Row(
                                        children: [
                                          Text(AppLocalizations.of(context)!
                                                  .cat +
                                              " "),
                                          Text(AppLocalizations.of(context)!
                                              .name)
                                        ],
                                      );
                                    })),
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
                            decoration: InputDecoration(
                                label: Localizations.override(
                                    context: context,
                                    locale: Locale(state),
                                    child: Builder(builder: (context) {
                                      return Row(
                                        children: [
                                          Text(AppLocalizations.of(context)!
                                                  .cat +
                                              " "),
                                          Text(AppLocalizations.of(context)!
                                              .breed)
                                        ],
                                      );
                                    })),
                                icon: Text(
                                  "🐈✏️",
                                  style: TextStyle(fontSize: 20),
                                )),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                upgrade(widget.itemId);
                              },
                              child: const Text('Update'))
                        ],
                      )),
                )
              ],
            ));
      },
    );
  }

  String? _validateOne() {
    if (_updateCatBreed.text.isEmpty && _updateCatName.text.isEmpty) {
      return "at least one field should required";
    } else {
      return null;
    }
  }

  Future upgrade(int item) async {
    if (_formkey.currentState!.validate()) {
      var cat =
          Cat(breed: _updateCatBreed.text, name: _updateCatName.text, id: item);
      widget.catBloc.add(UpdateCat(cat));
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
