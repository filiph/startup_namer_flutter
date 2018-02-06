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

class NameWidget extends StatelessWidget {
  final WordPair _pair;

  final bool _saved;

  final GestureTapCallback _onTap;

  NameWidget(this._pair, this._saved, this._onTap);

  @override
  Widget build(BuildContext context) {
    final richText = new RichText(
      text: new TextSpan(
          children: <TextSpan>[
            new TextSpan(
              text: _pair.first.toLowerCase(),
              style: new TextStyle(color: Theme.of(context).primaryColor),
            ),
            new TextSpan(text: _pair.second.toLowerCase())
          ],
          style: new TextStyle(
              color: Colors.black54,
              fontSize: 24.0,
              fontFamily: 'Gloria Hallelujah')),
    );
    return new ListTile(
      leading: new Icon(
        _saved ? Icons.star : Icons.star_border,
        size: 24.0,
      ),
      title: richText,
      onTap: _onTap,
    );
  }
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

  void initState() {
    super.initState();
    _getNewNames();
  }

  ListView _buildSuggestions() {
    return new ListView.builder(itemBuilder: (context, index) {
      while (index >= _suggestions.length) {
        _getNewNames();
      }
      final pair = _suggestions[index];
      return new NameWidget(pair, _saved.contains(pair), () {
        if (_saved.contains(pair)) {
          setState(() => _saved.remove(pair));
          return;
        }
        setState(() => _saved.add(pair));
      });
    });
  }

  void _getNewNames() {
    final newNames = generateWordPairs().take(10);
    _suggestions.addAll(newNames);
  }
}
