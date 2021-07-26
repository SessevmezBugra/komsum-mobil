import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:komsum/geography/bloc/filter/geographyFilterBarrel.dart';
import 'package:komsum/geography/model/geography.dart';
import 'package:komsum/geography/widget/geographyFilterListWidget.dart';
import 'package:komsum/helper/common/loadingIndicator.dart';
import 'package:komsum/helper/common/sidebar.dart';
import 'package:komsum/helper/constants.dart';
import 'package:komsum/post/bloc/create/createPostBarrel.dart';
import 'package:komsum/post/model/post.dart';
import 'package:komsum/tag/bloc/filter/tagFilterBarrel.dart';
import 'package:komsum/tag/model/tag.dart';
import 'package:komsum/tag/widget/tagFilterListWidget.dart';

class CreatePostPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreatePostPageState();
  }
}

class _CreatePostPageState extends State<CreatePostPage> {
  TextEditingController _textEditingController;
  ScrollController scrollController;
  File _image;
  FocusNode _fNode;

  @override
  void dispose() {
    scrollController.dispose();
    _textEditingController.dispose();
    _fNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _textEditingController = TextEditingController();
    scrollController = ScrollController();
    scrollController..addListener(_scrollListener);
    _fNode = FocusNode();
    _fNode.requestFocus();
    super.initState();
  }

  _scrollListener() {
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      setState(() {
        _fNode.unfocus();
      });
    }
  }

  void _onCrossIconPressed() {
    setState(() {
      _image = null;
      // _fNode.requestFocus();
    });
  }

  void _onImageIconSelected(File file) {
    setState(() {
      _image = file;
      _fNode.unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: PostKeys.createPostPageScaffoldKey,
      drawer: SidebarMenu(),
      appBar: AppBar(
        title: Text(
          'Komsum',
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.cancel,
              color: Colors.grey,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: BlocBuilder<CreatePostBloc, CreatePostState>(
          builder: (context, state) {
            // if(state is PostCreatedInInitialize) {
              return Container(
                padding: EdgeInsets.only(
                  top: 5,
                ),
                child: Stack(
                  children: <Widget>[
                    SingleChildScrollView(
                      controller: scrollController,
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            BlocBuilder<TagFilterBloc, TagFilterState>(
                                builder: (context, tagState) {
                                  return BlocBuilder<GeographyFilterBloc,
                                      GeographyFilterState>(
                                      builder: (context, geographyState) {
                                        if (geographyState.geographyFilterList.length == 0 &&
                                            tagState.tags.length == 0) {
                                          return Container();
                                        } else {
                                          return Container(
                                            height: MediaQuery.of(context).size.height * 0.1,
                                            width: double.infinity,
                                            child: FittedBox(
                                              child: Column(
                                                children: [
                                                  TagFilterList(),
                                                  GeographyFilterList(),
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                      });
                                }),
                            SizedBox.shrink(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: TextField(
                                    controller: _textEditingController,
                                    onChanged: (text) {},
                                    maxLines: null,
                                    maxLength: 500,
                                    focusNode: _fNode,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Komsuna haber et...',
                                      hintStyle: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Stack(
                              children: <Widget>[
                                Container(
                                  child: _image == null
                                      ? Container()
                                      : Stack(
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: InteractiveViewer(
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.8,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.5,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              image: DecorationImage(
                                                image: FileImage(_image),
                                                fit: BoxFit.fill,
                                                alignment: Alignment.topRight,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.black54,
                                          ),
                                          child: IconButton(
                                            padding: EdgeInsets.all(0),
                                            iconSize: 15,
                                            onPressed: _onCrossIconPressed,
                                            icon: Icon(
                                              Icons.close,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary,
                                            ),
                                          ),
                                          width: 30,
                                          height: 30,
                                          margin: EdgeInsets.only(
                                            top: 5,
                                            right: 5,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        height: 70,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Theme.of(context).dividerColor,
                            ),
                          ),
                          color: Theme.of(context).backgroundColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: <Widget>[
                                Container(
                                  child: IconButton(
                                    onPressed: () {
                                      setImage(ImageSource.gallery);
                                    },
                                    icon: Icon(
                                      Icons.photo,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: IconButton(
                                    onPressed: () {
                                      setImage(ImageSource.camera);
                                    },
                                    icon: Icon(
                                      Icons.camera,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _createNewPost();
                                    },
                                    child: Text(
                                      'Yolla',
                                      style: TextStyle(
                                          color: Colors.white
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
      }),
    );
  }

  void setImage(ImageSource source) {
    try {
      ImagePicker()
          .getImage(source: source, imageQuality: 20)
          .then((PickedFile file) {
        setState(() {
          _onImageIconSelected(File(file.path));
        });
      });
    } catch (e) {
      setState(() {
        print(e);
      });
    }
  }

  void _createNewPost() {
    if(BlocProvider.of<GeographyFilterBloc>(context).state.geographyFilterList == null || BlocProvider.of<GeographyFilterBloc>(context).state.geographyFilterList.length == 0) {
      _showDialog("Lutfen bir sokak seciniz.");
      return;
    }
    Geography country = BlocProvider.of<GeographyFilterBloc>(context).state.geographyFilterList.firstWhere((e) => e.type == GeographyConst.country, orElse: () => Geography(218, null, null));
    Geography city = BlocProvider.of<GeographyFilterBloc>(context).state.geographyFilterList.firstWhere((e) => e.type == GeographyConst.city, orElse: () => null);
    Geography district = BlocProvider.of<GeographyFilterBloc>(context).state.geographyFilterList.firstWhere((e) => e.type == GeographyConst.district, orElse: () => null);
    Geography neighborhood = BlocProvider.of<GeographyFilterBloc>(context).state.geographyFilterList.firstWhere((e) => e.type == GeographyConst.neighborhood, orElse: () => null);
    Geography street = BlocProvider.of<GeographyFilterBloc>(context).state.geographyFilterList.firstWhere((e) => e.type == GeographyConst.street, orElse: () => null);
    List<Tag> tags = BlocProvider.of<TagFilterBloc>(context).state.tags;
    if(street == null) {
      _showDialog("Lutfen bir sokak seciniz.");
      return;
    }
    if(tags == null || tags.length == 0) {
      _showDialog("Lutfen en az bir baslik seciniz");
      return;
    }
    Post post = new Post(
      content: _textEditingController.value.text,
      countryId: country.id,
      cityId: city.id,
      districtId: district.id,
      neighborhoodId: neighborhood.id,
      streetId: street.id,
      tags: tags,
    );

    print(post.toString());
    BlocProvider.of<CreatePostBloc>(context).add(PostCreated(post, _image));
    Navigator.pop(context);
    _showDialog('Haber yolda...');
  }

  void _showDialog(String message) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: new Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text("Tamam"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
