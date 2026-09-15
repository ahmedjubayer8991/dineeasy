import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/primary_button.dart';

/// A real Google Sign-In integration needs Firebase/OAuth credentials and
/// platform config that are out of scope for this prototype. Rather than
/// silently skipping straight to Home (which looked broken), this screen
/// gives "Continue with Google" a real, visible consequence: a short
/// loading state, a mocked account-picker, and -- if the user chooses
/// "Use another account" -- an actual add-account step, rather than that
/// option also silently jumping straight into the app. All of it is
/// clearly labelled as a prototype simulation, not genuine Google UI.
class GoogleSignInScreen extends StatefulWidget {
  const GoogleSignInScreen({super.key});

  @override
  State<GoogleSignInScreen> createState() => _GoogleSignInScreenState();
}

enum _GoogleStep { loading, pickAccount, addAccount }

class _GoogleSignInScreenState extends State<GoogleSignInScreen> {
  _GoogleStep _step = _GoogleStep.loading;
  final _addAccountFormKey = GlobalKey<FormState>();
  final _newEmailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 900), () {
      if (mounted) setState(() => _step = _GoogleStep.pickAccount);
    });
  }

  @override
  void dispose() {
    _newEmailController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    final emailPattern = RegExp(r'^[\w\.\-]+@[\w\-]+\.[a-zA-Z]{2,}$');
    if (!emailPattern.hasMatch(value.trim())) return 'Enter a valid email address';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.l),
          child: switch (_step) {
            _GoogleStep.loading => _buildLoading(),
            _GoogleStep.pickAccount => _buildAccountPicker(context),
            _GoogleStep.addAccount => _buildAddAccount(context),
          },
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: AppColors.selectedOrange),
          SizedBox(height: AppSpacing.m),
          Text('Connecting to Google...', style: AppTextStyles.body),
        ],
      ),
    );
  }

  Widget _buildAccountPicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
            const SizedBox(width: 4),
            const Text('Choose an account', style: AppTextStyles.subheading),
          ],
        ),
        const SizedBox(height: 4),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.s),
          child: Text(
            'Prototype simulation — not a real Google sign-in.',
            style: TextStyle(fontSize: 11, color: AppColors.textMuted, fontStyle: FontStyle.italic),
          ),
        ),
        const SizedBox(height: AppSpacing.l),
        _AccountTile(
          name: 'Alex Morgan',
          email: 'alex@example.com',
          onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/home', (r) => false),
        ),
        const Divider(height: AppSpacing.l),
        ListTile(
          leading: const Icon(Icons.add_circle_outline, color: AppColors.selectedOrange),
          title: const Text('Use another account', style: AppTextStyles.bodyDark),
          onTap: () => setState(() => _step = _GoogleStep.addAccount),
        ),
      ],
    );
  }

  Widget _buildAddAccount(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _addAccountFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => setState(() => _step = _GoogleStep.pickAccount),
                ),
                const SizedBox(width: 4),
                const Text('Add account', style: AppTextStyles.subheading),
              ],
            ),
            const SizedBox(height: 4),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.s),
              child: Text(
                'Prototype simulation — not a real Google sign-in.',
                style: TextStyle(fontSize: 11, color: AppColors.textMuted, fontStyle: FontStyle.italic),
              ),
            ),
            const SizedBox(height: AppSpacing.l),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.s),
              child: Text('Enter the Google account email to continue with.', style: AppTextStyles.body),
            ),
            const SizedBox(height: AppSpacing.m),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
              child: TextFormField(
                controller: _newEmailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(hintText: 'you@example.com'),
                validator: _validateEmail,
              ),
            ),
            const SizedBox(height: AppSpacing.l),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
              child: PrimaryButton(
                label: 'Continue',
                onPressed: () {
                  if (_addAccountFormKey.currentState!.validate()) {
                    Navigator.pushNamedAndRemoveUntil(context, '/home', (r) => false);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AccountTile extends StatelessWidget {
  final String name;
  final String email;
  final VoidCallback onTap;

  const _AccountTile({required this.name, required this.email, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.chip),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.s),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 22,
              backgroundColor: AppColors.selectedOrange,
              child: Text('A', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
            ),
            const SizedBox(width: AppSpacing.s),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.bodyDark.copyWith(fontWeight: FontWeight.w600)),
                Text(email, style: AppTextStyles.caption),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
