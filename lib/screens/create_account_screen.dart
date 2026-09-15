import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/primary_button.dart';

/// Account creation is mocked (no real backend), but now has genuine
/// client-side validation so it behaves like a real signup form rather
/// than silently accepting anything.
class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    final emailPattern = RegExp(r'^[\w\.\-]+@[\w\-]+\.[a-zA-Z]{2,}$');
    if (!emailPattern.hasMatch(value.trim())) return 'Enter a valid email address';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  String? _validateConfirm(String? value) {
    if (value != _passwordController.text) return 'Passwords do not match';
    return null;
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // Send the user back to Login to sign in with the account they just
      // created, rather than skipping straight into the app -- this is
      // the realistic flow and was flagged as a gap in testing.
      Navigator.pushReplacementNamed(
        context,
        '/login',
        arguments: {
          'prefillEmail': _emailController.text.trim(),
          'accountCreated': true,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.l),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Create account', style: AppTextStyles.heading),
                const SizedBox(height: 4),
                const Text('Join DineEasy to start booking tables.', style: AppTextStyles.body),
                const SizedBox(height: AppSpacing.l),

                const Text('Full name', style: AppTextStyles.bodyDark),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(hintText: 'Alex Morgan'),
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Name is required' : null,
                ),
                const SizedBox(height: AppSpacing.m),

                const Text('Email', style: AppTextStyles.bodyDark),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(hintText: 'alex@example.com'),
                  validator: _validateEmail,
                ),
                const SizedBox(height: AppSpacing.m),

                const Text('Password', style: AppTextStyles.bodyDark),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscure,
                  decoration: InputDecoration(
                    hintText: 'At least 6 characters',
                    suffixIcon: TextButton(
                      onPressed: () => setState(() => _obscure = !_obscure),
                      child: Text(_obscure ? 'Show' : 'Hide',
                          style: const TextStyle(color: AppColors.selectedOrange)),
                    ),
                  ),
                  validator: _validatePassword,
                ),
                const SizedBox(height: AppSpacing.m),

                const Text('Confirm password', style: AppTextStyles.bodyDark),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _confirmController,
                  obscureText: _obscure,
                  decoration: const InputDecoration(hintText: 'Re-enter your password'),
                  validator: _validateConfirm,
                ),
                const SizedBox(height: AppSpacing.l),

                PrimaryButton(label: 'Create Account', onPressed: _submit),
                const SizedBox(height: AppSpacing.m),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Already have an account? Sign in',
                        style: TextStyle(color: AppColors.selectedOrange, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
