import 'package:cloud_firestore/cloud_firestore.dart';

class Databasemethod {
  Future adduserDetail(Map<String, dynamic> userinfoMap, String id) async {
    return FirebaseFirestore.instance
        .collection("UserDetail")
        .doc(id)
        .set(userinfoMap);
  }
}
