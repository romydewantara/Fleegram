import 'package:fleegram/core/app_state.dart';
import 'package:fleegram/core/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onLottieLoaded(LottieComposition composition) {
    _controller
      ..duration = composition.duration
      ..forward();

    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        await Future.delayed(const Duration(milliseconds: 1500));
        if (!mounted) return;
        appState.finishSplash();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Lottie.asset(
              AppAssets.lottieSplash,
              controller: _controller,
              fit: BoxFit.cover,
              repeat: false,
              onLoaded: _onLottieLoaded,
            ),
          ),
          Center(
            child: Image.asset(
              /// `Moments, Made Easy` is a globally understandable phrase.
              /// This project aims to build a 'globally' accessible brand
              /// that avoids country specific or `local idioms`.
              /// For example: "Instagram – Create, share and connect.".
              AppAssets.icTagline,
              width: 240,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Image.asset(
              /// `Powered by` is kept in English because it is well known globally
              /// and keeps branding consistent across countries.
              AppAssets.icEndorseLine,
              height: 40,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
