import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'picture_model.dart';

class MyNasaItemWidget extends StatefulWidget {
  final PictureModel picture;

  const MyNasaItemWidget({required this.picture, Key? key}) : super(key: key);

  @override
  _MyNasaItemWidgetState createState() => _MyNasaItemWidgetState();
}

class _MyNasaItemWidgetState extends State<MyNasaItemWidget> {
  Widget imageTile() {
    final mySize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            height: mySize.height / 2,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(62, 168, 174, 201),
                  offset: Offset(0, 9),
                  blurRadius: 10,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl: widget.picture.url.toString(),
                    height: mySize.height / 3,
                    width: mySize.width / 2,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        height: mySize.height / 8,
                        width: mySize.width / 2,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.8),
                              Colors.black.withOpacity(0.7),
                              Colors.black.withOpacity(0.6),
                              Colors.black.withOpacity(0.6),
                              Colors.black.withOpacity(0.4),
                              Colors.black.withOpacity(0.1),
                              Colors.black.withOpacity(0.05),
                              Colors.black.withOpacity(0.025),
                            ],
                          ),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container())),
                  ),
                  Positioned(
                    right: mySize.width / 50,
                    left: mySize.width / 50,
                    bottom: mySize.height / 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          DateFormat('dd/MM/yyyy')
                              .format(DateTime.parse(widget.picture.date!)),
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          widget.picture.title.toString(),
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return imageTile();
  }
}
