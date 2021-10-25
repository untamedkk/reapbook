import 'dart:convert';

import 'package:reap_book/api/request/create_post_request.dart';
import 'package:reap_book/api/request/update_post_request.dart';
import 'package:reap_book/helper/api_base_helper.dart';

class ApiProvider {
  static const String _GET_USERS = '/users';
  static const String _GET_USER_POST = '/posts?userId=';
  static const String _POST = '/posts';
  static const String _GET_ALBUMS = '/users/{id}/albums';
  static const String _GET_PHOTOS = '/albums/{id}/photos';
  static const String _GET_COMMENTS = '/posts/{id}/comments';

  ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  Future<dynamic> fetchUsers() async {
    return await _apiBaseHelper.get(_GET_USERS);
  }

  Future<dynamic> fetchUserPost(int id) async {
    final url = _GET_USER_POST + id.toString();
    return await _apiBaseHelper.get(url);
  }

  Future<dynamic> createPost(CreatePostRequest request) async {
    return await _apiBaseHelper.post(
        _POST, json.encode(request.toJson()));
  }

  Future<dynamic> updatePost(UpdatePostRequest request) async {
    final url = _POST + "/" + request.id.toString();
    return await _apiBaseHelper.put(url, json.encode(request.toJson()));
  }

  Future<dynamic> deletePost(int id) async {
    final url = _POST + "/" + id.toString();
    return await _apiBaseHelper.delete(url);
  }
  
  Future<dynamic> getAlbums(int id) async {
    final url = _GET_ALBUMS.replaceAll('{id}', id.toString());
    return await _apiBaseHelper.get(url);
  }

  Future<dynamic> getPhotos(int id) async {
    final url = _GET_PHOTOS.replaceAll('{id}', id.toString());
    return await _apiBaseHelper.get(url);
  }

  Future<dynamic> getComments(int id) async {
    final url = _GET_COMMENTS.replaceAll('{id}', id.toString());
    return await _apiBaseHelper.get(url);
  }
}
