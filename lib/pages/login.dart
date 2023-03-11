
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hacktheflow/pages/home.dart';

final supabase = Supabase.instance.client;

class LoginPage extends StatefulWidget {
	static Route<void> route() {
		return MaterialPageRoute(
			builder: (context) => LoginPage()
		);
	}
	const LoginPage({Key? key });
	@override
	State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
	final formKey = GlobalKey<FormState>();
	String? validateNotNull(String? value) {
		if (value == null || value.isEmpty)
			return "Please enter a value";
		return null;
	}
	final emailCon = TextEditingController();
	final pwCon = TextEditingController();
	final unCon = TextEditingController();
	final zipCon = TextEditingController();

	Future<void> register() async {
		final isValid = formKey.currentState!.validate();
		if (!isValid)
			return;
		final email = emailCon.text;
		final passwd = pwCon.text;
		final username = unCon.text;
		final zip = zipCon.text;

		await supabase.auth.signUp(
			email: email,
			password: passwd,
			data: {
				"username" : username,
				"zipCode" : int.parse(zip),
			},
		);
		Navigator.of(context).pushAndRemoveUntil(HomePage.route(), (_) => false);
	}

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
										keyboardType: TextInputType.emailAddress,
										validator: validateNotNull
									),
									TextFormField(
										obscureText: true,
										decoration: const InputDecoration(
											labelText: "Password",
										),
										controller: pwCon,
										validator: validateNotNull,
									),
									TextFormField(
										decoration: const InputDecoration(
											labelText: "Username"
										),
										controller: unCon,
										validator: validateNotNull,
									),
									TextFormField(
										decoration: const InputDecoration(
											labelText: "Zip code",
										),
										controller: zipCon,
										keyboardType: TextInputType.number,
										validator: validateNotNull
									),
									TextButton(
										child: Text("Sign up"),
										onPressed: () async {
											await register();
										},
									),
								]
							),
						)
					],
				),
			),
		);
	}
}
