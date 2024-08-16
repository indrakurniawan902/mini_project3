import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:indie_commerce/models/status_model.dart';

class PaymentService {
  /// singleton
  static final PaymentService instance = PaymentService._internal();
  PaymentService._internal();
  factory PaymentService() {
    return instance;
  }

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<String> addToStatus(StatusModel data, String uid) async {
    try {
      await firebaseFirestore
          .collection("users")
          .doc(uid)
          .collection("payment")
          .add({
        "date": DateTime.now().toString(),
        "total": data.total,
        "items": FieldValue.arrayUnion(data.items),
        "paymentMethod": data.paymentMethod,
        "status": data.status,
        "id" : FieldValue.increment(1)
      });
      return "Success Add Status";
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<StatusModel>> getAllStatus(String uid) async {
    try {
      final response = await firebaseFirestore
          .collection("users")
          .doc(uid)
          .collection("payment")
          .get();
      List<StatusModel> data =
          (response.docs as List).map((e) => StatusModel.fromJson(e.data())).toList();
      log(data.toString());
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
