import 'dart:async';

import 'package:flappy_bird/barriers.dart';
import 'package:flappy_bird/mybird.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  static double birdYaxis = 0;
  double time = 0;
  double hight = 0;
  double intialHight = birdYaxis;
  bool gameStarted = false;
  static double barrierXone = 1;
  double barrierXtwo = barrierXone + 1.5;

  void jump() {
    time = 0;
    intialHight = birdYaxis;
  }

  void startGame() {
    gameStarted = true;
    Timer.periodic(
      Duration(milliseconds: 80),
      (timer) {
        time += 0.05;
        hight = -4.9 * time * time + 2.8 * time;
        setState(() {
          birdYaxis = intialHight - hight;
        });
        setState(() {
          if (barrierXone < -2) {
            barrierXone += 3;
          } else {
            barrierXone -= 0.5;
          }
        });
        setState(() {
          if (barrierXtwo < -2) {
            barrierXtwo += 3;
          } else {
            barrierXtwo -= 0.5;
          }
        });
        if (birdYaxis > 1) {
          timer.cancel();
          gameStarted = false;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    AnimatedContainer(
                      alignment: Alignment(0, birdYaxis),
                      duration: Duration(microseconds: 0),
                      color: Colors.blue.shade200,
                      child: MyBird(),
                    ),
                    Container(
                      alignment: Alignment(0, -0.2),
                      child:
                          gameStarted ? Text(' ') : Text('T A P  T O  P L A Y'),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXone, 1.1),
                      duration: Duration(microseconds: 0),
                      child: MyBarrier(
                        size: 200.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXone, -1.1),
                      duration: Duration(microseconds: 0),
                      child: MyBarrier(
                        size: 200.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXtwo, 1.1),
                      duration: Duration(microseconds: 0),
                      child: MyBarrier(
                        size: 150.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXtwo, -1.1),
                      duration: Duration(microseconds: 0),
                      child: MyBarrier(
                        size: 250.0,
                      ),
                    )
                  ],
                )),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
                child: Container(
              color: Colors.brown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('SCORE',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      SizedBox(
                        height: 20,
                      ),
                      Text('0',
                          style: TextStyle(color: Colors.white, fontSize: 35)),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('BEST',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      SizedBox(
                        height: 20,
                      ),
                      Text('10',
                          style: TextStyle(color: Colors.white, fontSize: 35)),
                    ],
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
