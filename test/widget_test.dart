import 'package:flutter_test/flutter_test.dart';

import 'package:dice_roll/main.dart';

void main() {
  testWidgets('shows the ALU venture onboarding experience', (tester) async {
    await tester.pumpWidget(const ALUVentureApp());

    expect(find.text('ALU Venture Link'), findsOneWidget);
    expect(find.text('Find internships that matter'), findsOneWidget);
  });
}
