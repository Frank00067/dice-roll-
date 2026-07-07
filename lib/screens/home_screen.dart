import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/auth_state.dart';
import '../state/opportunity_state.dart';
import '../widgets/opportunity_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthState>();
    final state = context.watch<OpportunityState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Opportunities'),
        backgroundColor: const Color(0xFF2563EB),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () async {
              await authState.signOut();
              if (!context.mounted) return;
              Navigator.of(context).pushReplacementNamed('/auth');
            },
            icon: const Icon(Icons.logout),
            tooltip: 'Sign out',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome, ${authState.user?.email ?? 'ALU student'}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                TextField(
                  onChanged: state.setSearchQuery,
                  decoration: InputDecoration(
                    hintText: 'Search by role, company, or skill',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: const Color(0xFFF8FAFC),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ],
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
