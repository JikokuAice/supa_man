import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supa_man/Bloc/bloc/cat_bloc.dart';
import 'package:supa_man/repository/catRepo.dart';
import 'package:supa_man/repository/connectivity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import './updateForm.dart';

class List extends StatefulWidget {
  const List(
      {super.key,
      required this.catBloc,
      required this.items,
      this.scrollController});
  final CatBloc catBloc;
  final items;
  final ScrollController? scrollController;

  @override
  State<List> createState() => _ListState();
}

class _ListState extends State<List> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Neighbour Cat List 🐱"),
          centerTitle: true,
        ),
        body: ListView.builder(
          controller: widget.scrollController,
          itemCount: widget.items.length,
          itemBuilder: (context, i) {
            return Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: ListTile(
                  tileColor: Color.fromARGB(255, 179, 145, 145),
                  minTileHeight: 80,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  leading: CachedNetworkImage(
                    height: 50,
                    width: 50,
                    imageUrl: widget.items[i].image,
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Name: " + widget.items[i].name),
                      Text("Breed: " + widget.items[i].breed)
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
                                          itemId: widget.items[i].id,
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
  }
}
