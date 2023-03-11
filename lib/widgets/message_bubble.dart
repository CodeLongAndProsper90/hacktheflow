import 'package:flutter/material.dart';
import 'package:hacktheflow/colors.dart';
import 'package:hacktheflow/widgets/styled_text.dart';

class MessageBubble extends StatelessWidget {
  final String senderName; // Name of the user
  final String contents; // Contents of the message
  final DateTime sentAt; // Time the message was sent
  final bool clientSent; // Was the message sent by the user?

  MessageBubble({
    Key? key,
    required this.senderName,
    required this.contents,
    required this.sentAt,
    required this.clientSent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: clientSent ? TextDirection.rtl : TextDirection.ltr,
        children: [
          CircleAvatar(
            child: Text(
              senderName.split(' ').map((e) => e[0].toUpperCase()).join(''),
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: clientSent ? colorForeground : colorContainer,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: clientSent
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    Wrap(
                      direction: Axis.vertical,
                      crossAxisAlignment: clientSent
                          ? WrapCrossAlignment.end
                          : WrapCrossAlignment.start,
                      children: [
                        Text(
                          senderName,
                          style: TextStyle(
                            color:
                                clientSent ? colorBackground : colorForeground,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        BodyText(
                          contents,
                          style: TextStyle(
                            color:
                                clientSent ? colorBackground : colorForeground,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
