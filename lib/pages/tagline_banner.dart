import 'package:flutter/material.dart';

class TaglineBanner extends StatelessWidget {
  const TaglineBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: const MediaQueryData(),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF74CA8F),
              Color(0xFF009C51),
            ],
          ),
          borderRadius: BorderRadius.circular(0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Row(
          children: [
            // Animated app icon
            Flexible(
              flex: 1,
              child: TweenAnimationBuilder(
                tween: Tween<double>(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 800),
                builder: (_, double scale, __) {
                  return Transform.scale(
                    scale: 1.0 + 0.2 * (1.0 - scale),
                    child: Image.asset(
                      'images/app_icon.png',
                      height: MediaQuery.of(context).size.height * 0.12,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            Flexible(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Animated tagline text
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 800),
                    builder: (_, double opacity, __) {
                      return Opacity(
                        opacity: opacity,
                        child: const Text(
                          'Find the right task-doer for your project',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Connect with skilled task-doers in your area.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
