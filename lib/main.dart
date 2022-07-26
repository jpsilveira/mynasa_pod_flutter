import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynasa_pod_flutter/mynasa_page.dart';
import 'package:mynasa_pod_flutter/mynasa_routes.dart';

import 'mynasa_detail_widget.dart';
import 'picture_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PictureCubit(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MY NASA APOD',
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            primaryColor: Colors.black,
            primaryTextTheme: const TextTheme(
              bodyText1: TextStyle(
                color: Colors.white,
              ),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          // home: MyNasaPage(),
          initialRoute: MyNasaRoutes.picturesList,
          routes: {
            MyNasaRoutes.picturesList: (_) => const MyNasaPage(),
            MyNasaRoutes.picturesDetail: (_) => const MyNasaDetailWidget(),
          }),
    );
  }
}
