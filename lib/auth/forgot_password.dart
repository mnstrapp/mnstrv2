import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../shared/layout_scaffold.dart';
import '../providers/session_users.dart';
import '../qr/scanner.dart';
import '../ui/button.dart';
import 'login.dart';
import 'register.dart';

class ForgotPasswordView extends ConsumerStatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  ConsumerState<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends ConsumerState<ForgotPasswordView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _resetFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  Uint8List? _qrCode;
  bool _missingQrCode = false;
  bool _isLoading = false;
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _qrCode = null;
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
  }

  Future<void> _scanQRCode() async {
    try {
      await showDialog(
        context: context,
        builder: (context) => ScannerView(
          onScan: (data) {
            if (data != null) {
              setState(() {
                _qrCode = data;
                _emailFocusNode.requestFocus();
              });
            }
            Navigator.of(context).pop();
          },
        ),
      );
    } catch (e, stackTrace) {
      log('[scanQRCode] catch error: $e');
      log('[scanQRCode] catch stackTrace: $stackTrace');
      setState(() {
        _missingQrCode = true;
      });
    }
  }

  Future<void> _getUserId() async {
    final messenger = ScaffoldMessenger.of(context);
    if (!_formKey.currentState!.validate()) {
      messenger.showSnackBar(SnackBar(content: Text('Email is required')));
      return;
    }

    if (_qrCode == null) {
      setState(() {
        _missingQrCode = true;
      });
      messenger.showSnackBar(SnackBar(content: Text('QR Code is required')));
      return;
    }

    if (_emailController.text.isEmpty) {
      messenger.showSnackBar(SnackBar(content: Text('Email is required')));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final error = await ref
        .read(forgotPasswordProvider.notifier)
        .forgotPassword(
          email: _emailController.text,
          qrCode: base64Encode(_qrCode!),
        );

    setState(() {
      _isLoading = false;
    });

    if (error != null) {
      messenger.showSnackBar(SnackBar(content: Text(error)));
      return;
    }
  }

  Future<void> _sendReset() async {
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    if (!_resetFormKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final error = await ref
        .read(forgotPasswordProvider.notifier)
        .resetPassword(password: _passwordController.text);

    if (error != null) {
      setState(() {
        _isLoading = false;
      });
      messenger.showSnackBar(SnackBar(content: Text(error)));
      return;
    }

    navigator.pushReplacement(
      MaterialPageRoute(builder: (context) => LoginView()),
    );
    messenger.showSnackBar(SnackBar(content: Text('Reset successful')));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(forgotPasswordProvider);
    final size = MediaQuery.sizeOf(context);

    return LayoutScaffold(
      showStatBar: false,
      child: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 32,
                right: 0,
                child: Center(child: Image.asset('assets/loading_figure.png')),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Forgot Password',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Card(
                          elevation: 16,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: _qrCode == null || userId == null
                                ? _buildForgotPasswordForm(
                                    context: context,
                                    formKey: _formKey,
                                    emailController: _emailController,
                                    emailFocusNode: _emailFocusNode,
                                    qrCode: _qrCode,
                                    scanQRCode: _scanQRCode,
                                    getUserId: _getUserId,
                                    isLoading: _isLoading,
                                    missingQrCode: _missingQrCode,
                                  )
                                : _buildResetPasswordForm(
                                    context: context,
                                    formKey: _resetFormKey,
                                    passwordController: _passwordController,
                                    passwordFocusNode: _passwordFocusNode,
                                    confirmPasswordController:
                                        _confirmPasswordController,
                                    confirmPasswordFocusNode:
                                        _confirmPasswordFocusNode,
                                    sendReset: _sendReset,
                                    isLoading: _isLoading,
                                    togglePasswordVisible: () => setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    }),
                                    passwordVisible: _passwordVisible,
                                  ),
                          ),
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
    );
  }
}

Widget _buildForgotPasswordForm({
  required BuildContext context,
  required GlobalKey<FormState> formKey,
  required TextEditingController emailController,
  required FocusNode emailFocusNode,
  required Uint8List? qrCode,
  required Function() scanQRCode,
  required Function() getUserId,
  required bool isLoading,
  required bool missingQrCode,
}) {
  return isLoading
      ? const Center(child: CircularProgressIndicator())
      : Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              UIButton(
                onPressed: () => scanQRCode(),
                text: 'QR Code',
                margin: 16,
                padding: 16,
                icon: qrCode != null
                    ? Icons.check_circle
                    : Icons.qr_code_scanner,
                backgroundColor: qrCode != null
                    ? Colors.green
                    : missingQrCode
                    ? Colors.red
                    : Theme.of(context).colorScheme.secondary,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  return null;
                },
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                autofocus: true,
                focusNode: emailFocusNode,
                onEditingComplete: () => getUserId(),
              ),
              UIButton(
                onPressed: () => getUserId(),
                text: 'Check For User',
                margin: 16,
                padding: 16,
                icon: Icons.search_rounded,
              ),

              Divider(),
              TextButton.icon(
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginView()),
                ),
                icon: const Icon(Icons.login),
                label: Text('Login?'),
              ),
              TextButton.icon(
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => RegisterView()),
                ),
                icon: const Icon(Icons.person_add),
                label: Text('Register?'),
              ),
            ],
          ),
        );
}

Widget _buildResetPasswordForm({
  required BuildContext context,
  required GlobalKey<FormState> formKey,
  required TextEditingController passwordController,
  required FocusNode passwordFocusNode,
  required TextEditingController confirmPasswordController,
  required FocusNode confirmPasswordFocusNode,
  required Function() sendReset,
  required bool isLoading,
  required Function() togglePasswordVisible,
  required bool passwordVisible,
}) {
  return isLoading
      ? const Center(child: CircularProgressIndicator())
      : Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    onPressed: togglePasswordVisible,
                    icon: Icon(
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),
                autofocus: true,
                obscureText: !passwordVisible,
                focusNode: passwordFocusNode,
                onEditingComplete: () =>
                    confirmPasswordFocusNode.requestFocus(),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirm password is required';
                  }
                  if (value != passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  suffixIcon: IconButton(
                    onPressed: togglePasswordVisible,
                    icon: Icon(
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),
                obscureText: !passwordVisible,
                focusNode: confirmPasswordFocusNode,
                onEditingComplete: () => sendReset(),
              ),
              UIButton(
                onPressed: () => sendReset(),
                text: 'Reset',
                margin: 16,
                padding: 16,
                icon: Icons.password_rounded,
              ),

              Divider(),
              TextButton.icon(
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginView()),
                ),
                icon: const Icon(Icons.login),
                label: Text('Login?'),
              ),
              TextButton.icon(
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => RegisterView()),
                ),
                icon: const Icon(Icons.person_add),
                label: Text('Register?'),
              ),
            ],
          ),
        );
}
