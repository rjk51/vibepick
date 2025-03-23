import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:vibepick/presentation/screens/home_screen.dart';
import 'package:vibepick/theme/theme.dart';

class VibePickIntroScreen extends StatelessWidget {
  const VibePickIntroScreen({super.key});

  // Navigate to the main recommendation screen after the intro
  void _onIntroEnd(context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    // Define the page decoration for consistency
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppTheme.pureWhite,
      ),
      bodyTextStyle: TextStyle(
        fontSize: 16,
        color: AppTheme.lightGray,
      ),
      bodyPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      imagePadding: EdgeInsets.all(16.0),
    );

    return IntroductionScreen(
      globalBackgroundColor: AppTheme.deepBlack, // Use the deep black background
      pages: [
        // Page 1: Welcome to VibePick
        PageViewModel(
          title: "Welcome to VibePick",
          body: "Your personal entertainment assistant that picks the perfect movies, shows, or music based on your vibe.",
          image: const Center(
            child: Icon(
              Icons.movie_filter_rounded,
              size: 100,
              color: AppTheme.vibrantYellow,
            ),
          ),
          decoration: pageDecoration,
        ),
        // Page 2: Mood-Based Recommendations
        PageViewModel(
          title: "Mood-Based Recommendations",
          body: "Tell us how you're feeling, and we'll suggest entertainment that matches your mood—whether you're relaxed, excited, or tired.",
          image: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  color: AppTheme.calmingTeal, // Relaxed
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                ),
                Container(
                  width: 30,
                  height: 30,
                  color: AppTheme.playfulCoral, // Excited
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                ),
                Container(
                  width: 30,
                  height: 30,
                  color: AppTheme.softGray, // Tired
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                ),
              ],
            ),
          ),
          decoration: pageDecoration,
        ),
        // Page 3: Get Started
        PageViewModel(
          title: "Ready to Vibe?",
          body: "Let's find the perfect entertainment for you. Get started now!",
          image: const Center(
            child: Icon(
              Icons.play_circle_filled_rounded,
              size: 100,
              color: AppTheme.vibrantYellow,
            ),
          ),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      showSkipButton: true,
      skip: const Text(
        "Skip",
        style: TextStyle(color: AppTheme.lightGray),
      ),
      next: const Icon(
        Icons.arrow_forward,
        color: AppTheme.vibrantYellow,
      ),
      done: const Text(
        "Get Started",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppTheme.vibrantYellow,
        ),
      ),
      dotsDecorator: DotsDecorator(
        size: const Size(10.0, 10.0),
        color: AppTheme.lightGray,
        activeColor: AppTheme.vibrantYellow,
        activeSize: const Size(22.0, 10.0),
        activeShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
