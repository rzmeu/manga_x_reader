import 'package:flutter/material.dart';
import 'MangaListScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        body: Center(
          child: HomePage(),
        ),
      ),
    );
  }
}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _sources = {'Mangakakalot', 'Mangadex', 'MangaTX'};
  final _biggerFont = TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manga sources'),
      ),
      body: _buildSources()
    );
  }

  Widget _buildSources() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: _sources.length,
        itemBuilder: (context, i) {
          return _buildRow(_sources.elementAt(i));
        });
  }

  Widget _buildRow(String value) {
    return ListTile(
      title: Text(
        value,
        style: _biggerFont,
      ),
        onTap: () {
          Navigator.push(context,  MaterialPageRoute(builder: (context) => MangaListScreen(value)));
        }
    );
  }

}
