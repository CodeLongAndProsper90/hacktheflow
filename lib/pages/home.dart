import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hacktheflow/backend/user.dart';
import 'package:hacktheflow/main.dart';
import 'package:hacktheflow/widgets/message.dart';

final supabase = Supabase.instance.client;

class HomePage extends StatefulWidget {
	static Route<void> route() {
		return MaterialPageRoute(
			builder: (context) => HomePage()
		);
	}
	HomePage({Key? key});
	@override
	State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Center(
				child: Column(
					children: [
						Text("Main page"),
						MessageBubble(
							contents: "Test",
							sender_name: "Bill Gates",
							sent_at: DateTime.now()
						),
						TextButton(
							child: Text(
								"Sign out"
							),
							onPressed: () async {
								await supabase.auth.signOut();
								Navigator.of(context).push(MaterialPageRoute(builder: (context) => StartPage()));
							}
						)
					],
				),
			),
		);
	}
}
