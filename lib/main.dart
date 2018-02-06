import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Startup Namer',
      theme: new ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: new MyHomePage(title: 'Startup Namer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<WordPair> _suggestions = generateWordPairs().take(10).toList();
  final Set<WordPair> _saved = new Set();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Column(children: [
        _buildSuggestions(),
        _buildSaved(),
      ]),
      floatingActionButton: new FloatingActionButton(
        onPressed: _refresh,
        child: new Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildRow(WordPair pair) {
    return new Row(children: [
      new Expanded(
          child: new RichText(
              text: new TextSpan(
                  children: [
            new TextSpan(
                text: pair.first.toLowerCase(),
                style: new TextStyle(color: Theme.of(context).primaryColor)),
            new TextSpan(
                text: pair.second.toLowerCase(),
                style: new TextStyle(color: Colors.black87)),
          ],
                  style: new TextStyle(
                      fontSize: 18.0,
                      fontWeight:
                          _saved.contains(pair) ? FontWeight.bold : null)))),
      new IconButton(
          icon: new Icon(Icons.add),
          onPressed: () {
            setState(() {
              _saved.add(pair);
            });
          })
    ]);
  }

  Widget _buildSuggestions() {
    return new ListView(
      padding: const EdgeInsets.all(16.0),
      shrinkWrap: true,
      children: _suggestions.map(_buildRow).toList(),
    );
  }

  Widget _buildSaved() {
    return new Expanded(
      child: new Container(
          padding: const EdgeInsets.all(16.0),
          color: Theme.of(context).backgroundColor,
          child: new Text(_saved.map((p) => p.join()).join(", "))),
    );
  }

  void _refresh() {
    setState(() {
      _suggestions.clear();
      _suggestions.addAll(generateWordPairs().take(10));
    });
  }
}
