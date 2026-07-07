import 'package:cloud_firestore/cloud_firestore.dart';

class Opportunity {
  Opportunity({
    required this.id,
    required this.title,
    required this.company,
    required this.description,
    required this.location,
    required this.duration,
    required this.category,
    required this.isVerified,
    required this.postedAt,
  });

  final String id;
  final String title;
  final String company;
  final String description;
  final String location;
  final String duration;
  final String category;
  final bool isVerified;
  final DateTime postedAt;

  factory Opportunity.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    return Opportunity(
      id: doc.id,
      title: data?['title'] as String? ?? 'Untitled',
      company: data?['company'] as String? ?? 'Unknown',
      description: data?['description'] as String? ?? '',
      location: data?['location'] as String? ?? 'Remote',
      duration: data?['duration'] as String? ?? 'Flexible',
      category: data?['category'] as String? ?? 'General',
      isVerified: data?['isVerified'] as bool? ?? false,
      postedAt: data?['postedAt'] is Timestamp
          ? (data?['postedAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  static List<Opportunity> sampleOpportunities() {
    return [
      Opportunity(
        id: 'opp-1',
        title: 'Product Design Intern',
        company: 'Studio Nova',
        description: 'Help shape the student-first onboarding experience for a growing campus startup.',
        location: 'Kigali, Rwanda',
        duration: '6 weeks',
        category: 'Design',
        isVerified: true,
        postedAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      Opportunity(
        id: 'opp-2',
        title: 'Flutter Developer',
        company: 'ALU Founders Lab',
        description: 'Build mobile features for a platform connecting students and early-stage ventures.',
        location: 'Remote',
        duration: '8 weeks',
        category: 'Software',
        isVerified: true,
        postedAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
      Opportunity(
        id: 'opp-3',
        title: 'Community Growth Assistant',
        company: 'Impact Circle',
        description: 'Support events, storytelling, and community engagement for a student-led impact venture.',
        location: 'Hybrid',
        duration: '4 weeks',
        category: 'Community',
        isVerified: false,
        postedAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
    ];
  }
}
