import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Super Hot Tree Dude'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _nextFrame() {
    setState(() {
      states.insert(0, getRandomBranch());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Row(
          children: [
            treeColumn(ColumnPosition.left),
            treeColumn(ColumnPosition.middle),
            treeColumn(ColumnPosition.right),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _nextFrame,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

treeColumn(ColumnPosition columnPosition) {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: getColumn(columnPosition),
    ),
  );
}

List<Branch> states = getStartingBranches();

int branchCount = 8;

List<Branch> getStartingBranches() {
  List<Branch> startingBranches = [];

  for (int i = 0; i < branchCount; i++) {
    startingBranches.add(getRandomBranch());
  }
  return startingBranches;
}

Branch getRandomBranch() {
  int rand = Random().nextInt(3);
  if (rand == 0) {
    return Branch.left;
  } else if (rand == 1) {
    return Branch.right;
  } else {
    return Branch.none;
  }
}

enum Branch { left, right, none }
enum ColumnPosition { left, middle, right }

List<Widget> getColumn(ColumnPosition columnPosition) {
  List<Widget> treeColumn = [];

  for (int i = 0; i < branchCount; i++) {
    Color colour = Colors.blue;
    if (columnPosition == ColumnPosition.left && states[i] == Branch.left) {
      colour = Colors.green;
    } else if (columnPosition == ColumnPosition.middle) {
      colour = Colors.brown;
    } else if (columnPosition == ColumnPosition.right && states[i] == Branch.right) {
      colour = Colors.green;
    }
    bool isCloseToGround = i > branchCount - 3;
    if (isCloseToGround && columnPosition == ColumnPosition.left ||
        isCloseToGround && columnPosition == ColumnPosition.right) {
      colour = Colors.red;
    }

    String stateText = '';
    if (states[i] == Branch.left) {
      stateText = 'left';
    } else if (states[i] == Branch.right) {
      stateText = 'right';
    } else {
      stateText = 'none';
    }
    treeColumn.add(
      Expanded(
        child: Container(
          color: colour,
          margin: EdgeInsets.all(1.0),
          child: Text(stateText),
        ),
      ),
    );
  }
  return treeColumn;
}
