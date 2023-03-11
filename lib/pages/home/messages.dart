import 'package:flutter/material.dart';
import 'package:hacktheflow/colors.dart';
import 'package:hacktheflow/widgets/message_bubble.dart';
import 'package:hacktheflow/widgets/styled_text.dart';
import 'package:hacktheflow/backend/message.dart';

class HomeMessagesPage extends StatefulWidget {
  const HomeMessagesPage({super.key});

  @override
  State<HomeMessagesPage> createState() => _HomeMessagesPageState();
}

class _HomeMessagesPageState extends State<HomeMessagesPage> {
  final name = "John Doe";
  final status = "Online";

  List<Widget> messages = [
    MessageBubble(
      senderName: 'Jane Doe',
      contents: 'Lorem ipsum dolor sit amet',
      sentAt: DateTime.now(),
      clientSent: true,
    ),
    MessageBubble(
      senderName: 'Jane Doe',
      contents:
          'Lorem ipsum dolor sit amet\nawdoihawoidhawod\nawdoihawoidhawod\nawdoihawoidhawod\nawdoihawoidhawod',
      sentAt: DateTime.now(),
      clientSent: false,
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 20.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      // pop
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: colorForeground,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Row(
                    children: [
                      CircleAvatar(
                        child: Text(
                          name
                              .split(' ')
                              .map((e) => e[0].toUpperCase())
                              .join(''),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Wrap(
                        direction: Axis.vertical,
                        children: [
                          PageTitleText(name),
                          BodyText(status,
                              style: const TextStyle(color: colorHint)),
                        ],
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
        Expanded(
          child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return messages[index];
            },
          ),
        ),
      ],
    );
  }
}
