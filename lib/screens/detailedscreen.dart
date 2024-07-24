import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Assuming this is the definition of the 'Use' widget
class Use extends StatelessWidget {
  final String title;
  final int value;

  const Use({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Text(value.toString()),
    );
  }
}

class Detailedscreen extends StatefulWidget {
  final String image;
  final String name;
  final int totalCases;
  final int totalDeaths;
  final int totalRecovered;
  final int active;

  Detailedscreen({
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
  });

  @override
  State<Detailedscreen> createState() => _DetailedscreenState();
}

class _DetailedscreenState extends State<Detailedscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Card(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              color: Colors.grey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.black,
                    backgroundImage: NetworkImage(widget.image),
                  ),
                  Use(
                    title: "Total",
                    value: widget.totalCases,
                  ),
                  Use(
                    title: "Recovered",
                    value: widget.totalRecovered,
                  ),
                  Use(
                    title: "Deaths",
                    value: widget.totalDeaths,
                  ),
                  Use(
                    title: "Active",
                    value: widget.active,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
