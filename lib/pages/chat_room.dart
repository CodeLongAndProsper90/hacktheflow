import 'package:flutter/material.dart';
import 'package:hacktheflow/colors.dart';
import 'package:hacktheflow/widgets/message_bubble.dart';
import 'package:hacktheflow/widgets/styled_text.dart';
import 'package:hacktheflow/backend/message.dart';
import 'package:hacktheflow/backend/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class ChatRoomPage extends StatefulWidget {
  final String to_id;

  const ChatRoomPage({super.key, required this.to_id});

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final chatCon = TextEditingController();

  final name = "John Doe";
  final status = "Online";

  List<Widget> messages = [
    MessageBubble(
      senderName: 'Jane Doe',
      contents: 'Lorem ipsum dolor sit amet',
      sentAt: DateTime.now(),
      clientSent: true,
    ),
  ];

  void addMessage(
    String senderName,
    String contents,
    DateTime sentAt,
    bool clientSent,
  ) {
    setState(() {
      messages.add(
        MessageBubble(
          senderName: 'Jane Doe',
          contents: 'Lorem ipsum dolor sit amet',
          sentAt: DateTime.now(),
          clientSent: true,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([getUser(widget.to_id), getMessagesTo(widget.to_id)]),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        print(snapshot.data);
        AppUser user = snapshot.data![0];
        List<Message> messages = snapshot.data![1];
        List<Widget> messageWidgets = messages
            .map(
              (data) => MessageBubble(
                senderName: user.name,
                contents: data.content,
                sentAt: data.created_at,
                clientSent: data.mine,
              ),
            )
            .toList();
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
                        name.split(' ').map((e) => e[0].toUpperCase()).join(''),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Wrap(
                      direction: Axis.vertical,
                      children: [
                        PageTitleText(name),
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
                    // pop
                  },
                  icon: const Icon(
                    Icons.settings,
                    color: colorForeground,
                  ),
                ),
              ],
            ),
          ),
          body: ListView.builder(
            itemCount: messageWidgets.length,
            itemBuilder: (context, index) {
              return messageWidgets[index];
            },
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              bottom: 20.0 + MediaQuery.of(context).viewInsets.bottom,
            ),
            child: TextField(
              controller: chatCon,
              onSubmitted: (value) {
                // TODO: submit
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
                suffixIcon: Icon(
                  Icons.send_rounded,
                  color:
                      chatCon.text.isNotEmpty ? colorAccent : colorBackground,
                ),
                // TODO: wrong name
                labelText: 'Message $name',
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
