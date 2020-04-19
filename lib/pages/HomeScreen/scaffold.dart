import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:q_ours_mobile/routing/locator.dart';
import 'package:q_ours_mobile/routing/router.dart';
import 'package:q_ours_mobile/pages/Authentication/authentication_screen.dart';
import 'package:q_ours_mobile/pages/HomeScreen/home_screen.dart';
import 'package:q_ours_mobile/extensions/hex_color.dart';
import 'package:q_ours_mobile/services/navigation_service.dart';

class AppScaffold extends StatelessWidget {
  File image;

  imageSelectorCamera() async {
    image = await ImagePicker.pickImage(
      source: ImageSource.camera,
      //maxHeight: 50.0,
      //maxWidth: 50.0,
    );
    print("You selected camera image : " + image.path);
  }

  AppScaffold({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              'QOurs',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24),
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          elevation: 4,
          backgroundColor: Colors.deepPurpleAccent,
          child: Icon(Icons.photo_camera),
          onPressed: imageSelectorCamera,
        ),
        bottomNavigationBar: BottomAppBar(
          clipBehavior: Clip.antiAlias,
          shape: CircularNotchedRectangle(),
          notchMargin: 6.0,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.person),
                onPressed: () =>
                    locator<NavigationService>().navigateTo(AuthRoute),
              ),
              Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () =>
                          locator<NavigationService>().navigateTo(HomeRoute)),
                  IconButton(
                    icon: Icon(Icons.favorite),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
        body: Container(
            decoration: BoxDecoration(
                color: Colors.red,
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      HexColor.fromHex('1A2A6C'),
                      HexColor.fromHex('B21F1F'),
                      HexColor.fromHex('FDBB2D')
                    ])),
            child: Navigator(
              key: locator<NavigationService>().navKey,
              initialRoute: HomeRoute,
              onGenerateRoute: generateRoute,
            )));
  }
}
