import 'package:flutter/material.dart';
import '../../home/screen/home_screen.dart';
import '../../../config/content_ext.dart';

class Splash extends StatefulWidget {
  static const route = '/splash';
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
      context.navigateAndRemoveStack(HomeScreen.route);
    }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Splash Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
