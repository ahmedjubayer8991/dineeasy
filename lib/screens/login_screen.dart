import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/primary_button.dart';

/// Login now performs real client-side validation (non-empty, well-formed
/// email, minimum password length) before proceeding. There is still no
/// real backend/auth service behind it -- this is expected for a
/// prototype -- but it no longer silently accepts anything, which reads
/// as more professional in a live demo and in your report's "functional
/// vs non-functional" section.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;
  bool _handledArgs = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_handledArgs) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is Map) {
        final prefillEmail = args['prefillEmail'];
        if (prefillEmail is String) _emailController.text = prefillEmail;
        if (args['accountCreated'] == true) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Account created! Please sign in.'),
                  backgroundColor: AppColors.success,
                ),
              );
            }
          });
        }
      }
      _handledArgs = true;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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

  void _signIn() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (r) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.l),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSpacing.l),
                const Text('Welcome back', style: AppTextStyles.heading),
                const SizedBox(height: 4),
                const Text('Sign in to continue to DineEasy.', style: AppTextStyles.body),
                const SizedBox(height: AppSpacing.l),
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
                    hintText: '••••••••',
                    suffixIcon: TextButton(
                      onPressed: () => setState(() => _obscure = !_obscure),
                      child: Text(_obscure ? 'Show' : 'Hide',
                          style: const TextStyle(color: AppColors.selectedOrange)),
                    ),
                  ),
                  validator: _validatePassword,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Password reset is not implemented in this prototype.')),
                      );
                    },
                    child: const Text('Forgot password?',
                        style: TextStyle(color: AppColors.selectedOrange)),
                  ),
                ),
                const SizedBox(height: AppSpacing.s),
                PrimaryButton(label: 'Sign In', onPressed: _signIn),
                const SizedBox(height: AppSpacing.m),
                const Center(child: Text('or', style: AppTextStyles.caption)),
                const SizedBox(height: AppSpacing.m),
                PrimaryButton(
                  label: 'Continue with Google',
                  outlined: true,
                  onPressed: () => Navigator.pushNamed(context, '/google-signin'),
                ),
                const SizedBox(height: AppSpacing.l),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('New to DineEasy? ', style: AppTextStyles.body),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/create-account'),
                        child: const Text('Create account',
                            style: TextStyle(color: AppColors.selectedOrange, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.m),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.m),
                  decoration: BoxDecoration(
                    color: AppColors.primaryOrange.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(AppRadius.chip),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Prototype tip',
                          style: TextStyle(color: AppColors.selectedOrange, fontWeight: FontWeight.w700)),
                      SizedBox(height: 4),
                      Text('Enter any valid-looking email and a 6+ character password to sign in.',
                          style: AppTextStyles.body),
                    ],
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
