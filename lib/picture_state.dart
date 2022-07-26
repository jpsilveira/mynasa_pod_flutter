import 'package:flutter/material.dart';

import 'picture_model.dart';

@immutable
abstract class PictureState {
  final List<PictureModel> picture;

  const PictureState({this.picture = const <PictureModel>[]});
}

class PictureInitial extends PictureState {}

class PictureLoading extends PictureState {}

class PictureLoaded extends PictureState {
  @override
  final List<PictureModel> picture;

  const PictureLoaded({required this.picture});
}

class PictureLoadedOffline extends PictureState {
  @override
  final List<PictureModel> picture;

  const PictureLoadedOffline({required this.picture});
}

class PictureError extends PictureState {
  final String message;

  const PictureError({required this.message});
}
