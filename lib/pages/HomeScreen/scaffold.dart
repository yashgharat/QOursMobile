import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:q_ours_mobile/routing/locator.dart';
import 'package:q_ours_mobile/routing/router.dart';
import 'package:q_ours_mobile/pages/Authentication/authentication_screen.dart';
import 'package:q_ours_mobile/pages/HomeScreen/home_screen.dart';
import 'package:q_ours_mobile/extensions/hex_color.dart';
import 'package:q_ours_mobile/services/navigation_service.dart';

class AppScaffold extends StatefulWidget {
  AppScaffold({Key key}) : super(key: key);

  @override
  _AppScaffoldState createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  File image;
  int index = 0;

  imageSelectorCamera() async {
    image = await ImagePicker.pickImage(
      source: ImageSource.camera,
      //maxHeight: 50.0,
      //maxWidth: 50.0,
    );

    String path = image.path ?? "nothing";
    print("You selected camera image : " + path);
  }

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
                icon: Icon(Icons.person,
                        color: index == 1 ? Colors.red : Colors.black,),
                onPressed: () {
                  setState(() => index = 1);
                  locator<NavigationService>().navigateTo(AuthRoute);
                },
              ),
              Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.add,
                        color: index == 0 ? Colors.red : Colors.black,
                      ),
                      onPressed: () {
                        setState(() => index = 0);
                        locator<NavigationService>().navigateTo(HomeRoute);
                      }),
                  IconButton(
                    icon: Icon(
                      Icons.collections,
                      color: index == 2 ? Colors.red : Colors.black,
                    ),
                    onPressed: () {
                      setState(() => index = 2);
                      locator<NavigationService>().navigateTo(CodeRoute);
                    },
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
