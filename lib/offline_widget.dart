import 'package:flutter/material.dart';

Widget offlineWidget() {
  return Container(
      height: 30,
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.airplanemode_active,
            color: Colors.white,
          ),
          Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Text(
              'Offline',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Icon(
            Icons.airplanemode_active,
            color: Colors.white,
          ),
        ],
      ));
}
