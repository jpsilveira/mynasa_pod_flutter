import 'package:bloc/bloc.dart';

import 'mynasa_controller.dart';
import 'picture_model.dart';
import 'picture_state.dart';

class PictureCubit extends Cubit<PictureState> {
  PictureCubit() : super(PictureInitial());

  MyNasaController pictureController = MyNasaController();

  getPicturesOnLine() async {
    try {
      emit(PictureLoading());
      final List<PictureModel> imagesList =
          await pictureController.getPictures();
      emit(PictureLoaded(picture: imagesList));
    } catch (e) {
      getPicturesCached();
    }
  }

  getPicturesCached() async {
    try {
      emit(PictureLoading());

      final List<PictureModel> imagesList =
          await pictureController.getCachedPictures();

      emit(PictureLoadedOffline(picture: imagesList));
    } catch (e) {
      emit(PictureError(
          message:
              'There was a problem loading Pictures,pull to refresh: (${e.toString()})'));
    }
  }
}
