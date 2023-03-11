import 'package:flutter/material.dart';
import 'package:hacktheflow/pages/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
final supabase = Supabase.instance.client;

class LoginPage extends StatefulWidget {
	static Route<void> route() {
		return MaterialPageRoute(
			builder: (context) => LoginPage() 
		);
	}
	LoginPage ({Key? key});
	@override
	State<LoginPage > createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
	final emailCon = TextEditingController();
	final pwCon = TextEditingController();
	
	final formKey = GlobalKey<FormState>();

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Center(
				child: Column(
					children: [
						Form(
							key: formKey,
							child: Column(
								children: [
									TextFormField(
										decoration: const InputDecoration(
											labelText: "Email"
										),
										controller: emailCon,
										keyboardType: TextInputType.emailAddress
									),
									TextFormField(
										decoration: const InputDecoration(
											labelText: "Password",
										),
										controller: pwCon,
										obscureText: true
									),
									TextButton(
										child: Text("Log in"),
										onPressed: () async {
											await supabase.auth.signInWithPassword(
												email: emailCon.text,
												password: pwCon.text
											);
											Navigator.of(context).push(HomePage.route());
										}
									),
								]
							)	
						),
					],
				)
			),
		);
	}
}
