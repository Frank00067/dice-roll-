import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/opportunity.dart';

class OpportunityState extends ChangeNotifier {
  OpportunityState() {
    _opportunities = Opportunity.sampleOpportunities();
  }

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late List<Opportunity> _opportunities;
  final Set<String> _bookmarkedIds = <String>{};
  final Set<String> _appliedIds = <String>{};
  String _searchQuery = '';
  String? _userId;
  StreamSubscription<QuerySnapshot>? _opportunitySubscription;
  StreamSubscription<DocumentSnapshot>? _userSubscription;

  List<Opportunity> get opportunities {
    final query = _searchQuery.toLowerCase();
    return _opportunities.where((opportunity) {
      final matchesQuery = query.isEmpty ||
          opportunity.title.toLowerCase().contains(query) ||
          opportunity.company.toLowerCase().contains(query) ||
          opportunity.category.toLowerCase().contains(query);
      return matchesQuery;
    }).toList();
  }

  bool isBookmarked(String id) => _bookmarkedIds.contains(id);

  bool isApplied(String id) => _appliedIds.contains(id);

  void setUser(User? user) {
    if (_userId == user?.uid) return;
    _userId = user?.uid;
    _subscribeToOpportunityStream();
    _subscribeToUserDocument();
  }

  void _subscribeToOpportunityStream() {
    _opportunitySubscription?.cancel();
    _opportunitySubscription = _db.collection('opportunities').snapshots().listen((snapshot) {
      _opportunities = snapshot.docs
          .map((doc) => Opportunity.fromFirestore(doc))
          .toList();
      notifyListeners();
    }, onError: (_) {
      // Keep sample data in case Firestore is unavailable.
      _opportunities = Opportunity.sampleOpportunities();
      notifyListeners();
    });
  }

  void _subscribeToUserDocument() {
    _userSubscription?.cancel();
    if (_userId == null) {
      _bookmarkedIds.clear();
      _appliedIds.clear();
      notifyListeners();
      return;
    }

    _userSubscription = _db.collection('users').doc(_userId).snapshots().listen((snapshot) {
      final data = snapshot.data();
      _bookmarkedIds
        ..clear()
        ..addAll(List<String>.from(data?['bookmarks'] ?? <String>[]));
      _appliedIds
        ..clear()
        ..addAll(List<String>.from(data?['applications'] ?? <String>[]));
      notifyListeners();
    });
  }

  void setSearchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  Future<void> toggleBookmark(String id) async {
    if (_bookmarkedIds.contains(id)) {
      _bookmarkedIds.remove(id);
    } else {
      _bookmarkedIds.add(id);
    }
    notifyListeners();
    await _saveUserData();
  }

  Future<void> applyToOpportunity(String id) async {
    _appliedIds.add(id);
    notifyListeners();
    await _saveUserData();
  }

  Future<void> _saveUserData() async {
    if (_userId == null) return;

    await _db.collection('users').doc(_userId).set({
      'bookmarks': _bookmarkedIds.toList(),
      'applications': _appliedIds.toList(),
    }, SetOptions(merge: true));
  }

  @override
  void dispose() {
    _opportunitySubscription?.cancel();
    _userSubscription?.cancel();
    super.dispose();
  }
}
