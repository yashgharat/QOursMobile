import 'package:flutter/material.dart';
import 'package:q_ours_mobile/pages/HomeScreen/shape_maker/shape.dart';
import 'package:q_ours_mobile/pages/HomeScreen/shape_maker/shape_gallery.dart';
import 'package:q_ours_mobile/pages/HomeScreen/shape_maker/shape_grid.dart';

class ShapeMaker extends StatefulWidget {
  static List<Shape> currentShapes = [];

  @override
  _ShapeMakerState createState() => _ShapeMakerState();
}

class _ShapeMakerState extends State<ShapeMaker> {
  addShape(String shapeName, int shapeEdges) {
    setState(() {
      if (ShapeMaker.currentShapes.length < 16)
        ShapeMaker.currentShapes.add(Shape(shapeName, shapeEdges));
    });
  }

  deleteShape(bool flag) {
    setState(() {
      if (ShapeMaker.currentShapes.length > 0)
        (!flag) ? ShapeMaker.currentShapes.removeLast() : ShapeMaker.currentShapes.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ShapeGrid(ShapeMaker.currentShapes),
        ShapeGallery(addShape, deleteShape),
      ],
    );
  }
}
