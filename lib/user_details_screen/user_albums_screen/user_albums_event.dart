import 'package:equatable/equatable.dart';

class UserAlbumsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchUserAlbum extends UserAlbumsEvent {
  final int id;

  FetchUserAlbum(this.id);
}
