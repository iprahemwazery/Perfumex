import 'dart:async';
import 'package:flutter/material.dart';
import 'package:perfumex/features/splash/view/widget/internet_check.dart';
import 'package:perfumex/root.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;

  late Animation<double> _fadeInLogo;
  late Animation<double> _scaleLogo;
  late Animation<double> _fadeText1;
  late Animation<double> _fadeText2;
  late Animation<Offset> _slideText2;

  bool hasInternet = true;
  bool isChecking = true;
  bool isRetrying = false;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _checkInternetOnStart();
  }

  void _initAnimations() {
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _fadeInLogo = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeIn),
      ),
    );
    _scaleLogo = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _fadeText1 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _textController,
        curve: const Interval(0.2, 0.6, curve: Curves.easeIn),
      ),
    );
    _fadeText2 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _textController,
        curve: const Interval(0.6, 1.0, curve: Curves.easeIn),
      ),
    );
    _slideText2 = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOut));
  }

  Future<void> _checkInternetOnStart() async {
    setState(() => isChecking = true);
    bool connected = await InternetCheck.hasConnection();
    setState(() {
      hasInternet = connected;
      isChecking = false;
    });

    if (connected) {
      _playAnimations();
      _navigateToRoot();
    }
  }

  void _playAnimations() {
    _logoController.forward();
    Future.delayed(const Duration(milliseconds: 1000), () {
      _textController.forward();
    });
  }

  void _navigateToRoot() {
    Timer(const Duration(seconds: 4, milliseconds: 500), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Root()),
        );
      }
    });
  }

  Future<void> _retryConnection() async {
    setState(() => isRetrying = true);
    bool connected = await InternetCheck.hasConnection();
    if (connected && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Root()),
      );
    } else {
      setState(() => isRetrying = false);
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gradient = const LinearGradient(
      colors: [Color(0xFF0D0D0D), Color(0xFF1B120E)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    if (isChecking) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    if (!hasInternet) {
      return Scaffold(
        backgroundColor: const Color(0xFF0D0D0D),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi_off, size: 90, color: Colors.white54),
              const SizedBox(height: 20),
              const Text(
                "لا يوجد اتصال بالإنترنت",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              isRetrying
                  ? const CircularProgressIndicator(color: Colors.brown)
                  : InkWell(
                    onTap: _retryConnection,
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.brown.shade700,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.brown.withOpacity(0.4),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.refresh, color: Colors.white),
                    ),
                  ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: gradient),
        child: Center(
          child: AnimatedBuilder(
            animation: Listenable.merge([_logoController, _textController]),
            builder:
                (context, child) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeTransition(
                      opacity: _fadeInLogo,
                      child: ScaleTransition(
                        scale: _scaleLogo,
                        child: _buildLogoCircle(),
                      ),
                    ),
                    const SizedBox(height: 40),
                    FadeTransition(
                      opacity: _fadeText1,
                      child: const Text(
                        "Perfumex",
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    FadeTransition(
                      opacity: _fadeText2,
                      child: SlideTransition(
                        position: _slideText2,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.0),
                          child: Text(
                            "Discover the art of fragrance — where every drop tells a story\nof luxury, confidence, and timeless elegance.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white70,
                              height: 1.6,
                              fontStyle: FontStyle.italic,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoCircle() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const RadialGradient(
          colors: [Color(0xFF3E2723), Color(0xFF1B120E)],
          center: Alignment.center,
          radius: 0.9,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            blurRadius: 25,
            spreadRadius: 2,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: ClipOval(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/images/pngtree-black-perfume-bottle-on-rocks-picture-image_15913229.png',
              height: 230,
              width: 230,
              fit: BoxFit.cover,
            ),
            Container(
              height: 230,
              width: 230,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.transparent,
                    Colors.black.withOpacity(0.3),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
