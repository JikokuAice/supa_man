import 'package:flutter/material.dart';
import 'package:supa_man/repository/catRepo.dart';
import 'package:supa_man/repository/connectivity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import './updateForm.dart';

class List extends StatefulWidget {
  const List({super.key, required this.value});

  final dynamic value;

  @override
  State<List> createState() => _ListState();
}

class _ListState extends State<List> {
  final ScrollController _scrollController = ScrollController();
  final _cat = [];

  int page = 1;
  int screen = 10;
  bool _isloading = false;

  @override
  void initState() {
    super.initState();
    widget.value.forEach((e) => {_cat.add(e)});
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      loadMore();
    }
  }

  loadMore() async {
    if (_isloading) return;
    setState(() {
      _isloading = true;
    });
    page++;
    final data = await Supa().fetch(page: page, screen: screen);
    setState(() {
      _cat.addAll(data);
      _isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 60,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Neighbour Cat List 🐱",
                style: TextStyle(fontSize: 32),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                controller: _scrollController,
                itemCount: _cat.length,
                itemBuilder: (context, int i) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: ListTile(
                        tileColor: Color.fromARGB(255, 235, 235, 235),
                        minTileHeight: 80,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color: Colors.white),
                            borderRadius: BorderRadius.circular(10)),
                        leading: CachedNetworkImage(
                          height: 50,
                          width: 50,
                          imageUrl: _cat[i].image,
                          fit: BoxFit.cover,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  LinearProgressIndicator(
                            color: Colors.black,
                            value: downloadProgress.progress,
                            backgroundColor: Colors.white,
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Name: " + _cat[i].name),
                            Text("Breed: " + _cat[i].breed)
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
                                      bool isOnline = await Checkconnectivity()
                                          .connectionStatus;
                                      if (!isOnline) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "you are offline cant update items")));
                                        return;
                                      }
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Updateitem(
                                                    itemName:
                                                        widget.value[i].name,
                                                  )));
                                    },
                                    icon: const Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () async {
                                      bool isOnline = await Checkconnectivity()
                                          .connectionStatus;
                                      if (!isOnline) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "you are offline cant delete items")));
                                        return;
                                      }

                                      await Supa()
                                          .delete(list: widget.value[i]);
                                      setState(() {
                                        //optimistic UI update
                                        //also removing item from locally
                                        widget.value.removeAt(i);
                                      });
                                    },
                                    icon: const Icon(Icons.delete_forever)),
                              ],
                            )),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
