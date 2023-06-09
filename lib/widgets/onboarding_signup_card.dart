import 'package:flutter/material.dart';
import 'package:hacktheflow/colors.dart';
import 'package:hacktheflow/pages/home.dart';
import 'package:hacktheflow/widgets/styled_text.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class OnboardingSignupCard extends StatefulWidget {
  final double screenHeight;
  final double screenWidth;

  const OnboardingSignupCard({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  @override
  State<OnboardingSignupCard> createState() => _OnboardingSignupCardState();
}

class _OnboardingSignupCardState extends State<OnboardingSignupCard> {
  final formKey = GlobalKey<FormState>();
  final emailCon = TextEditingController();
  final passCon = TextEditingController();
  final zipCon = TextEditingController();
	final nameCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: widget.screenWidth * 0.1,
      ),
      child: SizedBox(
        width: widget.screenWidth * 0.8,
        child: SingleChildScrollView(
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
                  const HeaderText(text: 'Welcome!'),
                  const SizedBox(height: 25.0),
                  const SubheaderText(
                    'Use your email to create a new account',
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
                        styledTextFormField(
                          'Full Name',
                          nameCon,
                        ),
                        const SizedBox(height: 15.0),
                        styledTextFormField(
                          'Zip code',
                          zipCon,
                          keyboardType: TextInputType.number,
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
                              await register(context);
                            },
                            child: const Text(
                              "Sign up",
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
      ),
    );
  }

  Future<void> register(context) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    final email = emailCon.text;
    final passwd = passCon.text;
    final zip = zipCon.text;
		final name = nameCon.text;

    await supabase.auth.signUp(
      email: email,
      password: passwd,
      data: {
        'zipCode': int.parse(zip),
				'name': name
      },
    );
    Navigator.of(context).pushAndRemoveUntil(HomePage.route(), (_) => false);
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
