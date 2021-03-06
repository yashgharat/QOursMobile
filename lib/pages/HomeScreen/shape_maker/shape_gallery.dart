import 'package:flutter/material.dart';

class ShapeGallery extends StatelessWidget {
  Function(String, int) addShape;
  Function(bool) deleteShape;

  ShapeGallery(this.addShape, this.deleteShape);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      width: 300,
      height: 100,
      child: Card(
        color: Colors.white.withOpacity(.6),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Row(children: <Widget>[
          _ShapeContainer('circle', 1, addShape),
          _ShapeContainer('triangle', 3, addShape),
          _ShapeContainer('rectangle', 4, addShape),
          _ShapeContainer('pentagon', 5, addShape),
          _ShapeContainer('hexagon', 6, addShape),
          _DeleteShapeButton(deleteShape),
        ]),
      ),
    );
  }
}

class _DeleteShapeButton extends StatelessWidget {
  Function(bool) deleteShape;

  _DeleteShapeButton(this.deleteShape);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: InkWell(
          onTap: () => deleteShape(false),
          onLongPress: () => deleteShape(true),
          child: Icon(
            Icons.delete,
          ),
        ),
      ),
    );
  }
}

class _ShapeContainer extends StatelessWidget {
  String shapeName;
  int shapeEdges;
  Function(String, int) addShape;

  _ShapeContainer(this.shapeName, this.shapeEdges, this.addShape);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('lib/assets/shapes/${shapeName}.png'),
      )),
      child: InkWell(
        onTap: () => addShape(shapeName, shapeEdges),
      ),
    ));
  }
}
