import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_two_record/models/firestore/user_model.dart';

class Transformers{
  final toUser = StreamTransformer<DocumentSnapshot, UserModel>.fromHandlers(
    handleData: (snapshot, sink) async{
      sink.add(UserModel.fromSnapshot(snapshot));
    }
  );

}