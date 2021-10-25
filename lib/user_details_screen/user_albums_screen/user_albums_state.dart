import 'package:equatable/equatable.dart';
import 'package:reap_book/model/album.dart';

class UserAlbumsState extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchingUserAlbums extends UserAlbumsState {}

class PostFetchUserAlbums extends UserAlbumsState {
  final List<Album> albums;

  PostFetchUserAlbums(this.albums);
}

class FetchingUserAlbumsFailed extends UserAlbumsState {
  final String err;

  FetchingUserAlbumsFailed(this.err);
}
