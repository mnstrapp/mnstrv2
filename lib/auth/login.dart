import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wiredash/wiredash.dart';
import '../shared/layout_scaffold.dart';
import '../providers/auth.dart';
import '../ui/button.dart';
import '../home/home.dart';
import 'forgot_password.dart';
import 'register.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  Future<void> _login(BuildContext context) async {
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

    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    final error = await ref
        .read(authProvider.notifier)
        .login(_emailController.text, _passwordController.text);

    if (error != null) {
      Wiredash.trackEvent(
        'Login User Error',
        data: {
          'error': error,
          'email': _emailController.text,
        },
      );
      messenger.showSnackBar(SnackBar(content: Text(error)));
      return;
    }

    Wiredash.trackEvent(
      'Login User Success',
      data: {
        'email': _emailController.text,
      },
    );

    navigator.pushReplacement(
      MaterialPageRoute(builder: (context) => HomeView()),
    );
    messenger.showSnackBar(SnackBar(content: Text('Login successful')));
  }

  @override
  void initState() {
    super.initState();
    _emailController.clear();
    _passwordController.clear();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Wiredash.trackEvent(
        'Login View',
        data: {},
      );
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutScaffold(
      showStatBar: false,
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
                    'User Login',
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
                            TextField(
                              controller: _emailController,
                              decoration: InputDecoration(labelText: 'Email'),
                              autofocus: true,
                              focusNode: _emailFocusNode,
                              onEditingComplete: () =>
                                  _passwordFocusNode.requestFocus(),
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    fontFamily: 'Roboto',
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
                                      _passwordVisible = !_passwordVisible;
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
                              onEditingComplete: () => _login(context),
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    fontFamily: 'Roboto',
                                  ),
                            ),
                            UIButton(
                              onPressedAsync: () async => _login(context),
                              text: 'Login',
                              margin: 16,
                              padding: 16,
                              icon: Icons.login,
                            ),

                            Divider(),
                            TextButton.icon(
                              onPressed: () =>
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => RegisterView(),
                                    ),
                                  ),
                              icon: const Icon(Icons.person_add),
                              label: Text('Register'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      elevation: 4,
                    ),
                    onPressed: () => Navigator.push(
                      context,
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
    );
  }
}
