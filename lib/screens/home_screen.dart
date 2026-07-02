import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/opportunity_state.dart';
import '../widgets/opportunity_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<OpportunityState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Opportunities'),
        backgroundColor: const Color(0xFF2563EB),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              onChanged: state.setSearchQuery,
              decoration: InputDecoration(
                hintText: 'Search by role, company, or skill',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: const Color(0xFFF8FAFC),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.opportunities.length,
              itemBuilder: (context, index) {
                final opportunity = state.opportunities[index];
                return OpportunityCard(opportunity: opportunity, state: state);
              },
            ),
          ),
        ],
      ),
    );
  }
}
