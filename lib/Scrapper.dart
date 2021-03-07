import 'package:web_scraper/web_scraper.dart';

class Scrapper {
  Scrapper();
  String baseUrl = 'https://mangakakalot.com';

  Future<List<MangaObject>> getMangaList(int page) async {
    List<MangaObject> mangaList = [];

    final webScraper = WebScraper(baseUrl);
    if (await webScraper.loadWebPage(getPageUrl(page))) {

      var elements = webScraper.getElement('div.list-truyen-item-wrap>a>img', ['alt','src']);

      for (var i = 0; i < elements.length; i++) {
        var currentElement = elements[i];
        String title = currentElement['attributes']['alt'];
        String posterUrl = currentElement['attributes']['src'];
        String mangaUrl = webScraper.getElement('div.list-truyen-item-wrap>a:first-child', ['href'])[i]['attributes']['href'];

        mangaList.add(MangaObject(title, posterUrl, mangaUrl));

      }
    }

    return mangaList;
  }

  String getPageUrl(int page) {
    return "/manga_list?type=latest&category=all&state=all&page=$page";
  }

}

class MangaObject {
  String title;
  String posterUrl;
  String mangaUrl;

  MangaObject(this.title, this.posterUrl, this.mangaUrl);
}