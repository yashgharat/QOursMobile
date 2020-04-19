import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:q_ours_mobile/extensions/hex_color.dart';
import 'package:q_ours_mobile/pages/HomeScreen/shape_maker/shape_maker.dart';
import 'package:q_ours_mobile/widgets/styled_form_field.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textEditingController = TextEditingController();
  AnimationController shapeMakerController;

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
                ShapeMaker(),
                Center(
                    child: Wrap(children: [
                  Container(
                    width: 100,
                    child: RaisedButton(
                      elevation: 4,
                      splashColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      color: Colors.deepPurpleAccent,
                      child: Text(
                        'Submit'.toUpperCase(),
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {},
                    ),
                  )
                ])),
              ]),
        ),
      ),
    );
  }
}
