import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supa_man/Bloc/bloc/cat_bloc.dart';
import 'package:supa_man/repository/catRepo.dart';
import 'package:supa_man/repository/connectivity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import './updateForm.dart';

class List extends StatefulWidget {
  const List({super.key, required this.catBloc});
  final CatBloc catBloc;

  @override
  State<List> createState() => _ListState();
}

class _ListState extends State<List> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll); // Load initial data
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      widget.catBloc.add(LoadMore(widget.catBloc.cats.length));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Neighbour Cat List 🐱"),
        centerTitle: true,
      ),
      body: BlocBuilder<CatBloc, CatState>(
        bloc: widget.catBloc,
        builder: (context, state) {
          if (widget.catBloc.cats.isEmpty && state is CatLoading) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is CatError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("error"),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      widget.catBloc.add(LoadCat());
                    },
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            controller: _scrollController,
            itemCount: widget.catBloc.cats.length +
                (widget.catBloc.isLastPage ? 0 : 1),
            itemBuilder: (context, index) {
              if (index >= widget.catBloc.cats.length) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              final cat = widget.catBloc.cats[index];
              return Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: ListTile(
                    tileColor: Color.fromARGB(255, 235, 235, 235),
                    minTileHeight: 80,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    leading: CachedNetworkImage(
                      height: 50,
                      width: 50,
                      imageUrl: cat.image,
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
                        Text("Name: " + cat.name),
                        Text("Breed: " + cat.breed)
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
                                            itemId: cat.id,
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
                                  .add(DeleteCat(cat));
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
          );
        },
      ),
    );
  }
}
