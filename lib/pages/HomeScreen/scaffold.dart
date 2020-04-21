import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:q_ours_mobile/routing/locator.dart';
import 'package:q_ours_mobile/routing/router.dart';
import 'package:q_ours_mobile/pages/Authentication/authentication_screen.dart';
import 'package:q_ours_mobile/pages/HomeScreen/home_screen.dart';
import 'package:q_ours_mobile/extensions/hex_color.dart';
import 'package:q_ours_mobile/services/auth_service.dart';
import 'package:q_ours_mobile/services/navigation_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

ProgressDialog pr;

class AppScaffold extends StatefulWidget {
  AppScaffold({Key key}) : super(key: key);

  @override
  _AppScaffoldState createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  File image;
  bool isUploaded;
  int index = 0;
  var uuid = Uuid();

  imageSelectorCamera() async {
    image = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );

    String path = image.path ?? "nothing";
    print("You selected camera image : " + path);
    pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
    );

    pr.style(
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progressTextStyle: TextStyle(
            color: Colors.deepPurpleAccent, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));

    pr.show();

    await _uploadFile(image, '${uuid.v4()}');
  }

  Future<void> _uploadFile(File file, String fileName) async {
    await AuthService().signInAnon();
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child(fileName);
    final StorageUploadTask uploadTask = storageReference.putFile(file);
    final StorageTaskSnapshot imageRef =
        (await uploadTask.onComplete.catchError((e) => print(e)));

    String downloadUrl = await imageRef.ref.getDownloadURL();
    await processImage(downloadUrl);
  }

  Future<void> processImage(String url) async {
    String endpoint =
        'https://us-central1-qours-image-detection.cloudfunctions.net/function-1';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{"directlink": "$url"}';

    Response response = await post(endpoint, headers: headers, body: json);
    print('Picture code: ${response.body}');
    findLink(response.body);
  }

  Future<void> findLink(String code) async {
    String linkEndpoint =
        'https://us-central1-poos-qours.cloudfunctions.net/app/api/get-binary/${code}';
    Map<String, String> headers = {"Content-type": "application/json"};

    Response response = await get(linkEndpoint, headers: headers);

    if (response.body.isNotEmpty) {
      String contentLink = jsonDecode(response.body)['url'];
      _launchInBrowser(contentLink);
    } else
      Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("We could not locate your code"),
    ));
  }

  Future<void> _launchInBrowser(String url) async {
    await pr.hide();
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
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
                icon: Icon(
                  Icons.person,
                  color: index == 1 ? Colors.red : Colors.black,
                ),
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
