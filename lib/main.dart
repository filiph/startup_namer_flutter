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
      leading: new Icon(
          _saved.contains(pair) ? Icons.bookmark : Icons.bookmark_border),
      title: new RichText(
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
              ))),
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
