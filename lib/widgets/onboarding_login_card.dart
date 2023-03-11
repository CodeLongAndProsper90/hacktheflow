import 'package:flutter/material.dart';
import 'package:hacktheflow/colors.dart';
import 'package:hacktheflow/pages/home.dart';
import 'package:hacktheflow/widgets/styled_text.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class OnboardingLoginCard extends StatefulWidget {
  final double screenHeight;
  final double screenWidth;

  const OnboardingLoginCard({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  @override
  State<OnboardingLoginCard> createState() => _OnboardingLoginCardState();
}

class _OnboardingLoginCardState extends State<OnboardingLoginCard> {
  final formKey = GlobalKey<FormState>();
  final emailCon = TextEditingController();
  final passCon = TextEditingController();

  Future<void> login(context) async {
    await supabase.auth.signInWithPassword(
      email: emailCon.text,
      password: passCon.text,
    );
    Navigator.of(context).push(HomePage.route());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: widget.screenWidth * 0.1,
      ),
      child: SizedBox(
        width: widget.screenWidth * 0.8,
        child: Card(
          color: colorBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          margin: const EdgeInsets.all(32.0),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const HeaderText(text: 'Hi again!'),
                const SizedBox(height: 25.0),
                const SubheaderText(
                  'Glad to see you back. Let\'s get back to business.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      styledTextFormField(
                        'Email',
                        emailCon,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 15.0),
                      styledTextFormField(
                        'Password',
                        passCon,
                        obscureText: true,
                      ),
                      const SizedBox(height: 15.0),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              const StadiumBorder(),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                              colorForeground,
                            ),
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(vertical: 16),
                            ),
                          ),
                          onPressed: () async {
                            await login(context);
                          },
                          child: const Text(
                            "Log in",
                            style: TextStyle(color: colorBackground),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? validateNotNull(String? value) {
    if (value == null || value.isEmpty) return 'Please enter a value';
    return null;
  }

  TextFormField styledTextFormField(
      String labelText, TextEditingController controller,
      {TextInputType? keyboardType, bool? obscureText}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: colorHint,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      validator: validateNotNull,
    );
  }
}
