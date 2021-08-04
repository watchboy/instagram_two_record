import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:instagram_two_record/widgets/post.dart';

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        //안드로이드는 자동 좌측부터, 아이폰은 센터부터여서 cupertino로
        leading: IconButton(
            onPressed: null,
            icon: Icon(
              CupertinoIcons.photo_camera_solid,
              color: Colors.black87,
            )),
        middle: Text(
          'Kstagram',
          style: TextStyle(fontFamily: 'InstaFont', color: Colors.black87),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              onPressed: null,
              icon: ImageIcon(
                AssetImage('assets/images/actionbar_camera.png'),
                color: Colors.black87,
              ),
            ),
            IconButton(
              onPressed: null,
              icon: ImageIcon(
                AssetImage('assets/images/actionbar_camera.png'),
                color: Colors.black87,
              ),
            )
          ],
        ),
      ),
      body: ListView.builder(
        itemBuilder: feedListBuilder,
        itemCount: 30,
      ),
    );
  }

  Widget feedListBuilder(BuildContext context, int index) {
    return Post(index);
  }
}

