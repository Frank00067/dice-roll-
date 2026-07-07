import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/opportunity.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Opportunity>> getOpportunitiesStream() {
    return _db.collection('opportunities').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Opportunity.fromFirestore(doc)).toList();
    });
  }
}
