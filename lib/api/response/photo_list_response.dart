import 'package:reap_book/model/photo.dart';

class PhotoListResponse {
  List<Photo> photos;

  PhotoListResponse.fromJson(List<dynamic> json) : this.photos = [] {
    List<Photo> c = json.map((userJson) => Photo.fromJson(userJson)).toList();
    this.photos.addAll(c);
  }
}
