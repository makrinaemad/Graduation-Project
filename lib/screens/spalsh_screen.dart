// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:gp2/src/features/authentication/screens/login_screen.dart';

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Simulate a delay to show the splash screen
//     Future.delayed(const Duration(seconds: 2), () {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => const LoginScreen()),
//       );
//     });

//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/images/background.jpg'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         alignment: Alignment.center,
//         child: Image.asset(
//           'assets/images/Untitled-1-01.png',
//           height: 200.0, // Adjust the height as needed
//           width: 200.0, // Adjust the width as needed
//         ),
//       ),
//     );
//   }
// }
// Feel free to use the code in your projects but do not forget to give me the credits adding my app (Flutter Animation Gallery) where you are gonna use it.

// ------------------------------------------

import 'package:flutter/material.dart';

import 'login_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _positionAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _positionAnimation = Tween<double>(
      begin: -1.0, // Move from the top
      end: 0.0, // Move to the center
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Start animation after the widget is built
    _animationController.forward();

    // Navigate to the next screen after animation completes
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            'assets/images/background.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Animated Image
          AnimatedBuilder(
            animation: _positionAnimation,
            builder: (context, child) {
              return Center(
                child: Transform.translate(
                  offset: Offset(
                    0.0,
                    MediaQuery.of(context).size.height *
                        _positionAnimation.value,
                  ),
                  child: child,
                ),
              );
            },
            child: Image.asset(
              'assets/images/Untitled-1-01.png',
              height: 200.0, // Adjust the height as needed
              width: 200.0, // Adjust the width as needed
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
