import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Startup Namer',
      theme: new ThemeData(
        primarySwatch: Colors.lightBlue,
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
  final List<WordPair> _suggestions = [];
  final Set<WordPair> _saved = new Set();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        title: new Text(widget.title),
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildRow(WordPair pair) {
    return new ListTile(
      onTap: () {
        setState(() {
          if (_saved.contains(pair)) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
      trailing: new Icon(
          _saved.contains(pair) ? Icons.favorite : Icons.favorite_border,
          color: _saved.contains(pair) ? Colors.red : null),
      title: new Text(
        pair.join(),
        style: new TextStyle(fontSize: 18.0, color: Colors.black87),
      ),
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return new Divider();

        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_suggestions[index]);
      },
    );
  }
}
