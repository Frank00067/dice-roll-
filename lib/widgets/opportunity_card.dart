import 'package:flutter/material.dart';
import '../models/opportunity.dart';
import '../state/opportunity_state.dart';

class OpportunityCard extends StatelessWidget {
  const OpportunityCard({super.key, required this.opportunity, required this.state});

  final Opportunity opportunity;
  final OpportunityState state;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    opportunity.title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  onPressed: () => state.toggleBookmark(opportunity.id),
                  icon: Icon(
                    state.isBookmarked(opportunity.id) ? Icons.bookmark : Icons.bookmark_border,
                    color: const Color(0xFF2563EB),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(opportunity.company, style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Text(opportunity.description),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 8,
              children: [
                _InfoPill(label: opportunity.location),
                _InfoPill(label: opportunity.duration),
                _InfoPill(label: opportunity.category),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: state.isApplied(opportunity.id)
                    ? null
                    : () {
                        state.applyToOpportunity(opportunity.id);
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                ),
                child: Text(state.isApplied(opportunity.id) ? 'Applied ✓' : 'Apply now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF2FF),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(label, style: const TextStyle(color: Color(0xFF4338CA))),
    );
  }
}
