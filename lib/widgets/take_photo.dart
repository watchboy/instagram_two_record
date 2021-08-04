import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:instagram_two_record/constants/screen_size.dart';
import 'package:instagram_two_record/models/camera_state.dart';
import 'package:instagram_two_record/screens/share_post_screen.dart';
import 'package:instagram_two_record/widgets/my_progress_indicator.dart';
import 'package:provider/provider.dart';

class TakePhoto extends StatefulWidget {
  final List<CameraDescription> cameras;

  const TakePhoto(this.cameras, {Key? key}) : super(key: key);

  @override
  _TakePhotoState createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  Widget _progress = MyProgressIndicator(containerSize: 60);

  @override
  void initState() {
    // TODO: implement initState'
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CameraState>(builder:
        (BuildContext? context, CameraState? cameraState, Widget? child) {
      return Column(
        children: [
          Container(
            width: size!.width,
            height: size!.width,
            color: Colors.black,
            child: (cameraState!.isReadyToTakePhoto)
                ? _getPreview(cameraState!)
                : _progress,
          ),
          Expanded(
            child: OutlinedButton(
                onPressed: () {
                  if(cameraState.isReadyToTakePhoto){

                  _attemptTakePhoto(cameraState,context!);
                  }

                },
                child: Text(''),
                style: outlinedButtonStyle()),
          )
        ],
      );
    });
  }

  ButtonStyle outlinedButtonStyle() {
    return ButtonStyle(
        fixedSize: MaterialStateProperty.all<Size>(
            Size(size!.width / 4, size!.width / 4)),
        shape: MaterialStateProperty.all(CircleBorder()),
        side: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
          final Color color = states.contains(MaterialState.pressed)
              ? Colors.black45
              : Colors.black12;
          return BorderSide(color: color, width: 20);
        }));
  }

  Widget _getPreview(CameraState cameraState) {
    return ClipRect(
      child: OverflowBox(
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Container(
              width: size!.width,
              height: size!.width / cameraState.controller!.value.aspectRatio,
              child: CameraPreview(cameraState.controller!)),
        ),
      ),
    );
  }

  void _attemptTakePhoto(CameraState cameraState, BuildContext context) async{
    final String timeInMilli =
        DateTime.now().millisecondsSinceEpoch.toString(); //UTC time을 가져옴
    try {
    // final path =  join((await getTemporaryDirectory()).path, '$timeInMilli.png');

      XFile pictureTaken = await cameraState.controller!.takePicture();

      File imageFile = File(pictureTaken.path);

      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>SharePostScreen(imageFile)));
    } catch (e) {}
  }
}
