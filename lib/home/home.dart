import 'package:flutter/material.dart';
import '../collect/collect.dart';
import '../ui/button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final buttonWidth = 200.0;
    final buttonHeight = 70.0;
    final buttonPadding = 8.0;
    final buttonFontSize = 24.0;
    final buttonColor = Theme.of(context).colorScheme.onPrimary;
    return Scaffold(
      body: Stack(
        children: [
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
                  color: buttonColor,
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
                  color: buttonColor,
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
                  color: buttonColor,
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 32,
            right: 0,
            child: Center(child: Image.asset('assets/loading_figure.png')),
          ),
        ],
      ),
    );
  }
}
