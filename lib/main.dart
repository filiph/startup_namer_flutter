import 'dart:async';

import 'package:flutter/material.dart';

import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Startup Namer',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Startup Namer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<WordPair> _pairs = [];

  void initState() {
    super.initState();
    _getNewNames();
  }

  void _getNewNames() {
    final newNames = generateWordPairs().take(10);
    setState(() {
      _pairs.clear();
      _pairs.addAll(newNames);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _pairs
              .map((pair) => new ListTile(
                    title: new Text(pair.join()),
                  ))
              .toList(),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _getNewNames,
        tooltip: 'Get new ideas',
        child: new Icon(Icons.refresh),
      ),
    );
  }
}
