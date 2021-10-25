import 'package:reap_book/model/album.dart';

class AlbumListResponse {
  List<Album> results;

  AlbumListResponse.fromJson(List<dynamic> json) : this.results = [] {
    List<Album> c = json.map((userJson) => Album.fromJson(userJson)).toList();
    this.results.addAll(c);
  }
}
