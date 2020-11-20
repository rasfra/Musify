import 'dart:convert';

import 'package:http/http.dart' as http;

class Song {
  String id, title, artist, url, coverart, album, lyrics;

  Song(this.id, this.title, this.artist, this.url, this.coverart, this.album,
      this.lyrics);
}

List<Song> searchedList = [];
List<Song> allSongs = [];
Song current;
String checker;

Future<List<Song>> fetchSongsList(String searchQuery) async {
  var res = await http
      .get("http://192.168.1.41:4567/api/music?query=$searchQuery", headers: {
    "Accept": "application/json",
    "secret": "2758D42A386CF80E466779B2F75C1592" // local dev secret
  });
  var songs = (json.decode(res.body) as Iterable)
      .map((e) => Song(e["id"], e["title"], e["artist"], e["url"],
          e["coverart"], "album", null))
      .toList();

  searchedList = songs;
  return songs;
}

Future<List<Song>> soundryCatalog() async {
  var songsListJSON = await http.get(
      "http://192.168.1.41:4567/api/channel/88fdb498-ff63-3144-bfe0-ed7c6835ec3c",
      headers: {
        "Accept": "application/json",
        "secret": "2758D42A386CF80E466779B2F75C1592"
      });
  var songs = (json.decode(songsListJSON.body) as Iterable)
      .map((e) => Song(e["id"], e["title"], e["artist"], e["url"],
          e["coverart"], "album", null))
      .toList();

  allSongs = songs;

  return songs;
}
