import 'package:flutter/material.dart';
import 'package:q_ours_mobile/pages/HomeScreen/shape_maker/shape.dart';
import 'package:q_ours_mobile/pages/HomeScreen/shape_maker/shape_gallery.dart';
import 'package:q_ours_mobile/pages/HomeScreen/shape_maker/shape_grid.dart';


class ShapeMaker extends StatefulWidget {
  @override
  _ShapeMakerState createState() => _ShapeMakerState();
}

class _ShapeMakerState extends State<ShapeMaker> {
  List<Shape> currentShapes = [];

  addShape(String shapeName) {
    setState(() {
        currentShapes.add(Shape(shapeName));
    });
  }

  deleteShape() {
    setState(() {
      if(currentShapes.length > 0)
      currentShapes.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ShapeGrid(currentShapes),
        ShapeGallery(addShape, deleteShape),
      ],
    );
  }
}