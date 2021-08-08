import 'package:flutter/material.dart';
import 'package:instagram_two_record/models/firebase_auth_state.dart';
import 'package:provider/provider.dart';

const duration = Duration(milliseconds: 1000);

class ProfileSideMenu extends StatelessWidget {
  final double menuWidth;

  const ProfileSideMenu(
    this.menuWidth, {
    Key? key,
  }) : super(key: key); //중괄호 밖에 두면 require, 안에두면 option

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: menuWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                'Setting',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.black87,
              ),
              title: Text('Sign Out'),
              onTap: () {
                Provider.of<FirebaseAuthState>(context, listen: false).signOut();
              },
            )
          ],
        ),
      ),
    );
  }
}
