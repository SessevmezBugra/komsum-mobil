import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:komsum/geography/widget/geographyFilterListWidget.dart';
import 'package:komsum/helper/constants.dart';
import 'package:komsum/post/model/post.dart';
import 'package:komsum/tag/widget/tagFilterListWidget.dart';
import 'package:komsum/user/bloc/auth/authenticationBloc.dart';

class PostListItem extends StatelessWidget {
  final Post post;
  final host = KomsumConst.API_HOST;
  final protocol = KomsumConst.PROTOCOL;

  PostListItem(this.post);

  @override
  Widget build(BuildContext context) {
    final token =
        BlocProvider.of<AuthenticationBloc>(context).state.token.accessToken;
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
                flex: 2,
                child: Container(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RouteNames.profilePage + "/" + post.username,
                          );
                        },
                        child: ClipOval(
                          child: post.profilePictureId == null
                              ? Icon(Icons.person)
                              : Image.network(
                            '$protocol://$host/file/' +
                                post.profilePictureId,
                            headers: {
                              'Authorization': 'Bearer $token',
                            },
                            fit: BoxFit.fill,
                            loadingBuilder: (BuildContext context,
                                Widget child,
                                ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Colors.amber,
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
              Expanded(
                flex: 11,
                child: Container(
                  margin: EdgeInsets.only(
                    left: 5,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              post.firstName + " " + post.lastName,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              post.updatedAt != null
                                  ? DateFormat('dd.MM.yyyy')
                                  .format(post.updatedAt)
                                  : DateFormat('dd.MM.yyyy')
                                  .format(post.createdAt),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: FittedBox(
                          child: Column(
                            children: [
                              Wrap(
                                children: [
                                  Chip(
                                    avatar: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      child: Icon(
                                        Icons.location_on,
                                        color: Colors.green,
                                        size: 20,
                                      ),
                                    ),
                                    label: FittedBox(
                                      child: Text(
                                        post.streetName,
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    backgroundColor: Colors.grey[200],
                                  ),
                                  Chip(
                                    avatar: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      child: Icon(
                                        Icons.location_on,
                                        color: Colors.green,
                                        size: 20,
                                      ),
                                    ),
                                    label: FittedBox(
                                      child: Text(
                                        post.neighborhoodName,
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    backgroundColor: Colors.grey[200],
                                  ),
                                  Chip(
                                    avatar: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      child: Icon(
                                        Icons.location_on,
                                        color: Colors.green,
                                        size: 20,
                                      ),
                                    ),
                                    label: FittedBox(
                                      child: Text(
                                        post.districtName,
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    backgroundColor: Colors.grey[200],
                                  ),
                                  Chip(
                                    avatar: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      child: Icon(
                                        Icons.location_on,
                                        color: Colors.green,
                                        size: 20,
                                      ),
                                    ),
                                    label: FittedBox(
                                      child: Text(
                                        post.cityName,
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    backgroundColor: Colors.grey[200],
                                  ),
                                ],
                                spacing: 3,
                              ),
                              Wrap(
                                children: List.generate(
                                  post.tags.length,
                                      (index) => Chip(
                                    avatar: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      child: Icon(
                                        Icons.tag,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                    label: FittedBox(
                                      child: Text(
                                        post.tags[index].trDesc,
                                      ),
                                    ),
                                  ),
                                ),
                                spacing: 3,
                              ),
                            ],
                          ),
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
                            : ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context,
                                  RouteNames.picturePage +
                                      "/" +
                                      post.fileId);
                            },
                            child: Image.network(
                              '$protocol://$host/file/' + post.fileId,
                              headers: {
                                'Authorization': 'Bearer $token',
                              },
                              fit: BoxFit.fitWidth,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
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
