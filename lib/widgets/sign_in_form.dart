import 'package:flutter/material.dart';
import 'package:instagram_two_record/constants/auth_input_deco.dart';
import 'package:instagram_two_record/constants/common_size.dart';
import 'package:instagram_two_record/widgets/or_divider.dart';
import '../home_page.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwController = TextEditingController();

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
            TextButton(
              onPressed: () {},
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Forgotten password?',
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: common_xs_gap,
            ),
            SizedBox(
              height: common_s_gap,
            ),
            _submitBtn(context),
            SizedBox(
              height: common_gap,
            ),
            OrDivider(),
            TextButton.icon(
                style: TextButton.styleFrom(primary: Colors.blue),
                //    textColor: Colors.blue,
                onPressed: () {},
                icon: ImageIcon(AssetImage('assets/images/facebook.png')),
                label: Text("login with Facebook"))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  TextButton _submitBtn(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(

            backgroundColor: Colors.blue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            print('validation success');
            Navigator.of(context).pushReplacement(
                //replacement는 기존화면 없애고 새로운화면, push는 기존화면뒤로보내고 새로운화면
                MaterialPageRoute(builder: (context) => HomePage()));
          }
        },
        child: Text(
          'Sign In',
          style: TextStyle(color: Colors.white),
        ));
  }
}
