import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'mynasa_item_widget.dart';
import 'mynasa_routes.dart';
import 'mynasa_search_widget.dart';
import 'offline_widget.dart';
import 'picture_cubit.dart';
import 'picture_state.dart';

class MyNasaPage extends StatefulWidget {
  const MyNasaPage({Key? key}) : super(key: key);

  @override
  State<MyNasaPage> createState() => _MyNasaPageState();
}

class _MyNasaPageState extends State<MyNasaPage> {
  final Connectivity myConnectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> myConnectivitySubscription;

  Future<void> initMyConnectivity(BuildContext myContext) async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await myConnectivity.checkConnectivity();

      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        myContext.read<PictureCubit>().getPicturesOnLine();
      } else if (result == ConnectivityResult.none) {
        myContext.read<PictureCubit>().getPicturesCached();
      }
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }

    if (!mounted) {
      return Future.value(null);
    }
  }

  listenToMyConnectivity() {
    myConnectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        context.read<PictureCubit>().getPicturesOnLine();
      } else if (result == ConnectivityResult.none) {
        context.read<PictureCubit>().getPicturesCached();
      }
    });
  }

  @override
  void initState() {
    initMyConnectivity(context);
    listenToMyConnectivity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Center(child: Text('My NASA APOD')),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: MyNasaSearchWidget(),
                );
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<PictureCubit, PictureState>(
          builder: ((context, state) {
            if (state is PictureLoaded) {
              return picturesGrid(state);
            } else if (state is PictureLoadedOffline) {
              return picturesGrid(state);
            } else if (state is PictureError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
        ),
      ),
    );
  }

  Widget picturesGrid(state) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<PictureCubit>().getPicturesOnLine();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        child: Column(
          children: [
            Visibility(
              visible: state is PictureLoadedOffline,
              child: offlineWidget(),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: state.picture.length - 1,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(MyNasaRoutes.picturesDetail,
                        arguments: {'index': state.picture[index]});
                  },
                  child: MyNasaItemWidget(
                    picture: state.picture[index],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
