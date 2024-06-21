import 'package:flutter/material.dart';

class List extends StatelessWidget {
  const List({super.key, required this.value});

  final dynamic value;

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
                itemCount: value.length,
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
                          leading: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                image: DecorationImage(
                                    image: NetworkImage(value[i].image),
                                    fit: BoxFit.cover)),
                          ),
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Name: " + value[i].name),
                              Text("Breed: " + value[i].Breed)
                            ],
                          )),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
