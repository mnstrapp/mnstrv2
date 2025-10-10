import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wiredash/wiredash.dart';

import '../shared/layout_scaffold.dart';
import '../providers/session_users.dart';
import '../ui/button.dart';
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
  final TextEditingController _codeController = TextEditingController();
  bool _passwordVisible = false;
  final FocusNode _displayNameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  final FocusNode _codeFocusNode = FocusNode();
  bool _isVerifying = false;
  final GlobalKey<LayoutScaffoldState> layoutKey =
      GlobalKey<LayoutScaffoldState>();

  void _register(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final error = await ref
        .read(sessionUserProvider.notifier)
        .register(
          displayName: _displayNameController.text,
          email: _emailController.text,
          password: _passwordController.text,
        );
    if (error != null) {
      Wiredash.trackEvent(
        'Register User Error',
        data: {
          'error': error,
          'displayName': _displayNameController.text,
          'email': _emailController.text,
        },
      );
      layoutKey.currentState?.addError(error);
      return;
    }

    Wiredash.trackEvent(
      'Register User Success',
      data: {
        'displayName': _displayNameController.text,
        'email': _emailController.text,
      },
    );

    setState(() {
      _isVerifying = true;
    });
  }

  Future<void> _verifyEmail() async {
    final navigator = Navigator.of(context);

    final user = ref.read(sessionUserProvider);
    if (user == null) {
      return;
    }

    final error = await ref
        .read(sessionUserProvider.notifier)
        .verifyEmail(id: user.id!, code: _codeController.text);

    if (error != null) {
      Wiredash.trackEvent(
        'Register User Error',
        data: {
          'error': error,
          'code': _codeController.text,
          'email': user.email,
          'displayName': user.displayName,
          'id': user.id,
        },
      );
      layoutKey.currentState?.addError(error);
      return;
    }

    Wiredash.trackEvent(
      'Register User Success',
      data: {
        'displayName': _displayNameController.text,
        'email': _emailController.text,
      },
    );

    navigator.pushReplacement(
      MaterialPageRoute(builder: (context) => LoginView()),
    );
    layoutKey.currentState?.addSuccess('User registered and verified');
  }

  @override
  void initState() {
    super.initState();
    _displayNameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    _codeController.clear();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Wiredash.trackEvent(
        'Register View',
        data: {},
      );
    });
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return LayoutScaffold(
      key: layoutKey,
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
                                  if (_isVerifying) ...[
                                    Text(
                                      'Verification Code sent to email. Please enter it to verify your email.',
                                    ),
                                    TextFormField(
                                      controller: _codeController,
                                      decoration: InputDecoration(
                                        labelText: 'Verification Code',
                                      ),
                                      focusNode: _codeFocusNode,
                                    ),
                                    UIButton(
                                      onPressedAsync: () => _verifyEmail(),
                                      text: 'Verify Email',
                                      margin: 16,
                                      padding: 16,
                                      icon: Icons.check_circle,
                                    ),
                                  ],
                                  if (!_isVerifying) ...[
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            fontFamily: 'Roboto',
                                          ),
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            fontFamily: 'Roboto',
                                          ),
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            fontFamily: 'Roboto',
                                          ),
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
                                      onEditingComplete: () =>
                                          _register(context),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            fontFamily: 'Roboto',
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
