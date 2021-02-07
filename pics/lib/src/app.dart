// Import flutter helper library
import 'package:flutter/material.dart';

// Create a class that will be our custom widget
// Must extend stateless class

class App extends StatefulWidget {
  @override
  State<App> createState() {
    // TODO: implement createState
    return AppState();
  }
}

class AppState extends State<App> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Let's see some images!"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              counter += 1;
            });
          },
          child: Icon(Icons.add),
        ),
        body: Text('$counter'),
      ),
    );
    ;
  }
}

// Must define the build widget
