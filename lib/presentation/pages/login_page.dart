import 'package:fleegram/core/constants/app_assets.dart';
import 'package:fleegram/core/network/api_exception.dart';
import 'package:fleegram/l10n/app_localization.dart';
import 'package:fleegram/presentation/providers/auth_provider.dart';
import 'package:fleegram/presentation/utils/snackbar_helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  bool _hasShownRegisterSuccess = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() async {
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();

    final authProvider = context.read<AuthProvider>();

    await authProvider.login(
      _emailController.text.trim(),
      _passwordController.text,
    );

    if (authProvider.errorCode == null && mounted) {
      context.go('/');
    }
  }

  String _localizedError(BuildContext context, ApiErrorCode? code) {
    final l10n = AppLocalizations.of(context)!;

    switch (code) {
      case ApiErrorCode.userNotFound:
        return l10n.emailNotRegistered;
      case ApiErrorCode.invalidPassword:
        return l10n.wrongPassword;
      case ApiErrorCode.mustValidEmail:
        return l10n.wrongEmailFormat;
      case ApiErrorCode.errorNetwork:
        return l10n.errorNetwork;
      default:
        return l10n.errorGeneric;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_hasShownRegisterSuccess) return;

    final message = GoRouterState.of(context).extra as String?;
    if (message == null) return;

    _hasShownRegisterSuccess = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      SnackbarHelper.show(context, message, type: SnackbarType.success);
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final l10n = AppLocalizations.of(context)!;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final code = authProvider.errorCode;
      if (code == null) return;

      final message = _localizedError(context, code);

      SnackbarHelper.show(context, message, type: SnackbarType.error);

      authProvider.clearError();
    });

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Lottie.asset(
                  AppAssets.lottieBanner,
                  width: double.infinity,
                  repeat: true,
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 16),
                        Text(
                          l10n.loginTitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 32),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: l10n.emailLabel,
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return l10n.emptyEmailField;
                            }
                            if (!value.contains('@')) {
                              return l10n.wrongEmailFormat;
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            labelText: l10n.passwordLabel,
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Theme.of(context).iconTheme.color,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return l10n.emptyPasswordField;
                            }
                            if (value.length < 8) {
                              return l10n.passwordLength;
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 24),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(56),
                          ),
                          onPressed: authProvider.isLoading ? null : _onLogin,
                          child: authProvider.isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(l10n.loginButton),
                        ),

                        const SizedBox(height: 18),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(text: l10n.noAccount),
                              const WidgetSpan(child: SizedBox(width: 4)),
                              TextSpan(
                                text: l10n.goToRegister,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                  decoration: TextDecoration.none,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => context.push('/register'),
                              ),
                            ],
                          ),
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
    );
  }
}
