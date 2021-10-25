import 'package:equatable/equatable.dart';

class UserPhotosEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchUserPhotos extends UserPhotosEvent {
  final int id;

  FetchUserPhotos(this.id);
}
