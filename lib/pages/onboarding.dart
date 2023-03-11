import 'package:flutter/material.dart';
import 'package:hacktheflow/colors.dart';
import 'package:hacktheflow/pages/home.dart';
import 'package:hacktheflow/widgets/navbar.dart';
import 'package:hacktheflow/widgets/styled_text.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  final formKey = GlobalKey<FormState>();
  String? validateNotNull(String? value) {
    if (value == null || value.isEmpty) return 'Please enter a value';
    return null;
  }

  final emailCon = TextEditingController();
  final passCon = TextEditingController();
  final userCon = TextEditingController();
  final zipCon = TextEditingController();

  bool modalOpen = false;
  final modalPopupDuration = const Duration(milliseconds: 200);

  Future<void> register() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    final email = emailCon.text;
    final passwd = passCon.text;
    final username = userCon.text;
    final zip = zipCon.text;

    await supabase.auth.signUp(
      email: email,
      password: passwd,
      data: {
        'username': username,
        'zipCode': int.parse(zip),
      },
    );
    Navigator.of(context).pushAndRemoveUntil(HomePage.route(), (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              // Upper portion
              Stack(
                children: [
                  Image.asset(
                    'assets/images/bg_towers.jpg',
                    height: MediaQuery.of(context).size.height * 0.55,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                    alignment: Alignment.bottomCenter,
                  ),
                  SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(top: 16.0),
                          child: LogoText('Wyzno'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Lower portion
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 32.0),
                child: Column(
                  children: [
                    const HeaderText(
                      rich: TextSpan(
                        children: [
                          TextSpan(text: 'Neighborhood commerce made '),
                          TextSpan(
                            text: 'effortless',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    const SubheaderText(
                      'Wyzno connects your goods to your community. Lorem ipsum dolor sit amet.',
                      textAlign: TextAlign.center,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
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
                                  vertical: 24.0,
                                ),
                              ),
                            ),
                            child: const BodyText(
                              'Let\'s get started!',
                              style: TextStyle(color: colorBackground),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),

          // Modal
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
            curve: modalOpen ? Curves.elasticOut : Curves.elasticIn,
            builder: (context, double scale, child) {
              return Transform.scale(
                scale: scale,
                child: child,
              );
            },
            child: Center(
              child: Card(
                color: colorBackground,
                child: Wrap(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              modalOpen = false;
                            });
                          },
                          icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        ),
                        const HeaderText(text: 'Welcome!'),
                      ],
                    ),
                    const SubheaderText(
                        'Use your email to create a new account'),
                    const SizedBox(height: 16),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: "Email"),
                            controller: emailCon,
                            keyboardType: TextInputType.emailAddress,
                            validator: validateNotNull,
                          ),
                          TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: "Password",
                            ),
                            controller: passCon,
                            validator: validateNotNull,
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: "Username"),
                            controller: userCon,
                            validator: validateNotNull,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: "Zip code",
                            ),
                            controller: zipCon,
                            keyboardType: TextInputType.number,
                            validator: validateNotNull,
                          ),
                          TextButton(
                            child: const Text("Sign up"),
                            onPressed: () async {
                              await register();
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
