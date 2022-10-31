import 'package:flutter/material.dart';
import 'package:movie_lister_app/features/top_movie/view/top_movie_screen.dart';
import 'package:movie_lister_app/util/color_constants.dart';

class SplashScreen extends StatefulWidget {
  static const id = 'SplashScreen';

  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(
        seconds: 2,
      ),
      vsync: this,
      value: 0.1,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    );

    Future.delayed(const Duration(seconds: 2))
        .then((value) => Navigator.pushNamed(context, TopMovieScreen.id));
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorConstants.activeCardColor,
        child: ScaleTransition(
          scale: _animation,
          alignment: Alignment.center,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/splash_image.png",
                  height: 150,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
