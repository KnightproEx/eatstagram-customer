import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class Intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Welcome to Eatstagram",
          body: "Dine in redefined. Order your meals in under 2 minutes",
          image: Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Image.asset('assets/splashart/dinein.jpg'),
          ),
        ),
        PageViewModel(
          title: "Scan Restaurant QR",
          body:
              "Scan the QR codes displayed at a restaurant to view their available menu",
          image: Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Image.asset('assets/splashart/scanqr.jpg'),
          ),
        ),
        PageViewModel(
          title: "Choose your cravings",
          body:
              "The entire menu at your fingertips , spoil yourself for choice",
          image: Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Image.asset('assets/splashart/foodchoices.jpg'),
          ),
        ),
        PageViewModel(
          title: "Track Order",
          body: "Your order is being prepared. \nHold tight !",
          image: Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Image.asset('assets/splashart/trackorder.jpg'),
          ),
        ),
        PageViewModel(
          title: "All Set",
          body: "You're ready to make your first order. \nTap Done to proceed.",
          image: Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Image.asset('assets/splashart/finished.jpg'),
          ),
        ),
      ],
      onDone: () => Navigator.of(context).pushReplacementNamed('/Scanner'),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xffbdbdbd),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(25.0),
          ),
        ),
      ),
    );
  }
}

// Splash art credits of Freepik.com
