import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'mynasa_item_widget.dart';
import 'mynasa_routes.dart';
import 'picture_cubit.dart';
import 'picture_model.dart';
import 'picture_state.dart';

class MyNasaSearchWidget extends SearchDelegate {
  @override
  String? get searchFieldLabel => "Pesquisar";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return BlocBuilder<PictureCubit, PictureState>(
      builder: (context, state) {
        if (state is PictureLoaded || state is PictureLoadedOffline) {
          if (query.isNotEmpty) {
            List<PictureModel> picture = state.picture
                .where((element) =>
                    element.title!
                        .toLowerCase()
                        .contains(query.toLowerCase()) ||
                    element.date!.toLowerCase().contains(query))
                .toList();
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: picture.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          MyNasaRoutes.picturesDetail,
                          arguments: {'index': picture[index]});
                    },
                    child: MyNasaItemWidget(picture: picture[index]));
              },
            );
          }
        }
        return buildSuggestions(context);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text(
        'Pesquisar',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
