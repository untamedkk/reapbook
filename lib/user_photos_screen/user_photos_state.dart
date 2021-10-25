import 'package:equatable/equatable.dart';
import 'package:reap_book/model/photo.dart';

class UserPhotosState extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchingUserPhotos extends UserPhotosState {}

class PostFetchUserPhotos extends UserPhotosState {
  final List<Photo> photos;

  PostFetchUserPhotos(this.photos);
}

class FetchingUserPhotosFailed extends UserPhotosState {
  final String err;

  FetchingUserPhotosFailed(this.err);
}
