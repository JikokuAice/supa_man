import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supa_man/Bloc/bloc/cat_bloc.dart';
import 'package:supa_man/Bloc/lang.dart';
import 'package:supa_man/model/cat.dart';
import 'package:supa_man/repository/catRepo.dart';
import 'package:supa_man/repository/connectivity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import './updateForm.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:intl/intl.dart';

class Lists extends StatefulWidget {
  const Lists(
      {super.key,
      required this.catBloc,
      required this.items,
      this.scrollController});
  final CatBloc catBloc;
  final List<Cat> items;
  final ScrollController? scrollController;

  @override
  State<Lists> createState() => _ListState();
}

class _ListState extends State<Lists> {
  final TextEditingController _searchController = TextEditingController();
  late List<Cat> filteredItems;
  bool _isSerching = false;
  bool _ascending = false;
  late String sort;

  @override
  initState() {
    super.initState();
    filteredItems = widget.items;
    sort = "name";
    _sort(sort, true);
  }

//query is equivalent to list name or it's other property.
  void _filterItems(String query) {
    setState(() {
      filteredItems = widget.items
          .where((e) => e.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      print(filteredItems);
    });
  }

  void _sort(String key, bool ascends) {
    setState(() {
      _ascending = ascends;
      sort = key;
      filteredItems.sort(
        (a, b) {
          if (key == "name") {
            return _ascending
                ? a.name.compareTo(b.name)
                : b.name.compareTo(a.name);
          } else if (key == "breed") {
            return _ascending
                ? a.breed.compareTo(b.breed)
                : b.breed.compareTo(a.name);
          } else {
            return 0;
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LangBloc, String>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: GestureDetector(
                    onTap: () {
                      _showDialog();
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.black, width: 2))),
                      child: Column(
                        children: [
                          Text(state),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(Icons.language)
                        ],
                      ),
                    )),
              ),
              title: _isSerching
                  ? TextField(
                      controller: _searchController,
                      onChanged: _filterItems,
                      decoration: const InputDecoration(
                          hintText: "Item(वस्तु) Name(नाम)"),
                    )
                  : Localizations.override(
                      context: context,
                      locale: Locale(state),
                      child: Builder(
                          builder: (context) => Text(
                              AppLocalizations.of(context)!.neighbourCatList))),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        _isSerching = !_isSerching;
                        if (!_isSerching) {
                          _searchController.clear();
                          _filterItems("");
                        }
                      });
                    },
                    icon: _isSerching ? Icon(Icons.clear) : Icon(Icons.search)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        showSortList(state);
                      });
                    },
                    icon: Icon(Icons.sort))
              ],
            ),
            body: ListView.builder(
              controller: widget.scrollController,
              itemCount: filteredItems.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: ListTile(
                      tileColor: Color.fromARGB(255, 222, 222, 222),
                      minTileHeight: 80,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      leading: CachedNetworkImage(
                        height: 50,
                        width: 50,
                        imageUrl: filteredItems[i].image,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                LinearProgressIndicator(
                          color: Colors.black,
                          value: downloadProgress.progress,
                          backgroundColor: Colors.white,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Localizations.override(
                                  context: context,
                                  locale: Locale(state),
                                  child: Builder(
                                      builder: (context) => Text(
                                          "${AppLocalizations.of(context)!.name}: "))),
                              Text(filteredItems[i].name),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Localizations.override(
                                  context: context,
                                  locale: Locale(state),
                                  child: Builder(
                                      builder: (context) => Text(
                                          "${AppLocalizations.of(context)!.breed}: "))),
                              Text(filteredItems[i].breed),
                            ],
                          )
                        ],
                      ),
                      trailing: SizedBox(
                        width: 100,
                        height: 100,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () async {
                                bool isOnline =
                                    await Checkconnectivity().connectionStatus;
                                if (!isOnline) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "you are offline cant update items")));
                                  return;
                                }

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Updateitem(
                                              itemId: widget.items[i].id!,
                                              catBloc: widget.catBloc,
                                            )));
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () async {
                                bool isOnline =
                                    await Checkconnectivity().connectionStatus;
                                if (!isOnline) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "you are offline cant delete items")));
                                  return;
                                }

                                BlocProvider.of<CatBloc>(context)
                                    .add(DeleteCat(widget.items[i]));
                              },
                              icon: const Icon(Icons.delete_forever),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ));
      },
    );
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Choose Language"),
              actions: [
                MaterialButton(
                  onPressed: () {
                    context.read<LangBloc>().add(RevertLang());
                    Navigator.of(context).pop();
                  },
                  child: Text("English"),
                ),
                MaterialButton(
                  onPressed: () {
                    context.read<LangBloc>().add(ChangeLang());
                    Navigator.of(context).pop();
                  },
                  child: Text("Nepali"),
                ),
              ],
            ));
  }

  void showSortList(String state) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Localizations.override(
              context: context,
              locale: Locale(state),
              child: Builder(
                builder: (context) => Text(
                  " ${AppLocalizations.of(context)!.sort}",
                ),
              ),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Container(
              height: 300,
              width: 200,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      _sort("name", false);
                    },
                    child: Container(
                      color: const Color.fromARGB(255, 235, 235, 235),
                      height: 40,
                      width: double.infinity,
                      child: Center(
                        child: Localizations.override(
                          context: context,
                          locale: Locale(state),
                          child: Builder(
                            builder: (context) => Text(
                              " ${AppLocalizations.of(context)!.name_asc}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ), //

                  const SizedBox(
                    height: 30,
                  ),
                  //
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      _sort("name", true);
                    },
                    child: Container(
                      color: const Color.fromARGB(255, 235, 235, 235),
                      height: 40,
                      width: double.infinity,
                      child: Center(
                        child: Localizations.override(
                          context: context,
                          locale: Locale(state),
                          child: Builder(
                            builder: (context) => Text(
                              " ${AppLocalizations.of(context)!.name_desc}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  //
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      _sort("breed", true);
                    },
                    child: Container(
                      color: const Color.fromARGB(255, 235, 235, 235),
                      height: 40,
                      width: double.infinity,
                      child: Center(
                        child: Localizations.override(
                          context: context,
                          locale: Locale(state),
                          child: Builder(
                            builder: (context) => Text(
                              " ${AppLocalizations.of(context)!.breed_asc}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  //
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      _sort("breed", false);
                    },
                    child: Container(
                      color: const Color.fromARGB(255, 235, 235, 235),
                      height: 40,
                      width: double.infinity,
                      child: Center(
                        child: Localizations.override(
                          context: context,
                          locale: Locale(state),
                          child: Builder(
                            builder: (context) => Text(
                              " ${AppLocalizations.of(context)!.breed_desc}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
