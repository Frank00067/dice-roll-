import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/auth_state.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isRegister = false;

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in to ALU Venture Link'),
        backgroundColor: const Color(0xFF2563EB),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Email', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextField(controller: _emailController, keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 16),
            const Text('Password', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextField(controller: _passwordController, obscureText: true),
            const SizedBox(height: 20),
            if (authState.errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(authState.errorMessage!, style: const TextStyle(color: Colors.red)),
              ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: authState.isLoading ? null : () async {
                  final email = _emailController.text.trim();
                  final password = _passwordController.text.trim();
                  if (email.isEmpty || password.isEmpty) {
                    authState.setError('Please enter both email and password.');
                    return;
                  }
                  if (_isRegister) {
                    await authState.register(email, password);
                  } else {
                    await authState.signIn(email, password);
                  }
                  if (!mounted) return;
                  if (context.mounted && authState.user != null) {
                    Navigator.of(context).pushReplacementNamed('/home');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(authState.isLoading ? 'Please wait...' : _isRegister ? 'Create account' : 'Sign in'),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                setState(() {
                  _isRegister = !_isRegister;
                  authState.setError(null);
                });
              },
              child: Text(_isRegister ? 'Already have an account? Sign in' : 'New to ALU Venture Link? Register'),
            ),
          ],
        ),
      ),
    );
  }
}
