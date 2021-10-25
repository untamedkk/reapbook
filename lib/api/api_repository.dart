import 'package:reap_book/api/request/create_post_request.dart';
import 'package:reap_book/api/request/update_post_request.dart';
import 'package:reap_book/api/response/photo_list_response.dart';
import 'package:reap_book/helper/app_exception.dart';
import 'package:reap_book/model/album.dart';
import 'package:reap_book/model/comment.dart';
import 'package:reap_book/model/photo.dart';
import 'package:reap_book/model/post.dart';
import 'package:reap_book/model/user.dart';

import 'api_provider.dart';
import 'response/album_list_response.dart';
import 'response/comment_list_reponse.dart';
import 'response/user_list_response.dart';
import 'response/user_post_response.dart';

class ApiRepository {
  final ApiProvider _apiProvider;

  ApiRepository(this._apiProvider);

  Future<List<User>> getUsers() async {
    final response = await _apiProvider.fetchUsers();
    if (response is AppException) {
      throw response;
    } else {
      return UserListResponse.fromJson(response).results;
    }
  }

  Future<List<Post>> getUserPosts(int id) async {
    final response = await _apiProvider.fetchUserPost(id);
    if (response is AppException) {
      throw response;
    } else {
      return UserPostResponse.fromJson(response).posts;
    }
  }

  Future<Post> createPost(CreatePostRequest request) async {
    final response = await _apiProvider.createPost(request);
    if (response is AppException) {
      throw response;
    } else {
      return Post.fromJson(response);
    }
  }

  Future<Post> updatePost(UpdatePostRequest request) async {
    final response = await _apiProvider.updatePost(request);
    if (response is AppException) {
      throw response;
    } else {
      return Post.fromJson(response);
    }
  }

  Future<bool> deletePost(int id) async {
    final response = await _apiProvider.deletePost(id);
    if (response is AppException) {
      throw response;
    } else {
      return true;
    }
  }

  Future<List<Album>> getAlbums(int id) async {
    final response = await _apiProvider.getAlbums(id);
    if (response is AppException) {
      throw response;
    } else {
      return AlbumListResponse.fromJson(response).results;
    }
  }

  Future<List<Photo>> getPhoto(int id) async {
    final response = await _apiProvider.getPhotos(id);
    if (response is AppException) {
      throw response;
    } else {
      return PhotoListResponse.fromJson(response).photos;
    }
  }

  Future<List<Comment>> getComment(int id) async {
    final response = await _apiProvider.getComments(id);
    if (response is AppException) {
      throw response;
    } else {
      return CommentsListResponse.fromJson(response).comments;
    }
  }
}
