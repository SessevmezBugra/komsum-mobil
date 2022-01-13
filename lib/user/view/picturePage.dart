import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:komsum/helper/common/loadingIndicator.dart';
import 'package:komsum/helper/constants.dart';
import 'package:komsum/user/bloc/auth/authenticationBloc.dart';
import 'package:komsum/user/bloc/picture/pictureBarrel.dart';
import 'package:photo_view/photo_view.dart';


class PicturePage extends StatefulWidget {
  final String pictureId;

  PicturePage(this.pictureId);

  @override
  State<StatefulWidget> createState() {
    return _PicturePageState();
  }
}

class _PicturePageState extends State<PicturePage> {
  final host = KomsumConst.API_HOST;
  final protocol = KomsumConst.PROTOCOL;

  File profileImage;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Future<Null> _pickImage() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    profileImage = pickedImage != null ? File(pickedImage.path) : null;
    if (profileImage != null) {
      // setState(() {
        _cropImage();
      // });
    }
  }

  Future<Null> _cropImage() async {

    File croppedFile = await ImageCropper.cropImage(
        sourcePath: profileImage.path,
        cropStyle: CropStyle.circle,
        aspectRatioPresets: [CropAspectRatioPreset.square],
        androidUiSettings: AndroidUiSettings(hideBottomControls: true),
        iosUiSettings: IOSUiSettings(
          hidesNavigationBar: true,
          rotateButtonsHidden: true,
          aspectRatioPickerButtonHidden: true,
          resetButtonHidden: true,
          rotateClockwiseButtonHidden: true,
        ));
    if (croppedFile != null) {
      profileImage = croppedFile;
      BlocProvider.of<PictureBloc>(context).add(UploadPicture(profileImage));
    }
  }

  // void _clearImage() {
  //   profileImage = null;
  //   setState(() {
  //     state = ProfilePicture.free;
  //   });
  // }

  // Widget _buildButtonIcon() {
  //   if (state == ProfilePicture.free)
  //     return Icon(Icons.add);
  //   else if (state == ProfilePicture.picked)
  //     return Icon(Icons.crop);
  //   else if (state == ProfilePicture.cropped)
  //     return Icon(Icons.clear);
  //   else
  //     return Container();
  // }

  @override
  Widget build(BuildContext context) {
    final token =
        BlocProvider.of<AuthenticationBloc>(context).state.token.accessToken;
    return BlocBuilder<PictureBloc, PictureState>(
      builder: (context, state) {
        String imageURI = '$protocol://$host/file/' + widget.pictureId;
        if (state is PictureUploadInitial) {
          imageURI = '$protocol://$host/file/' + widget.pictureId;
        } else if (state is PictureUploadSuccess) {
          imageURI = '$protocol://$host/file/' + state.pictureId;
        } else if (state is PictureUploadInProgress) {
          return LoadingIndicator();
        }

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.cancel,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            backgroundColor: Colors.black,
          ),
          body: PhotoView(
            imageProvider: NetworkImage(
              imageURI,
              headers: {
                'Authorization': 'Bearer $token',
              },
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            child: Container(
              child: TextButton(
                child: Text('Fotograf Sec'),
                onPressed: () {
                  _pickImage();
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
