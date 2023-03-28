// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stopwatch(),
    );
  }
}

class Stopwatch extends StatefulWidget {
  const Stopwatch({super.key});

  @override
  State<Stopwatch> createState() => _StopwatchState();
}

class _StopwatchState extends State<Stopwatch> {
  Timer? reFunc;
  Duration duration = Duration(seconds: 0);

  startTimer() {
    reFunc = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        int newSec = duration.inSeconds + 1;
        duration = Duration(seconds: newSec);
      });
    });
  }

  bool isRunning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        elevation: 9,
        backgroundColor: Colors.grey[900],
        centerTitle: true,
        title: Text("Stop Watch",
            style: TextStyle(color: Colors.white, fontSize: 30)),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(11)),
                      child: Text(
                        duration.inHours.toString().padLeft(2, "0"),
                        style: TextStyle(fontSize: 80, color: Colors.grey[900]),
                      ),
                    ),
                    SizedBox(height: 22),
                    Text("Hours",
                        style: TextStyle(fontSize: 22, color: Colors.white)),
                    SizedBox(height: 22),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(11)),
                      child: Text(
                        duration.inMinutes
                            .remainder(60)
                            .toString()
                            .padLeft(2, "0"),
                        style: TextStyle(fontSize: 80, color: Colors.grey[900]),
                      ),
                    ),
                    SizedBox(height: 22),
                    Text("Minutes",
                        style: TextStyle(fontSize: 22, color: Colors.white)),
                    SizedBox(height: 22),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(11)),
                      child: Text(
                        duration.inSeconds
                            .remainder(60)
                            .toString()
                            .padLeft(2, "0"),
                        style: TextStyle(fontSize: 80, color: Colors.grey[900]),
                      ),
                    ),
                    SizedBox(height: 22),
                    Text("Seconds",
                        style: TextStyle(fontSize: 22, color: Colors.white)),
                    SizedBox(height: 22),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            isRunning
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            if (reFunc!.isActive) {
                              setState(() {
                                reFunc!.cancel();
                              });
                            } else {
                              startTimer();
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.red),
                              padding:
                                  MaterialStatePropertyAll(EdgeInsets.all(14)),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(9)))),
                          child: Text(
                            (reFunc!.isActive) ? "Stop timer" : "Resume",
                            style: TextStyle(fontSize: 19),
                          )),
                      SizedBox(width: 22),
                      ElevatedButton(
                          onPressed: () {
                            reFunc!.cancel();
                            setState(() {
                              isRunning = false;
                              duration = Duration(seconds: 0);
                            });
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.red),
                              padding:
                                  MaterialStatePropertyAll(EdgeInsets.all(14)),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(9)))),
                          child: Text(
                            "Cancel",
                            style: TextStyle(fontSize: 19),
                          )),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            startTimer();
                            setState(() {
                              isRunning = true;
                            });
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.blue),
                              padding:
                                  MaterialStatePropertyAll(EdgeInsets.all(14)),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(9)))),
                          child: Text(
                            "Start timer",
                            style: TextStyle(fontSize: 19),
                          )),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
