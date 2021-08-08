import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_two_record/repo/user_network_repository.dart';

class FirebaseAuthState extends ChangeNotifier {
  FirebaseAuthStatus _firebaseAuthStatus = FirebaseAuthStatus.signout;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? _firebaseUser;

  void watchAuthChange() {
    _firebaseAuth.authStateChanges().listen((firebaseUser) {
      if (_firebaseUser == null && firebaseUser == null) {
        changeFirebaseAuthStatus();
        return;
      } else if (_firebaseUser != firebaseUser) {
        _firebaseUser = firebaseUser;
        changeFirebaseAuthStatus();
      }
    });
  }

  void registerUser(BuildContext context, {required String email, required String password}) async {

      UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email.trim(), password: password.trim())
        .catchError((error) {
      String _message = error.code;
      print(_message);
     switch (error.code) {
        case 'weak-password':
          _message = "패스워드를 잘 넣어주세요";
          break;
        case 'invalid-email':
          _message = "유효하지 않은 이메일 주소 형식입니다.";
          break;
        case 'email-already-in-use':
          _message = "이미 등록된 이메일 입니다.";
          break;
      }
      SnackBar snackBar = SnackBar(content: Text(_message));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });

      _firebaseUser = userCredential.user!;
      if(_firebaseUser==null){
        SnackBar snackBar = SnackBar(content: Text("plz try again later"),);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }else {
        await userNetworkRepository.attemptCreateUser(
            userKey: _firebaseUser!.uid,
            email: _firebaseUser!.email);
      }
  }

  void login(BuildContext context, {required String email, required String password}) {

    _firebaseAuth.signInWithEmailAndPassword(email: email, password: password).catchError((error){
      String _message = error.code;
      print(_message);

      switch (error.code) {
        case 'invalid-email':
          _message = "잘못된 이메일 형식입니다.";
          break;
        case 'user-disabled':
          _message = "사용 불가능한 이메일입니다.";
          break;
        case 'user-not-found':
          _message = "찾을 수 없는 유저입니다.";
          break;
        case 'wrong-password':
          _message = "비밀번호가 틀립니다.";
          break;
    }
      SnackBar snackBar = SnackBar(content: Text(_message));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    });

  }

  void signOut() {
    _firebaseAuthStatus = FirebaseAuthStatus.signout;
    if (_firebaseUser != null) {
      _firebaseUser = null;
      _firebaseAuth.signOut();
    }
    notifyListeners();
  }

  void changeFirebaseAuthStatus([FirebaseAuthStatus? firebaseAuthStatus]) {
    if (firebaseAuthStatus != null) {
      _firebaseAuthStatus = firebaseAuthStatus;
    } else {
      if (_firebaseUser != null) {
        _firebaseAuthStatus = FirebaseAuthStatus.signin;
      } else {
        _firebaseAuthStatus = FirebaseAuthStatus.signout;
      }
    }
    notifyListeners();
  }

  FirebaseAuthStatus get firebaseAuthStatus => _firebaseAuthStatus;
  User? get firebaseUser => _firebaseUser;
}

enum FirebaseAuthStatus { signout, progress, signin }
