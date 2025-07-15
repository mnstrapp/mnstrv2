import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../shared/layout_scaffold.dart';
import '../providers/session_users.dart';
import '../ui/button.dart';
import '../qr/scanner.dart';
import 'forgot_password.dart';
import 'login.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _passwordVisible = false;
  Uint8List? _qrCode;

  void _scanQRCode(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ScannerView(
        onScan: (data) {
          if (data != null) {
            setState(() {
              _qrCode = data;
            });
          }
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void _register(BuildContext context) async {
    if (_displayNameController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Display name is required')));
      return;
    }

    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Email is required')));
      return;
    }

    if (_passwordController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Password is required')));
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Passwords do not match')));
      return;
    }

    if (_qrCode == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('QR Code is required')));
      return;
    }

    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    await ref
        .read(sessionUserProvider.notifier)
        .register(
          RegistrationRequest(
            qrCode: base64Encode(_qrCode!),
            displayName: _displayNameController.text,
            email: _emailController.text,
            password: _passwordController.text,
          ),
        );

    if (ref.read(sessionUserProvider).value != null) {
      navigator.pushReplacement(
        MaterialPageRoute(builder: (context) => LoginView()),
      );
      messenger.showSnackBar(
        SnackBar(content: Text('Registration successful')),
      );
    } else {
      messenger.showSnackBar(
        SnackBar(content: Text(ref.read(sessionUserProvider).error.toString())),
      );
    }
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutScaffold(
      showStatBar: false,
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
                        'Registration',
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
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                UIButton(
                                  onPressed: () => _scanQRCode(context),
                                  text: 'QR Code',
                                  margin: 16,
                                  padding: 16,
                                  icon: _qrCode != null
                                      ? Icons.check_circle
                                      : Icons.qr_code_scanner,
                                  backgroundColor: _qrCode != null
                                      ? Colors.green
                                      : Theme.of(context).colorScheme.secondary,
                                ),
                                if (_qrCode != null) ...[
                                  TextField(
                                    controller: _displayNameController,
                                    decoration: InputDecoration(
                                      labelText: 'Display Name',
                                    ),
                                    autofocus: true,
                                  ),
                                  TextField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                    ),
                                  ),
                                  TextField(
                                    controller: _passwordController,
                                    obscureText: !_passwordVisible,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _passwordVisible =
                                                !_passwordVisible;
                                          });
                                        },
                                        icon: Icon(
                                          _passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextField(
                                    controller: _confirmPasswordController,
                                    obscureText: !_passwordVisible,
                                    decoration: InputDecoration(
                                      labelText: 'Confirm Password',
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _passwordVisible =
                                                !_passwordVisible;
                                          });
                                        },
                                        icon: Icon(
                                          _passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                      ),
                                    ),
                                  ),
                                  UIButton(
                                    onPressedAsync: () async =>
                                        _register(context),
                                    text: 'Register',
                                    margin: 16,
                                    padding: 16,
                                    icon: Icons.person_add,
                                  ),
                                ],

                                Divider(),
                                TextButton.icon(
                                  onPressed: () =>
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => LoginView(),
                                        ),
                                      ),
                                  icon: const Icon(Icons.login),
                                  label: Text('Login?'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.onPrimary,
                          foregroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          elevation: 4,
                        ),
                        onPressed: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => ForgotPasswordView(),
                          ),
                        ),
                        icon: const Icon(Icons.password),
                        label: Text('Forgot password?'),
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
