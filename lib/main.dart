import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

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
      body: _buildSuggestions(),
      floatingActionButton: new FloatingActionButton(
        onPressed: _refresh,
        child: new Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildRow(WordPair pair) {
    return new Text(pair.join());
  }

  ListView _buildSuggestions() {
    return new ListView(children: _suggestions.map(_buildRow).toList(),);
  }

  void _refresh() {
    setState(() {
      _suggestions.clear();
      _suggestions.addAll(generateWordPairs().take(10));
    });
  }
}
