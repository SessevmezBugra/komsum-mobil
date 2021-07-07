import 'package:flutter/material.dart';

class PostListPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _PostListState();
  }
}

class _PostListState extends State<PostListPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Center(
        child: Text(
          "Test"
        ),
      ),
    );
  }
}
