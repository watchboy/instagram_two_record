import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_two_record/constants/firestore_keys.dart';
import 'package:instagram_two_record/models/firestore/user_model.dart';
import 'package:instagram_two_record/repo/helper/transformers.dart';

class UserNetworkRepository with Transformers{
  Future<void> attemptCreateUser({String? userKey,String? email}) async{
    final DocumentReference userRef = FirebaseFirestore.instance.collection(COLLECTION_USERS)
        .doc(userKey);
    
    DocumentSnapshot snapshot = await userRef.get();
    if(!snapshot.exists){
     return await userRef.set(UserModel.getMapForCreateUser(email!));
    }
  }

 /* Stream<UserModel> getUserModelStream(String userKey){
    return FirebaseFirestore.instance
        .collection(COLLECTION_USERS).doc(userKey)
        .snapshots().transform(toUser);
  }*/
}

UserNetworkRepository userNetworkRepository = UserNetworkRepository();