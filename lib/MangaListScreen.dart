import 'package:flutter/material.dart';
import 'Scrapper.dart';

class MangaListScreen extends StatefulWidget {
  final String mangaSource;

  MangaListScreen(this.mangaSource);

  @override
  _MangaListScreenState createState() => _MangaListScreenState(mangaSource);
}

class _MangaListScreenState extends State<MangaListScreen> {
  String mangaSource;
  Future<List<MangaObject>> futureItems;
  ScrollController scrollController = new ScrollController();
  int page = 1;
  List<MangaObject> allMangas;

  _MangaListScreenState(this.mangaSource);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(mangaSource),
        ),
        body: _buildMangaList());
  }

  @override
  void initState() {
    super.initState();
    allMangas = [];

    futureItems = Scrapper().getMangaList(page);

    scrollController.addListener(() {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        page++;
        setState(() {
          futureItems = Scrapper().getMangaList(page);
        });
      }
    });
  }

  FutureBuilder _buildMangaList() {
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

        snapshot.data.forEach((element) {
          if (!allMangas.contains(element)) allMangas.add(element);
        });


        return GridView.builder(
          controller: scrollController,
          padding: EdgeInsets.all(16.0),
          itemCount: allMangas.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                child: buildPoster(allMangas[index]),
              onTap: () {
                Navigator.push(context,  MaterialPageRoute(builder: (context) => MangaListScreen(snapshot.data[index].mangaUrl)));
              },
            );
          },

          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              childAspectRatio: 0.6676,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5),
        );
      },
      future: futureItems
    );
  }

  Stack buildPoster(MangaObject value) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          child: Image.network(
              value.posterUrl,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.fill),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0, 0.7),
              end: Alignment(0, 1),
              colors: [
                const Color(0x00000000),
                const Color(0xCC000000),
              ],
            ),
          ),
        ),
        Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.only(bottom: 10, left: 5, right: 5),
            child: Text(
              value.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0),
            )),
      ],
    );
  }
}
