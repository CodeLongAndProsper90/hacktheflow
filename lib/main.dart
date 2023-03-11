import 'package:flutter/material.dart';
import 'package:hacktheflow/pages/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
final supabase = Supabase.instance.client;

void main() async {
	WidgetsFlutterBinding.ensureInitialized();
	
	await Supabase.initialize(
		url: "https://knnndpivzxgzvtarcqfz.supabase.co",
		anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imtubm5kcGl2enhnenZ0YXJjcWZ6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2Nzg0OTM3ODcsImV4cCI6MTk5NDA2OTc4N30.l-CDukSGhpi68jIQ41UKEem753e29yOml-KATbIfaRI"
	);
  runApp(const StartPage());
}


class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wynzo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyStartPage(title: 'Wynzo'),
    );
  }
}

class MyStartPage extends StatefulWidget {
  const MyStartPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyStartPage> createState() => _MyStartPageState();
}

class _MyStartPageState extends State<MyStartPage> {
	@override
	void initState() {
		super.initState();
		_redirect();
	}
	Future<void> _redirect() async {
		await Future.delayed(Duration.zero);
		final session = supabase.auth.currentSession;
		if (session == null)
			Navigator.of(context).pushAndRemoveUntil(LoginPage.route(), (_) => false);
		else
			// Navigator.of(context).pushAndRemoveUntil(MainPage.route(), (_) => false);
			print("TODO: Make main page");
	}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CircularProgressIndicator()
		);
  }
}
