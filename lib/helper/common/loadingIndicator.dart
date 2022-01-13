import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final Color color;
  LoadingIndicator({Key key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color,
      ),
    );
  }
}