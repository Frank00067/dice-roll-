import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';
import 'screens/onboarding_screen.dart';
import 'state/auth_state.dart';
import 'state/opportunity_state.dart';

class ALUVentureApp extends StatefulWidget {
  const ALUVentureApp({super.key});

  @override
  State<ALUVentureApp> createState() => _ALUVentureAppState();
}

class _ALUVentureAppState extends State<ALUVentureApp> {
  late final Future<FirebaseApp> _initialization;

  @override
  void initState() {
    super.initState();
    _initialization = Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    'Firebase initialization failed. Please add your Firebase configuration.\n\n${snapshot.error}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          );
        }

        if (snapshot.connectionState != ConnectionState.done) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthState()),
            ChangeNotifierProxyProvider<AuthState, OpportunityState>(
              create: (_) => OpportunityState(),
              update: (_, authState, opportunityState) => opportunityState!..setUser(authState.user),
            ),
          ],
          child: MaterialApp(
            title: 'ALU Venture Link',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2563EB)),
              useMaterial3: true,
            ),
            home: const AppEntry(),
            routes: {
              '/auth': (context) => const AuthScreen(),
              '/home': (context) => const HomeScreen(),
            },
          ),
        );
      },
    );
  }
}

class AppEntry extends StatelessWidget {
  const AppEntry({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthState>();
    if (authState.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return authState.user != null ? const HomeScreen() : const OnboardingScreen();
  }
}
