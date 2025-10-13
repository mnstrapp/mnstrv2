import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../shared/analytics.dart';
import '../shared/layout_scaffold.dart';
import '../providers/session_users.dart';
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
  final GlobalKey<FormState> _codeFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  final FocusNode _codeFocusNode = FocusNode();
  bool _isLoading = false;
  bool _passwordVisible = false;
  bool _codeVisible = false;
  bool _resetVisible = false;
  final GlobalKey<LayoutScaffoldState> layoutKey =
      GlobalKey<LayoutScaffoldState>();

  @override
  void initState() {
    super.initState();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    _codeController.clear();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Wiredash.trackEvent(
        'Forgot Password',
        data: {},
      );
    });
  }

  Future<void> _getUserId() async {
    if (!_formKey.currentState!.validate()) {
      layoutKey.currentState?.addError('Email is required');
      return;
    }

    if (_emailController.text.isEmpty) {
      layoutKey.currentState?.addError('Email is required');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final error = await ref
        .read(forgotPasswordProvider.notifier)
        .forgotPassword(email: _emailController.text);

    if (error != null) {
      Wiredash.trackEvent(
        'Forgot Password User Not Found',
        data: {
          'email': _emailController.text,
          'error': error,
        },
      );
      layoutKey.currentState?.addError(error);
      return;
    }

    Wiredash.trackEvent(
      'Forgot Password User Found',
      data: {
        'email': _emailController.text,
      },
    );

    setState(() {
      _isLoading = false;
      _codeVisible = true;
      _codeFocusNode.requestFocus();
    });
  }

  Future<void> _verifyCode() async {
    if (!_codeFormKey.currentState!.validate()) {
      layoutKey.currentState?.addError('Code is required');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final error = await ref
        .read(forgotPasswordProvider.notifier)
        .verifyCode(code: _codeController.text);

    if (error != null) {
      Wiredash.trackEvent(
        'Forgot Password Code Verify Error',
        data: {
          'code': _codeController.text,
          'error': error,
        },
      );
      layoutKey.currentState?.addError(error);
      return;
    }

    Wiredash.trackEvent(
      'Forgot Password Code Verified',
      data: {
        'code': _codeController.text,
      },
    );

    setState(() {
      _isLoading = false;
      _codeVisible = false;
      _resetVisible = true;
      _passwordFocusNode.requestFocus();
    });

    layoutKey.currentState?.addSuccess('Code verified');
  }

  Future<void> _sendReset() async {
    final navigator = Navigator.of(context);
    if (!_resetFormKey.currentState!.validate()) {
      layoutKey.currentState?.addError('Code is required');
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
      Wiredash.trackEvent(
        'Forgot Password Reset Error',
        data: {
          'email': _emailController.text,
          'error': error,
        },
      );
      layoutKey.currentState?.addError(error);
      return;
    }

    Wiredash.trackEvent(
      'Forgot Password Reset',
      data: {
        'email': _emailController.text,
      },
    );

    navigator.pushReplacement(
      MaterialPageRoute(builder: (context) => LoginView()),
    );
    layoutKey.currentState?.addSuccess('Reset successful');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                            child: !_codeVisible && !_resetVisible
                                ? _buildForgotPasswordForm(
                                    context: context,
                                    formKey: _formKey,
                                    emailController: _emailController,
                                    emailFocusNode: _emailFocusNode,
                                    getUserId: _getUserId,
                                    isLoading: _isLoading,
                                  )
                                : _codeVisible
                                ? _buildVerifyCodeForm(
                                    context: context,
                                    formKey: _codeFormKey,
                                    codeController: _codeController,
                                    codeFocusNode: _codeFocusNode,
                                    verifyCode: _verifyCode,
                                    isLoading: _isLoading,
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
  required Function() getUserId,
  required bool isLoading,
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

Widget _buildVerifyCodeForm({
  required BuildContext context,
  required GlobalKey<FormState> formKey,
  required TextEditingController codeController,
  required FocusNode codeFocusNode,
  required Function() verifyCode,
  required bool isLoading,
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
                    return 'Code is required';
                  }
                  return null;
                },
                controller: codeController,
                decoration: InputDecoration(labelText: 'Code'),
                autofocus: true,
                focusNode: codeFocusNode,
                onEditingComplete: () => verifyCode(),
              ),
              UIButton(
                onPressed: () => verifyCode(),
                text: 'Verify Code',
                margin: 16,
                padding: 16,
                icon: Icons.check_circle,
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
