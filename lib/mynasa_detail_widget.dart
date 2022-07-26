import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mynasa_pod_flutter/picture_model.dart';

import 'offline_widget.dart';
import 'picture_cubit.dart';
import 'picture_state.dart';

class MyNasaDetailWidget extends StatelessWidget {
  const MyNasaDetailWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map;
    final PictureModel picture = args['index'];

    final mySize = MediaQuery.of(context).size;
    return Container(
      color: Colors.black,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: BackButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: mySize.width,
                    height: mySize.height / 2.2,
                    child: CachedNetworkImage(
                      imageUrl: picture.url.toString(),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFDEDEDE),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 18,
                      left: 8,
                      right: 8,
                      bottom: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Text(
                            DateFormat('dd/MM/yyyy')
                                .format(DateTime.parse(picture.date!)),
                            // picture.date.toString(),
                            style: const TextStyle(
                              fontSize: 24,
                              letterSpacing: .27,
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Center(
                          child: Text(
                            picture.title.toString(),
                            maxLines: 2,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              letterSpacing: .27,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        BlocBuilder<PictureCubit, PictureState>(
                          builder: (context, state) {
                            if (state is PictureLoadedOffline) {
                              return offlineWidget();
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                        const Divider(
                          height: 20,
                          thickness: 2,
                          color: Colors.blueGrey,
                        ),
                        // const Text(
                        //   'explanation:',
                        //   style: TextStyle(color: Colors.red, fontSize: 18),
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: SizedBox(
                            width: mySize.width / 1.1,
                            child: Text(
                              picture.explanation.toString(),
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  letterSpacing: .27,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
