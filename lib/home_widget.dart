import 'dart:math';

import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeWidget();
  }
}

class _HomeWidget extends State<HomeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))..addStatusListener((status) {
          if(status==AnimationStatus.completed){
            _animationController.reset();
            _animationController.forward();
          }
        });

    _animation = Tween<double>(begin: 0.0, end: 4.0).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInCirc));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void _controllerStart() {
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: _controllerStart,
      child: Scaffold(backgroundColor: Colors.black,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              child: RotationTransition(
                filterQuality: FilterQuality.high,
                turns: Tween<double>(begin: 0.0, end: 1)
                    .animate(_animationController),
                child: UnconstrainedBox(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                    height: height,width: width,
                      alignment: AlignmentDirectional.center,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.amber,
                          gradient: SweepGradient(
                              center: Alignment.center,
                              colors: [Colors.black, Colors.white, Colors.black],
                              stops: <double>[.2, .65, .20])),
                    ),
                  ),
                ),
              ),
            ),
            const Positioned(
                left: 650,
                top: 80,
                child: Text(
                  'Day',
                  style: TextStyle(
                      color: Colors.black,
                     fontSize: 30,
                      fontWeight: FontWeight.bold),
                )),
                 const Positioned(
                left: 650,
                top: 580,
                child: Text(
                  'Night',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                )),
      
          ],
        ),
        )
    );
  }
}
