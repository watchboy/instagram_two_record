import 'package:flutter/material.dart';
import 'package:instagram_two_record/constants/auth_input_deco.dart';
import 'package:instagram_two_record/constants/common_size.dart';
import 'package:instagram_two_record/models/firebase_auth_state.dart';
import 'package:instagram_two_record/widgets/or_divider.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  TextEditingController _pwCheckController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _pwCheckController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(common_gap),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            SizedBox(
              height: common_l_gap,
            ),
            Image.asset('assets/images/insta_text_logo.png'),
            TextFormField(
              cursorColor: Colors.black54,
              controller: _emailController,
              decoration: textInputDeco('Email'),
              validator: (text) {
                if (text!.isNotEmpty && text.contains("@")) {
                  return null;
                } else {
                  return '정확한 이메일 주소를 입력해주세요.';
                }
              },
            ),
            SizedBox(
              height: common_xs_gap,
            ),
            TextFormField(
              obscureText: true,
              cursorColor: Colors.grey,
              controller: _pwController,
              decoration: textInputDeco('Password'),
              validator: (text) {
                if (text!.length > 5 && text.isNotEmpty) {
                  return null;
                } else {
                  return '6자리 이상의 비밀번호를 입력해주세요.';
                }
              },
            ),
            SizedBox(
              height: common_xs_gap,
            ),
            TextFormField(
              obscureText: true,
              cursorColor: Colors.grey,
              controller: _pwCheckController,
              decoration: textInputDeco('Confirm Password'),
              validator: (text) {
                if (text!.isNotEmpty && _pwController.text == text) {
                  return null;
                } else {
                  return '입력한 비밀번호가 서로 일치하지 않습니다.';
                }
              },
            ),
            SizedBox(
              height: common_s_gap,
            ),
            _submitBtn(context),
            SizedBox(
              height: common_gap,
            ),
            OrDivider(),
            FlatButton.icon(
                textColor: Colors.blue,
                onPressed: () {
                  Provider.of<FirebaseAuthState>(context, listen: false)
                      .changeFirebaseAuthStatus(FirebaseAuthStatus.signin);
                },
                icon: ImageIcon(AssetImage('assets/images/facebook.png')),
                label: Text("login with Facebook"))
          ],
        ),
      ),
    );
  }

  FlatButton _submitBtn(BuildContext context) {
    return FlatButton(
        color: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        onPressed: () {

          if (_formKey.currentState!.validate()) {
            print('validation success');
            Provider.of<FirebaseAuthState>(context, listen: false)
                .registerUser(context, email: _emailController.text, password: _pwController.text);
          }
        },
        child: Text(
          'Join',
          style: TextStyle(color: Colors.white),
        ));
  }
}
