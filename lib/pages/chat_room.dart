import 'package:flutter/material.dart';
import 'package:hacktheflow/colors.dart';
import 'package:hacktheflow/widgets/message_bubble.dart';
import 'package:hacktheflow/widgets/styled_text.dart';
import 'package:hacktheflow/backend/message.dart';
import 'package:hacktheflow/backend/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:async';

final supabase = Supabase.instance.client;

class ChatRoomPage extends StatefulWidget {
  final String to_id;

  const ChatRoomPage({super.key, required this.to_id});

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final chatCon = TextEditingController();
  late final Stream<List<Map<String, dynamic>>> msgStream;

  MessageBubble makeBubble(Message d, String name) {
    return MessageBubble(
      senderName: name,
      contents: d.content,
      sentAt: d.created_at,
      clientSent: d.mine,
    );
  }

  late final Timer timer;
  final status = "Online";

  @override
  void initState() {
    msgStream = supabase
        .from("messages")
        .stream(primaryKey: ["id"]).order("created_at");
    timer = Timer.periodic(Duration(seconds: 1), (_) => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  List<Map<String, dynamic>> messages_w = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait(
          [getUser(widget.to_id), getUser(supabase.auth.currentUser!.id)]),
      builder: (BuildContext context, AsyncSnapshot<List<AppUser>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
				if (snapshot.hasError)
					print("ERROR IN CHAT LIST");

        AppUser user = snapshot.data![0];
        print(user.name);
        AppUser me = snapshot.data![1];
        print(me.name);
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 128.0,
            titleSpacing: 16.0,
            elevation: 0.0,
            backgroundColor: colorBackground,
            leading: IconButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                color: colorForeground,
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      child: Text(
                        // TODO: name of other person
                        user.name.split(' ').map((e) {
                          if (e == '') return '';
                          return e[0].toUpperCase();
                        }).join(''),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Wrap(
                      direction: Axis.vertical,
                      children: [
                        PageTitleText(user.name),
                        BodyText(
                          status,
                          style: const TextStyle(color: colorHint),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.settings,
                    color: colorForeground,
                  ),
                ),
              ],
            ),
          ),
          body: FutureBuilder(
              future: getMessagesTo(user.id, supabase.auth.currentUser!.id),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Message>> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
								if (snapshot.hasError)
									print("ERROR GETTING MESSAGES!!!");

                return ListView(
                    children: snapshot.data!
                        .map((x) => makeBubble(x, x.mine ? me.name : user.name))
                        .toList());
              }),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              bottom: 20.0 + MediaQuery.of(context).viewInsets.bottom,
            ),
            child: TextField(
              controller: chatCon,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                fillColor: colorForeground,
                filled: true,
                focusColor: colorAccent,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                counterText: '${chatCon.text.length}/512 characters',
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: colorAccent),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                suffixIcon: InkWell(
                  onTap: () async {
                    String msg = chatCon.text;
                    await send(to: user.id, contents: msg);
                    setState(() {
                      chatCon.text = "";
                    });
                  },
                  child: Icon(
                    Icons.send_rounded,
                    color:
                        chatCon.text.isNotEmpty ? colorAccent : colorBackground,
                  ),
                ),
                // TODO: wrong name
                labelText: 'Message ${user.name}',
                labelStyle: const TextStyle(color: colorBackground),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: colorHint,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              style: const TextStyle(
                color: colorBackground,
              ),
            ),
          ),
        );
      },
    );
  }
}
