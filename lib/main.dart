import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_two_record/constants/material_white.dart';
import 'package:instagram_two_record/home_page.dart';
import 'package:instagram_two_record/models/firebase_auth_state.dart';
import 'package:instagram_two_record/models/user_model_state.dart';
import 'package:instagram_two_record/repo/user_network_repository.dart';
import 'package:instagram_two_record/screens/auth_screen.dart';
import 'package:instagram_two_record/widgets/my_progress_indicator.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

//Stateless 는 상태변화없을 위젯에 적용

class MyApp extends StatelessWidget {
  final FirebaseAuthState _firebaseAuthState = FirebaseAuthState();
  Widget? _currentWidget;

  @override
  Widget build(BuildContext context) {
    _firebaseAuthState.watchAuthChange();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FirebaseAuthState>.value(
            value: _firebaseAuthState),
        ChangeNotifierProvider<UserModelState>(
          create: (_) => UserModelState(),),
      ],
      child: MaterialApp(
        //home: AuthScreen(),
        home: Consumer<FirebaseAuthState>(builder:
            (BuildContext context, FirebaseAuthState value, Widget? child) {
          switch (value.firebaseAuthStatus) {
            case FirebaseAuthStatus.signout:
              _currentWidget = AuthScreen();
              // TODO: Handle this case.
              break;
            case FirebaseAuthStatus.signin:
           /*   userNetworkRepository.getUserModelStream(value.firebaseUser!.uid).
              listen((userModel) {
                Provider.of<UserModelState>(context).userModel =
                    userModel;
              });*/
            // TODO: Handle this case.
              _currentWidget = HomePage();
              break;
            default:
              _currentWidget = MyProgressIndicator(containerSize: 60);
          }
          return AnimatedSwitcher(
            duration: Duration(microseconds: 300),
            switchInCurve: Curves.fastOutSlowIn,
            switchOutCurve: Curves.fastOutSlowIn,
            child: _currentWidget,
          );
        }),
        theme: ThemeData(
            primarySwatch: white), // 모든화면에서 앱바 색깔을 통일시켜서 보여주고 싶기떄문, 앱의 기본색깔 지정
      ),
    );
  }
}
