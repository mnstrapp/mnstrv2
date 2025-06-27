import 'package:flutter/material.dart';
import '../collect/collect.dart';
import '../ui/button.dart';
import '../providers/auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../profile/profile.dart';
import '../auth/login.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buttonWidth = 220.0;
    final buttonHeight = 70.0;
    final buttonPadding = 8.0;
    final buttonFontSize = 24.0;
    final buttonColor = Theme.of(context).colorScheme.onPrimary;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 32,
            right: 0,
            child: Center(child: Image.asset('assets/loading_figure.png')),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: UIButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Collect()),
                    );
                  },
                  icon: Icons.add,
                  text: 'Collect',
                  margin: buttonPadding,
                  padding: buttonPadding,
                  fontSize: buttonFontSize,
                  width: buttonWidth,
                  height: buttonHeight,
                  foregroundColor: buttonColor,
                ),
              ),
              Center(
                child: UIButton(
                  onPressed: () {},
                  icon: Icons.settings,
                  text: 'Manage',
                  margin: buttonPadding,
                  padding: buttonPadding,
                  fontSize: buttonFontSize,
                  width: buttonWidth,
                  height: buttonHeight,
                  foregroundColor: buttonColor,
                ),
              ),
              Center(
                child: UIButton(
                  onPressed: () {},
                  icon: Icons.sports_esports,
                  text: 'Battle',
                  margin: buttonPadding,
                  padding: buttonPadding,
                  fontSize: buttonFontSize,
                  width: buttonWidth,
                  height: buttonHeight,
                  foregroundColor: buttonColor,
                ),
              ),
              Center(
                child: UIButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileView()),
                  ),
                  icon: Icons.person,
                  text: 'Profile',
                  margin: buttonPadding,
                  padding: buttonPadding,
                  fontSize: buttonFontSize,
                  width: buttonWidth,
                  height: buttonHeight,
                  foregroundColor: buttonColor,
                ),
              ),
              Center(
                child: UIButton(
                  onPressedAsync: () async {
                    final navigator = Navigator.of(context);
                    await ref.read(authProvider.notifier).logout();
                    navigator.pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginView()),
                    );
                  },
                  icon: Icons.logout,
                  text: 'Logout',
                  margin: buttonPadding,
                  padding: buttonPadding,
                  fontSize: buttonFontSize,
                  width: buttonWidth,
                  height: buttonHeight,
                  foregroundColor: buttonColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
