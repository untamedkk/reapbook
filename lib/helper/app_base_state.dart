import 'package:equatable/equatable.dart';

class AppBaseState extends Equatable {
  @override
  List<Object> get props => [];
}

class ApiFailedState extends AppBaseState {
  final String message;

  ApiFailedState(this.message);
}
