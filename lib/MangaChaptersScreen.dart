import 'package:flutter/material.dart';
import 'package:manga_x_reader/ReadMangaScreen.dart';
import 'Scrapper.dart';

class MangaChaptersScreen extends StatefulWidget {
  final MangaObject mangaObject;

  MangaChaptersScreen(this.mangaObject);

  @override
  _MangaChaptersScreenState createState() => _MangaChaptersScreenState(mangaObject);
}

class _MangaChaptersScreenState extends State<MangaChaptersScreen> {
  final MangaObject mangaObject;

  _MangaChaptersScreenState(this.mangaObject);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: _buildMangaChapterList());
  }

  FutureBuilder _buildMangaChapterList() {
    return FutureBuilder(
        builder: (context, snapshot) {
          // WHILE THE CALL IS BEING MADE AKA LOADING
          if (ConnectionState.active != null && !snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          // WHEN THE CALL IS DONE BUT HAPPENS TO HAVE AN ERROR
          if (ConnectionState.done != null && snapshot.hasError) {
            return Center(child: Text(snapshot.error));
          }

          return ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: _buildRow(snapshot.data[index]),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MangaChaptersScreen(snapshot.data[index])));
                },
              );
            });
        },
        future: new Scrapper().getMangaChaptersList(mangaObject.mangaUrl)
    );
  }

  Widget _buildRow(MangaChapter value) {
    return ListTile(
        title: Text(
          value.name,
        ),
        onTap: () {
          Navigator.push(context,  MaterialPageRoute(builder: (context) => ReadMangaScreen(value.chapterUrl)));
        }
    );
  }
}
