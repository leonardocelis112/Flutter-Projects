import 'package:animation/src/widgets/cat.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  // The Value that are gonna change over time and the function that is gonna
  // change that value
  Animation<double> catAnimation;
  // The actual controller that would give an interface to control the animation
  // like forward, stop, start, reverse
  AnimationController catController;
  Animation<double> boxAnimation;
  AnimationController boxController;

  initState() {
    super.initState();

    // vsync allow to use the TickerProviderStateMixin mixin to treath the
    // Home state to handle the render tick event
    boxController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);

    boxAnimation = Tween(begin: pi * 0.6, end: pi * 0.65).animate(
      CurvedAnimation(
        parent: boxController,
        // Curve of the animation. It is the function that is gonna control
        // the application
        curve: Curves.easeInOut,
      ),
    );

    catController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);

    catAnimation = Tween(begin: -45.0, end: -80.0).animate(
      CurvedAnimation(
        parent: catController,
        curve: Curves.easeIn,
      ),
    );

    // Animations supports status listeners to control the animation
    // in this case we are creating an animation loop
    boxAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        boxController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        boxController.forward();
      }
    });
    boxController.forward();
  }

  // function attached to a Gesture Detector to react when the user taps
  // the box
  onTap() {
    if (catController.status == AnimationStatus.completed) {
      boxController.forward();
      catController.reverse();
    } else if (catController.status == AnimationStatus.dismissed) {
      boxController.stop();
      catController.forward();
    }
  }

  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Animation'),
        ),
        body: GestureDetector(
          child: Center(
            // Stack layout allows to have one component on top of another
            child: Stack(
              overflow: Overflow.visible,
              children: [
                buildCatAnimation(),
                buildBox(),
                buildLeftFlap(),
                buildRightFlap()
              ],
            ),
          ),
          onTap: onTap,
        ));
  }

  Widget buildCatAnimation() {
    // Animated builder to repaint over the animation start or stops
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        // Positioned allow to posion on stacked layouts
        return Positioned(
          child: child,
          // Reference to the property that is beign changed by the animation
          top: catAnimation.value,
          right: 0.0,
          left: 0.0,
        );
      },
      child: Cat(),
    );
  }

  Widget buildBox() {
    return Container(height: 200.0, width: 200.0, color: Colors.brown);
  }

  Widget buildLeftFlap() {
    return Positioned(
      left: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(height: 10.0, width: 125.0, color: Colors.brown),
        builder: (context, child) {
          return Transform.rotate(
            child: child,
            alignment: Alignment.topLeft,
            angle: boxAnimation.value,
          );
        },
      ),
    );
  }

  Widget buildRightFlap() {
    return Positioned(
      right: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(height: 10.0, width: 125.0, color: Colors.brown),
        builder: (context, child) {
          return Transform.rotate(
            child: child,
            alignment: Alignment.topRight,
            angle: -boxAnimation.value,
          );
        },
      ),
    );
  }
}
