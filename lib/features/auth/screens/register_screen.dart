import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/router/route_names.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/validators.dart';
import '../../../shared/widgets/app_background.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/app_toast.dart';
import '../providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    // Jalankan semua validator; berhenti kalau ada yang gagal
    if (!_formKey.currentState!.validate()) return;

    final auth = context.read<AuthProvider>();

    final success = await auth.register(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    if (!mounted) return;

    if (success) {
      // Toast menempel di Overlay atas, jadi tetap terlihat setelah pindah halaman
      AppToast.success(context, 'Registration successful, please log in');
      context.go(Routes.login);
    } else {
      AppToast.error(context, auth.errorMessage ?? 'There is an error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AuthProvider>().isLoading;

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Tombol kembali ke Login
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.xs),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: isLoading ? null : () => context.go(Routes.login),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      AppSizes.lg,
                      0,
                      AppSizes.lg,
                      AppSizes.lg,
                    ),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 480),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Header di atas kartu (sama gaya dengan Login)
                          Center(
                            child: Container(
                              padding: const EdgeInsets.all(AppSizes.md),
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                borderRadius:
                                    BorderRadius.circular(AppSizes.radiusLg),
                                border: Border.all(color: AppColors.border),
                              ),
                              child: const Icon(
                                Icons.person_add_alt_outlined,
                                size: 32,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSizes.md),
                          Text(
                            'Create an account',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.h2,
                          ),
                          const SizedBox(height: AppSizes.xs),
                          Text(
                            'Complete the data below',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.caption,
                          ),
                          const SizedBox(height: AppSizes.lg),

                          // Form di dalam kartu
                          AppCard(
                            padding: const EdgeInsets.all(AppSizes.lg),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  AppTextField(
                                    label: 'Full name',
                                    hint: 'Your full name',
                                    controller: _nameController,
                                    prefixIcon: Icons.person_outline,
                                    textInputAction: TextInputAction.next,
                                    validator: (v) =>
                                        Validators.required(v, field: 'Nama'),
                                  ),
                                  const SizedBox(height: AppSizes.md),
                                  AppTextField(
                                    label: 'Email',
                                    hint: 'account@email.com',
                                    controller: _emailController,
                                    prefixIcon: Icons.email_outlined,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    validator: Validators.email,
                                  ),
                                  const SizedBox(height: AppSizes.md),
                                  AppTextField(
                                    label: 'Password',
                                    hint: 'Minimum 6 characters',
                                    controller: _passwordController,
                                    prefixIcon: Icons.lock_outline,
                                    isPassword: true,
                                    textInputAction: TextInputAction.next,
                                    validator: Validators.password,
                                  ),
                                  const SizedBox(height: AppSizes.md),
                                  AppTextField(
                                    label: 'Confirm password',
                                    hint: 'Repeat password',
                                    controller: _confirmController,
                                    prefixIcon: Icons.lock_outline,
                                    isPassword: true,
                                    textInputAction: TextInputAction.done,
                                    validator: (v) => Validators.confirmPassword(
                                        v, _passwordController.text),
                                  ),
                                  const SizedBox(height: AppSizes.lg),
                                  AppButton(
                                    label: 'Register',
                                    isLoading: isLoading,
                                    onPressed: _submit,
                                  ),
                                  const SizedBox(height: AppSizes.sm),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Already have an account?',
                                          style: AppTextStyles.caption),
                                      TextButton(
                                        onPressed: isLoading
                                            ? null
                                            : () => context.go(Routes.login),
                                        child: const Text('Login'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}