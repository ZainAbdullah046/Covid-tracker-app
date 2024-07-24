import 'dart:async';

import 'package:covid_tracker_app/screens/Home.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<splash> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 4),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
              animation: _controller,
              child: Container(
                height: 200,
                width: 200,
                child: Center(child: Image.asset("images/covid.jpg")),
              ),
              builder: (BuildContext context, Widget? child) {
                return Transform.rotate(
                  angle: _controller.value * 2.0 * math.pi,
                  child: child,
                );
              }),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          const Align(
              alignment: Alignment.center,
              child: Text(
                "Covid 19 \n Tracker App",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
        ],
      )),
    );
  }
}
