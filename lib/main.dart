import 'package:flutter/material.dart';
import 'package:instagram_two_record/constants/material_white.dart';
import 'package:instagram_two_record/home_page.dart';

void main() {
  runApp(MyApp());
}

//Stateless 는 상태변화없을 위젯에 적용

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: AuthScreen(),
      home: HomePage(),
      theme: ThemeData(primarySwatch: white), // 모든화면에서 앱바 색깔을 통일시켜서 보여주고 싶기떄문, 앱의 기본색깔 지정
    );
  }
}

