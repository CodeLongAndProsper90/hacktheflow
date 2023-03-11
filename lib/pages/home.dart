import 'package:flutter/material.dart';

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
					],
				),
			),
		);
	}
}
