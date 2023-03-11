import 'package:flutter/material.dart';
import 'package:hacktheflow/colors.dart';
import 'package:hacktheflow/pages/onboarding.dart';
import 'package:hacktheflow/pages/signup.dart';
import 'package:hacktheflow/pages/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
      url: "https://knnndpivzxgzvtarcqfz.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imtubm5kcGl2enhnenZ0YXJjcWZ6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2Nzg0OTM3ODcsImV4cCI6MTk5NDA2OTc4N30.l-CDukSGhpi68jIQ41UKEem753e29yOml-KATbIfaRI");
  runApp(const StartPage());
}

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wynzo',
      theme: ThemeData(
        fontFamily: 'Sansation',
        textTheme: const TextTheme(
          displayMedium: TextStyle(
              fontSize: 64.0,
              fontFamily: 'Phenomena',
              fontWeight: FontWeight.bold),
          displaySmall: TextStyle(
              fontSize: 48.0,
              fontFamily: 'Phenomena',
              fontWeight: FontWeight.bold),
          headlineLarge: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(fontSize: 16.0, color: colorForegroundAlt),
          bodyMedium: TextStyle(fontSize: 16.0),
          bodySmall: TextStyle(fontSize: 14.0),
        ),
      ),
      home: const StartWidget(title: 'Wynzo'),
    );
  }
}

class StartWidget extends StatefulWidget {
  const StartWidget({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<StartWidget> createState() => _StartWidgetState();
}

class _StartWidgetState extends State<StartWidget> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    await Future.delayed(Duration.zero);
    final session = supabase.auth.currentSession;

    if (session == null)
      Navigator.of(context)
          .pushAndRemoveUntil(OnboardingPage.route(), (_) => false);
    // .pushAndRemoveUntil(SignupPage.route(), (_) => false);
    else
      Navigator.of(context).pushAndRemoveUntil(HomePage.route(), (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CircularProgressIndicator());
  }
}
