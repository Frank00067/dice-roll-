import 'package:flutter/material.dart';
import '../models/opportunity.dart';

class OpportunityState extends ChangeNotifier {
  OpportunityState({List<Opportunity>? initialOpportunities}) {
    _opportunities = initialOpportunities ?? Opportunity.sampleOpportunities();
  }

  late List<Opportunity> _opportunities;
  final Set<String> _bookmarkedIds = <String>{};
  final Set<String> _appliedIds = <String>{};
  String _searchQuery = '';

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

  void setSearchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  void toggleBookmark(String id) {
    if (_bookmarkedIds.contains(id)) {
      _bookmarkedIds.remove(id);
    } else {
      _bookmarkedIds.add(id);
    }
    notifyListeners();
  }

  void applyToOpportunity(String id) {
    _appliedIds.add(id);
    notifyListeners();
  }
}
