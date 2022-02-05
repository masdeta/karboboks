import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<Map<String, dynamic>?> fetchQuantity() async {
    try{
      var ref = _db.collection('data').doc('product');
      var doc = await ref.get();
      var data = doc.data();
      return data;
    } catch (e) {
      return null;
    }
  }
}
