import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:komsum/geography/widget/geographyFilterListWidget.dart';
import 'package:komsum/helper/constants.dart';
import 'package:komsum/post/model/post.dart';
import 'package:komsum/tag/widget/tagFilterListWidget.dart';

class PostListItem extends StatelessWidget {
  final Post post;
  final host = KomsumConst.host;

  PostListItem(this.post);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 2,
        bottom: 2,
        right: 5,
        left: 5,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: Column(
                    children: [
                      CircleAvatar(
                        child: Icon(Icons.person),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                child: Container(
                  margin: EdgeInsets.only(
                    left: 5,
                  ),
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            
                          ],
                        ),
                      ),
                      Container(
                        child: Text(
                          post.content,
                        ),
                        width: MediaQuery.of(context).size.width,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: post.fileId == null
                            ? Container()
                            :
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            'http://$host:8094/file/' +
                                post.fileId,
                            fit: BoxFit.fitWidth,
                            loadingBuilder:
                                (BuildContext context,
                                Widget child,
                                ImageChunkEvent
                                loadingProgress) {
                              if (loadingProgress == null)
                                return child;
                              return Center(
                                child:
                                CircularProgressIndicator(
                                  value: loadingProgress
                                      .expectedTotalBytes !=
                                      null
                                      ? loadingProgress
                                      .cumulativeBytesLoaded /
                                      loadingProgress
                                          .expectedTotalBytes
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }

}