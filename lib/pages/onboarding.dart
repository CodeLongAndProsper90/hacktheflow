import 'package:flutter/material.dart';
import 'package:hacktheflow/colors.dart';
import 'package:hacktheflow/widgets/onboarding_login_card.dart';
import 'package:hacktheflow/widgets/onboarding_signup_card.dart';
import 'package:hacktheflow/widgets/styled_text.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:swipe/swipe.dart';

final supabase = Supabase.instance.client;

class OnboardingPage extends StatefulWidget {
  static Route<void> route() {
    return MaterialPageRoute(
      builder: (context) => const OnboardingPage(),
    );
  }

  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final signupKey = GlobalKey();
  final loginKey = GlobalKey();
  bool modalOpen = false;
  bool modalSide = false; // false <- side -> true
  final modalPopupDuration = const Duration(milliseconds: 200);
  final modalScrollDuration = const Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (modalOpen) {
            setState(() {
              modalOpen = false;
            });
          } else {
            Navigator.of(context).pop(true);
          }
          return false;
        },
        child: LayoutBuilder(builder: (context, constraints) {
          var screenHeight = constraints.maxHeight;
          var screenWidth = constraints.maxWidth;

          return Stack(
            children: [
              Column(
                children: [
                  // Upper portion
                  Stack(
                    children: [
                      Image.asset(
                        'assets/images/bg_towers.jpg',
                        height: screenHeight * 0.55,
                        width: screenWidth,
                        fit: BoxFit.cover,
                        alignment: Alignment.bottomCenter,
                      ),
                      SafeArea(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(top: 16.0),
                              child: LogoText('Wyzno', color: colorBackground),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Lower portion
                  SizedBox(
                    // TODO: replace hardcoded value?
                    height: screenHeight * 0.45,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 64.0, right: 64.0, top: 32.0),
                          child: Column(
                            children: const [
                              HeaderText(
                                rich: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: 'Neighborhood commerce made '),
                                    TextSpan(
                                      text: 'effortless',
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 16.0),
                              SubheaderText(
                                'Wyzno connects your goods to your community. Lorem ipsum dolor sit amet.',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: SizedBox(
                            height: 80.0,
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  modalOpen = true;
                                });
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  const StadiumBorder(),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                  colorForeground,
                                ),
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                    horizontal: 48.0,
                                  ),
                                ),
                              ),
                              child: const BodyText(
                                'Let\'s get started!',
                                style: TextStyle(color: colorBackground),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),

              // Modal
              // TODO: this causes the background to immediately disappear rather than fade outs
              // without it, you wouldn't be able to click on anything when the dialog is closed
              if (modalOpen)
                TweenAnimationBuilder(
                  tween: Tween<double>(
                    begin: 0.0,
                    end: modalOpen ? 1.0 : 0.0,
                  ),
                  duration: modalPopupDuration,
                  curve: Curves.easeInOut,
                  builder: (context, double opacity, child) {
                    return Opacity(
                      opacity: opacity,
                      child: child,
                    );
                  },
                  child: Container(color: Colors.black.withOpacity(0.35)),
                ),
              TweenAnimationBuilder(
                tween: Tween<double>(
                  begin: 0,
                  end: modalOpen ? 1.0 : 0.0,
                ),
                duration: modalPopupDuration,
                curve: Curves.bounceInOut,
                builder: (context, double scale, child) {
                  return Transform.scale(
                    scale: scale,
                    child: child,
                  );
                },
                child: Center(
                  child: Swipe(
                    onSwipeLeft: () {
                      Scrollable.ensureVisible(
                        loginKey.currentContext!,
                        duration: modalScrollDuration,
                      );
                    },
                    onSwipeRight: () {
                      Scrollable.ensureVisible(
                        signupKey.currentContext!,
                        duration: modalScrollDuration,
                      );
                    },
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      child: Row(
                        children: [
                          OnboardingSignupCard(
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                            key: signupKey,
                          ),
                          OnboardingLoginCard(
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                            key: loginKey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
      floatingActionButton: TweenAnimationBuilder(
        tween: Tween<double>(
          begin: 0,
          end: modalOpen ? 1.0 : 0.0,
        ),
        duration: modalPopupDuration,
        curve: Curves.bounceInOut,
        builder: (context, double scale, child) {
          return Transform.scale(
            scale: scale,
            child: child,
          );
        },
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              modalOpen = false;
              FocusManager.instance.primaryFocus?.unfocus();
            });
          },
          backgroundColor: colorAccent,
          child: const Icon(
            Icons.close,
            color: colorForeground,
          ),
        ),
      ),
    );
  }
}
