import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:q_ours_mobile/extensions/hex_color.dart';
import 'package:q_ours_mobile/pages/HomeScreen/shape_maker/shape.dart';
import 'package:q_ours_mobile/pages/HomeScreen/shape_maker/shape_maker.dart';
import 'package:q_ours_mobile/widgets/styled_form_field.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textEditingController = TextEditingController();
  AnimationController shapeMakerController;

  GlobalKey<ShapeMakerState> key = GlobalKey();

  createString() async {
    var generator = Uuid();
    var uuid = generator.v4();

    String resString;
    var buffer = new StringBuffer();
    List shapes = ShapeMaker.currentShapes;

    buffer.write(shapes.length.toString());
    shapes.forEach((shape) => buffer.write(shape.numEdges.toString()));

    resString = buffer.toString();

    String url =
        "https://us-central1-poos-qours.cloudfunctions.net/app/api/store-binary";
    Map<String, String> headers = {"Content-type": "application/json"};
    String json =
        '{"binary": "${resString}", "url": "${textEditingController.text}", "creator_uid": "${uuid}"}';

    Response response = await post(url, headers: headers, body: json);

    if (response.statusCode == 200)
      key.currentState.setState(() {
        ShapeMaker.currentShapes.clear();
        textEditingController.clear();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StyledFormField(250, 'Enter Url', textEditingController),
                ShapeMaker(key: key),
                Center(
                    child: Wrap(children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: RaisedButton(
                      elevation: 4,
                      splashColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.deepPurpleAccent,
                      child: Text(
                        'Submit'.toUpperCase(),
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () => createString(),
                    ),
                  )
                ])),
              ]),
        ),
      ),
    );
  }
}
