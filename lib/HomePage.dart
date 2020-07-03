import 'package:flutter/material.dart';
import 'dart:js' as js;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  List<dynamic> xs = [],ys = [];
  int x = 0, y = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Web Page'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 100.0,
            height: 100.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  onChanged: (value) {
                    x =  int.parse(value);
                  },
                ),
                TextField(
                  onChanged: (value){
                    y = int.parse(value);
                  },
                ),
              ],
            ),
          ),
          FlatButton(
            color: Colors.green,
            child: Text('Push - X'),
            onPressed: (){
              js.context.callMethod('pushToXS', [x]);
            },
          ),
          FlatButton(
            color: Colors.orange,
            child: Text('Push - Y'),
            onPressed: (){
              js.context.callMethod('pushToYS', [y]);
            },
          ),
          FlatButton(
            color: Colors.red,
            child: Text('Start Training'),
            onPressed: (){
              js.context.callMethod('acceptInput');
              js.context.callMethod('trainModel');
            },
          ),
        ],
      ),
    );
  }
}