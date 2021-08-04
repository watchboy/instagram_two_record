import 'package:flutter/material.dart';
import 'package:instagram_two_record/widgets/fade_stack.dart';
import 'package:instagram_two_record/widgets/profile_side_menu.dart';
import 'package:instagram_two_record/widgets/sign_in_form.dart';
import 'package:instagram_two_record/widgets/sign_up_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int selectedForm = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(children: [
          FadeStack(
            selectedForm: selectedForm,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: MediaQuery.of(context).size.height/12,
            child: Container(
              color: Colors.white,
              child: FlatButton(
                shape: Border(top: BorderSide(color: Colors.grey)),

                onPressed: () {
                  setState(() {
                    if (selectedForm == 0) {
                      selectedForm = 1;
                    } else {
                      selectedForm = 0;
                    }
                  });
                },
                child: RichText(
                  text: TextSpan(
                      text: (selectedForm == 0)?"Already have an account?": "Don't have an account?",
                      style: TextStyle(color: Colors.grey),
                      children: [
                        TextSpan(
                            text: (selectedForm == 0)?" Sign In": " Sign Up",
                            style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold)),
                        TextSpan(),
                        TextSpan()
                      ]),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
