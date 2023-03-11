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
      body: Column(
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
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 32.0,
            ),
            child: Column(
              children: const [
                HeaderText(
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
                SizedBox(height: 32),
                SubheaderText(
                  'Wyzno connects your goods to your community. Lorem ipsum dolor sit amet.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextButton(
          onPressed: () {},
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
    );
  }
}
