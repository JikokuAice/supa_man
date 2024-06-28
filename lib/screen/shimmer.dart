import 'package:flutter/material.dart';
import 'package:supa_man/screen/components/shimmerComponent.dart';

class ShimmerUI extends StatefulWidget {
  const ShimmerUI({super.key});

  @override
  State<ShimmerUI> createState() => _ShimmerUIState();
}

class _ShimmerUIState extends State<ShimmerUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title:  const Text(
                "Neighbour Cat List 🐱",
                style: TextStyle(fontSize: 32),
              ),),
        body: Padding(
            padding: EdgeInsets.only(top: 60, left: 10, right: 10),
            child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, int i) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: ListTile(
                      minTileHeight: 80,
                      tileColor:const Color.fromARGB(255, 235, 235, 235),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      leading: const CustomShimmer(
                          height: 50,
                          width: 50,
                          radius: 1,
                          main: Colors.grey,
                          highlight: Colors.white10),
                      title: const CustomShimmer(
                          height: 10,
                          width: 12,
                          radius: 5,
                          main: Colors.grey,
                          highlight: Colors.white10),
                      subtitle: const CustomShimmer(
                          height: 10,
                          width: 12,
                          radius: 5,
                          main: Colors.grey,
                          highlight: Colors.white10),
                      trailing: const SizedBox(
                        width: 80,
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: CustomShimmer(
                                  height: 30,
                                  width: 30,
                                  radius: 10,
                                  main: Colors.grey,
                                  highlight: Colors.grey),
                            ),
                            CustomShimmer(
                                height: 30,
                                width: 30,
                                radius: 10,
                                main: Colors.grey,
                                highlight: Colors.grey)
                          ],
                        ),
                      ),
                    ),
                  );
                })));
  }
}
