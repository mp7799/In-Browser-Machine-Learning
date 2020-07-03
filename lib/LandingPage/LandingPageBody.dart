import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:js' as js;
import 'dart:js_util' as jsU;
import 'dart:html' as html;
import 'package:flutter_linear_regression/common_js.dart';

class LandingPageBody extends StatefulWidget {
  @override
  _LandingPageBodyState createState() => _LandingPageBodyState();
}

int xList = 0, yList = 0;

class _LandingPageBodyState extends State<LandingPageBody> {
  List<double> xs = [], ys = [];
  double inputValue;
  var call;

  var _controllerX = TextEditingController();
  var _controllerY = TextEditingController();
  var _controllerEpoch = TextEditingController();
  var _controllerPredNumber = TextEditingController();

  double x1 = 0.0, x2 = 0.0, y1 = 0.0, y2 = 0.0;
  double predictedResult = 0;
  int times = 3;
  int epochs = 500;
  int colorStrength = 100;
  double slope, intercept;
  int xSize = 0, ySize = 0;
  String processActivateButton = "Create Model";

  List<Widget> pageChildren() {
    final spinkit = SpinKitDualRing(
      color: Colors.pink[200],
      size: 250.0,
    );

    return <Widget>[
      Column(
        children: [
          Text(
            'Xs',
            style: TextStyle(
              fontFamily: "Century Goth",
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            child: InputArray(
              list: xs,
              controller: _controllerX,
              axis: 'X',
              colorStrength: colorStrength,
              listSize: xSize,
            ),
          ),
          FlatButton(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 2.0,
                color: Colors.pink[colorStrength],
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Text(
              'Remove Last',
              style: TextStyle(
                fontFamily: "Century Goth",
                fontSize: 13.0,
              ),
            ),
            onPressed: () {
              js.context.callMethod('removeLastXS');
              setState(() {
                xs.removeLast();
              });
            },
          ),
        ],
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.05,
      ),
      Column(
        children: [
          Text(
            'Ys',
            style: TextStyle(
              fontFamily: "Century Goth",
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            child: InputArray(
              list: ys,
              controller: _controllerY,
              axis: 'Y',
              colorStrength: colorStrength,
              listSize: ySize,
            ),
          ),
          FlatButton(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 2.0,
                color: Colors.pink[colorStrength],
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Text(
              'Remove Last',
              style: TextStyle(
                fontFamily: "Century Goth",
                fontSize: 13.0,
              ),
            ),
            onPressed: () {
              js.context.callMethod('removeLastYS');
              setState(() {
                ys.removeLast();
              });
            },
          ),
        ],
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.22,
      ),
      Container(
        child: Column(
          children: [
            Stack(
              children: [
                spinkit,
                Positioned(
                  left: 70,
                  top: 110,
                  child: FlatButton(
                    color: Color.fromRGBO(255, 255, 255, 0.5),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.pink[colorStrength],
                            width: 2,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(50.0)),
                    onPressed: () {
                      if (xList == 0 || yList == 0) {
                        html.window.alert("Xs or Ys cannot be empty!");
                      } else if (xList < 5 || yList < 5) {
                        html.window
                            .alert("Please give atleast 5 training data!");
                      } else if (xList != yList) {
                        html.window
                            .alert("Length of both Xs and Ys should be same!");
                      } else {
                        js.context.callMethod('consolePrint');
                        setState(() {
                          processActivateButton = "Wait for an Alert";
                        });
                      }
                    },
                    child: Text(processActivateButton),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.33,
      ),
      Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: Column(
            children: [
              ThemeSelector(color: Colors.pink[colorStrength]),
              ThemeSelector(color: Colors.black87),
              ThemeSelector(color: Colors.black54),
              ThemeSelector(color: Colors.black45),
              ThemeSelector(color: Colors.black38),
              ThemeSelector(color: Colors.black26),
              ThemeSelector(color: Colors.black12),
            ],
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    xSize = xList;
    ySize = yList;
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 1300)
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: pageChildren(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    Container(
                      child: Text(
                        'Epochs: ',
                        style: TextStyle(
                          fontFamily: "Century Goth",
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Container(
                      width: 50.0,
                      child: TextField(
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.pink[colorStrength]),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.pink[colorStrength]),
                          ),
                        ),
                        controller: _controllerEpoch,
                        onChanged: (value) {
                          epochs = int.parse(value);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 2.0,
                          color: Colors.pink[colorStrength],
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: Text('Set'),
                      onPressed: () {
                        print(xList);
                        _controllerEpoch.clear();
                        js.context.callMethod('setEpochs', [epochs]);
                        html.window.alert('Epochs = $epochs');
                        setState(() {
                          if (colorStrength < 600)
                            colorStrength = colorStrength + 100;
                        });
                      },
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.18,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Text(
                            "Y   =   ",
                            style: TextStyle(
                              fontFamily: "Century Goth",
                              fontSize: 18.0,
                            ),
                          ),
                          Container(
                            width: 50.0,
                            child: TextField(
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.pink[colorStrength]),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.pink[colorStrength]),
                                ),
                              ),
                              controller: _controllerPredNumber,
                              onChanged: (value) {
                                if (times == 2) {
                                  x1 = double.parse(value);
                                } else {
                                  x2 = double.parse(value);
                                }
                              },
                            ),
                          ),
                          Text(
                            " *  Slope  +   Constant  ",
                            style: TextStyle(
                              fontFamily: "Century Goth",
                              fontSize: 18.0,
                            ),
                          ),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 2.0,
                                color: Colors.pink[colorStrength],
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: Text('Make Prediction'),
                            onPressed: () {
                              _controllerPredNumber.clear();
                              if (times == 2) {
                                predictedResult =
                                    js.context.callMethod('prediction', [x1]);
                                y1 = predictedResult;
                              } else {
                                predictedResult =
                                    js.context.callMethod('prediction', [x2]);
                                y2 = predictedResult;
                              }
                              setState(() {
                                if (times == 3)
                                  times--;
                                else if (times == 2) {
                                  times--;
                                  slope = double.parse(((y2 - y1) / (x2 - x1))
                                      .toStringAsFixed(1));
                                  intercept = double.parse(
                                      ((y1 - (slope * x1))).toStringAsFixed(0));
                                } else
                                  times = 0;
                              });
                              //print(predictedResult);
                            },
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.10,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Steps:',
                                  style: TextStyle(
                                    fontFamily: "Century Goth",
                                    fontSize: 12.0,
                                  ),
                                ),
                                Text(
                                  '1. Consider any linear equation of the form y = mx + c',
                                  style: TextStyle(
                                    fontFamily: "Century Goth",
                                    fontSize: 12.0,
                                  ),
                                ),
                                Text(
                                  '2. Give values to Xs and Ys according to equation',
                                  style: TextStyle(
                                    fontFamily: "Century Goth",
                                    fontSize: 12.0,
                                  ),
                                ),
                                Text(
                                  '3. Create the Model',
                                  style: TextStyle(
                                    fontFamily: "Century Goth",
                                    fontSize: 12.0,
                                  ),
                                ),
                                Text(
                                  '4. Make atleast 2 prediction for model to guess the equation.',
                                  style: TextStyle(
                                    fontFamily: "Century Goth",
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "$predictedResult",
                style: TextStyle(
                  color: Colors.pink[colorStrength],
                  fontFamily: "Century Goth",
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.pink[colorStrength],
                        ),
                        Text(
                          '  An epoch refers to one cycle through the full training dataset.',
                          style: TextStyle(
                            fontFamily: "Century Goth",
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.39,
                    ),
                    Row(
                      children: [
                        Icon(Icons.keyboard_arrow_right),
                        Text(
                          'Predicted Equation :  ',
                          style: TextStyle(
                            fontFamily: "Century Goth",
                            fontSize: 15.0,
                          ),
                        ),
                        Text(
                          times > 1
                              ? "Make at least ${times - 1} prediction"
                              : "y = $slope * x + $intercept",
                          style: TextStyle(
                            fontFamily: "Century Goth",
                            fontSize: 15.0,
                            color: Colors.pink[300],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.pink[colorStrength],
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        '  Graphical Representation',
                        style: TextStyle(
                          fontFamily: "Century Goth",
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.pink[colorStrength],
                    ),
                    Text(
                      '  To see the working press Ctrl + Shift + I ,then go to Console',
                      style: TextStyle(
                        fontFamily: "Century Goth",
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.52,
                    ),
                    OutlineButton(
                      onPressed: () {
                        html.window.location.reload();
                      },
                      child: Text('Reset'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.pink[300],
                        width: 3.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      else
        return Column(
          children: [
            Container(),
          ],
        );
    });
  }
}

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({
    Key key,
    @required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          child: Container(
            height: 10.0,
            width: 10.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          onTap: () {},
        ),
        SizedBox(
          height: 30.0,
        ),
      ],
    );
  }
}

class InputArray extends StatefulWidget {
  InputArray({
    Key key,
    @required this.list,
    @required this.axis,
    @required TextEditingController controller,
    @required this.colorStrength,
    @required this.listSize,
  })  : _controller = controller,
        super(key: key);

  final List<double> list;
  final TextEditingController _controller;
  final String axis;
  int colorStrength, listSize;

  @override
  _InputArrayState createState() => _InputArrayState();
}

class _InputArrayState extends State<InputArray> {
  double inputValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100.0,
          child: TextField(
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.pink[widget.colorStrength]),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.pink[widget.colorStrength]),
              ),
              suffixIcon: IconButton(
                icon: Icon(Icons.add),
                color: Colors.pink[widget.colorStrength],
                onPressed: () {
                  setState(() {
                    if (widget.colorStrength != 600)
                      widget.colorStrength = widget.colorStrength + 100;
                  });
                  if (widget.axis == "X") {
                    if (inputValue != null)
                      js.context.callMethod('pushToXS', [inputValue]);
                  } else {
                    if (inputValue != null)
                      js.context.callMethod('pushToYS', [inputValue]);
                  }
                  setState(() {
                    if (inputValue != null) widget.list.add(inputValue);
                    inputValue = null;
                    if (widget.axis == "Y")
                      yList = widget.list.length;
                    else
                      xList = widget.list.length;
                  });
                  widget._controller.clear();
                },
              ),
            ),
            controller: widget._controller,
            onChanged: (value) {
              inputValue = double.parse(value);
            },
          ),
        ),
        Container(
          height: 160.0,
          width: 30.0,
          child: ListView.builder(
              itemCount: widget.list.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 30.0,
                  child: Center(
                      child: Text(
                    widget.list[index].toString(),
                    style: TextStyle(
                      fontFamily: "Century Goth",
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                );
              }),
        ),
      ],
    );
  }
}
