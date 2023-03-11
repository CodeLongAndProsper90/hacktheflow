import 'package:flutter/material.dart';
import 'package:hacktheflow/widgets/navbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hacktheflow/backend/user.dart';
import 'package:hacktheflow/main.dart';
import 'package:hacktheflow/widgets/message.dart';
import 'package:hacktheflow/backend/message.dart';

final supabase = Supabase.instance.client;

class HomePage extends StatefulWidget {
  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => const HomePage());
  }

  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final msgCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text("Main page"),
              TextField(
                decoration: InputDecoration(labelText: "message"),
                controller: msgCon,
              ),
              TextButton(
                child: Text("Send"),
                onPressed: () async {
                  await send(
                    to: "b7891604-2cff-48bb-ad00-bc9097af1086",
                    contents: msgCon.text,
                  );
                },
              ),
              TextButton(
                child: Text("Sign out"),
                onPressed: () async {
                  await supabase.auth.signOut();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => StartPage(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Navbar(),
    );
  }
}
