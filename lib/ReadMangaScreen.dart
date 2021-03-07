import 'package:flutter/material.dart';
import 'Scrapper.dart';

class ReadMangaScreen extends StatefulWidget {
  final String chapterUrl;

  ReadMangaScreen(this.chapterUrl);

  @override
  _ReadMangaScreenState createState() => _ReadMangaScreenState(chapterUrl);
}

class _ReadMangaScreenState extends State<ReadMangaScreen> {
  final String chapterUrl;

  _ReadMangaScreenState(this.chapterUrl);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
