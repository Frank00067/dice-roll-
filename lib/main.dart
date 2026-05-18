import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const DiceRollApp());

class DiceRollApp extends StatelessWidget {
  const DiceRollApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dice Roll',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.deepPurple),
      home: const DiceRollScreen(),
    );
  }
}

class DiceRollScreen extends StatefulWidget {
  const DiceRollScreen({super.key});

  @override
  State<DiceRollScreen> createState() => _DiceRollScreenState();
}

class _DiceRollScreenState extends State<DiceRollScreen> {
  final _random = Random();
  List<int> _diceValues = [1, 1, 1, 1, 1];

  void _rollDice() {
    setState(() {
      _diceValues = List.generate(5, (_) => _random.nextInt(6) + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        title: const Text('Dice Roll', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF16213E),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: _diceValues
                .map((val) => Image.asset(
                      'assets/images/dice-$val.png',
                      width: 100,
                      height: 100,
                    ))
                .toList(),
          ),
          const SizedBox(height: 48),
          ElevatedButton(
            onPressed: _rollDice,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
              textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            child: const Text('Roll Dice'),
          ),
        ],
      ),
    );
  }
}
