import 'dart:convert';
import 'dart:developer';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _passwordVisible = false;
  Uint8List? _qrCode;
  bool _missingQrCode = false;
  final FocusNode _displayNameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  void _scanQRCode(BuildContext context) {
    try {
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
    } catch (e, stackTrace) {
      log('[scanQRCode] catch error: $e');
      log('[scanQRCode] catch stackTrace: $stackTrace');
      setState(() {
        _missingQrCode = true;
      });
    }
  }

  void _register(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_qrCode == null) {
      setState(() {
        _missingQrCode = true;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('QR Code is required')));
      return;
    }

    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    final error = await ref
        .read(sessionUserProvider.notifier)
        .register(
          qrCode: base64Encode(_qrCode!),
          displayName: _displayNameController.text,
          email: _emailController.text,
          password: _passwordController.text,
        );
    if (error != null) {
      messenger.showSnackBar(SnackBar(content: Text(error)));
      return;
    }

    navigator.pushReplacement(
      MaterialPageRoute(builder: (context) => LoginView()),
    );
    messenger.showSnackBar(SnackBar(content: Text('Registration successful')));
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Registration',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
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
                                        : _missingQrCode
                                        ? Colors.red
                                        : Theme.of(
                                            context,
                                          ).colorScheme.secondary,
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Display name is required';
                                      }
                                      return null;
                                    },
                                    controller: _displayNameController,
                                    decoration: InputDecoration(
                                      labelText: 'Display Name',
                                    ),
                                    autofocus: true,
                                    onEditingComplete: () =>
                                        _emailFocusNode.requestFocus(),
                                    focusNode: _displayNameFocusNode,
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Email is required';
                                      }
                                      return null;
                                    },
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                    ),
                                    focusNode: _emailFocusNode,
                                    onEditingComplete: () =>
                                        _passwordFocusNode.requestFocus(),
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Password is required';
                                      }
                                      return null;
                                    },
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
                                    focusNode: _passwordFocusNode,
                                    onEditingComplete: () =>
                                        _confirmPasswordFocusNode
                                            .requestFocus(),
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Confirm password is required';
                                      }
                                      if (value != _passwordController.text) {
                                        return 'Passwords do not match';
                                      }
                                      return null;
                                    },
                                    obscureText: !_passwordVisible,
                                    controller: _confirmPasswordController,
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
                                    focusNode: _confirmPasswordFocusNode,
                                    onEditingComplete: () => _register(context),
                                  ),
                                  UIButton(
                                    onPressedAsync: () async =>
                                        _register(context),
                                    text: 'Register',
                                    margin: 16,
                                    padding: 16,
                                    icon: Icons.person_add,
                                  ),

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
                          onPressed: () =>
                              Navigator.of(context).pushReplacement(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
