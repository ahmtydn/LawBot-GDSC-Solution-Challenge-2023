import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:law_bot/model/case_model.dart';

class FirebaseService extends ChangeNotifier {
  static FirebaseService? _instance;
  static FirebaseService get instance {
    _instance ??= FirebaseService();
    return _instance!;
  }

  late FirebaseFirestore _firestore;

  FirebaseService() {
    _firestore = FirebaseFirestore.instance;
  }

  Future<List<CaseModel>> getCases() async {
    final snapshot = await _firestore.collection('cases').get();
    final cases =
        snapshot.docs.map((doc) => CaseModel.fromJson(doc.data())).toList();
    return cases;
  }

  Stream<List<CaseModel>> streamCases() {
    return _firestore.collection('cases').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => CaseModel.fromJson(doc.data()))
          .toList();
    });
  }

  Future<String> addCase(CaseModel newCase) async {
    final docRef = await _firestore.collection('cases').add(newCase.toJson());
    final addedDoc = await docRef.get();

    return addedDoc.id;
  }

  Future<double> getRating(String id) async {
    final data =
        await FirebaseFirestore.instance.collection('cases').doc(id).get();
    return data.data()?['rating'] ?? 0.0;
  }

  Future<void> updateRating(double rating, String id) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('cases').doc(id).get();

    if (snapshot.exists) {
      FirebaseFirestore.instance
          .collection('cases')
          .doc(id)
          .set({"rating": rating}, SetOptions(merge: true));
    } else {
      FirebaseFirestore.instance
          .collection('cases')
          .doc(id)
          .set({"rating": rating});
    }
  }

  Future<void> updateCase(String id, CaseModel updatedCase) async {
    final docRef = _firestore.collection('cases').doc(id);
    await docRef.update(updatedCase.toJson());
  }

  Future<void> deleteCase(String id) async {
    final docRef = _firestore.collection('cases').doc(id);
    await docRef.delete();
  }
}
