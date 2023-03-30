// chat_page.dart
import 'chat_api.dart';
import 'chat_message.dart';
import 'message_bubble.dart';
import 'message_composer.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    required this.chatApi,
    super.key,
  });

  final ChatApi chatApi;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _messages = <ChatMessage>[];
  var _awaitingResponse = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("DEP'S TOROS (Beta abierta)")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MessageComposer(
              onSubmitted: _onSubmitted,
              awaitingResponse: _awaitingResponse,
            ),
            Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.7,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    final msg = _messages[index];
                    return MessageBubble(
                      content: msg.content,
                      isUserMessage: msg.isUserMessage,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onSubmitted(String message) async {
    setState(() {
      _messages.clear();
      _messages.add(ChatMessage(message, true));
      _awaitingResponse = true;
    });
    final response = await widget.chatApi.completeChat(_messages);
    setState(() {
      _messages.add(ChatMessage(response, false));
      _awaitingResponse = false;
    });
  }
}
