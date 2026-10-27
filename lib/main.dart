
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PawPal Signup',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const SignupPage(),
    );
  }
}

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController =
      TextEditingController();
  final TextEditingController _emailController =
      TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController();
  final TextEditingController _confirmController =
      TextEditingController();

  // Task A: Signup Coach state
  String? _tip;
  String? _tipError;
  bool _isLoading = false;

  // Preset tips stored locally.
  // The Signup Coach never reads personal form information.
  final List<String> _tips = [
    'Use a unique password for every account.',
    'A longer password or passphrase can be easier to remember.',
    'Never share your password with other people.',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  // Validate full name
  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your full name';
    }
    return null;
  }

  // Validate email
  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email address';
    }

    final emailPattern = RegExp(
      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
    );

    if (!emailPattern.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  // Validate password
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  // Task C: Confirm password validation
  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }

    return null;
  }

  // Task C: Successful signup with personalized welcome
  void _signUp() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Welcome, ${_nameController.text.trim()}! '
            'Your signup was successful.',
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  // Task A: Local Signup Coach
  Future<void> _getSignupTip() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _tip = null;
      _tipError = null;
    });

    // Simulate processing locally; no network requests.
    await Future.delayed(
      const Duration(milliseconds: 800),
    );

    if (!mounted) return;

    setState(() {
      if (_tips.isEmpty) {
        _tipError =
            'No tips are available. Please try again.';
      } else {
        // Fixed category: password_help.
        // Form values are not used to select a tip.
        _tip = _tips[0];
      }

      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PawPal Signup 🐾'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.pets,
                  size: 64,
                  color: Colors.deepPurple,
                ),

                const SizedBox(height: 12),

                const Text(
                  'Join the PawPal Club!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 24),

                // Full Name
                TextFormField(
                  controller: _nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: _validateName,
                ),

                const SizedBox(height: 16),

                // Email Address
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  validator: _validateEmail,
                ),

                const SizedBox(height: 16),

                // Password
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  validator: _validatePassword,
                ),

                const SizedBox(height: 16),

                // Task C: Confirm Password
                TextFormField(
                  controller: _confirmController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(),
                  ),
                  validator: _validateConfirmPassword,
                ),

                const SizedBox(height: 24),

                // Sign Up button
                ElevatedButton(
                  onPressed: _signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18),
                  ),
                ),

                const SizedBox(height: 32),
                const Divider(),
                const SizedBox(height: 12),

                // Task A: Signup Coach
                const Text(
                  'Signup Coach — Preset Tips',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Get a helpful signup tip stored locally.',
                ),

                const SizedBox(height: 12),

                ElevatedButton.icon(
                  onPressed:
                      _isLoading ? null : _getSignupTip,
                  icon: const Icon(Icons.lightbulb_outline),
                  label: const Text('Get a signup tip'),
                ),

                // Loading state
                if (_isLoading) ...[
                  const SizedBox(height: 16),
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Preparing your signup tip...',
                    textAlign: TextAlign.center,
                  ),
                ],

                // Error and retry state
                if (_tipError != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    _tipError!,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      onPressed: _isLoading
                          ? null
                          : _getSignupTip,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ),
                ],

                // Preset tip result
                if (_tip != null) ...[
                  const SizedBox(height: 12),
                  const Text(
                    'Preset content — not live AI output',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    color: Colors.deepPurple.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.tips_and_updates,
                            color: Colors.deepPurple,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(_tip!),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
