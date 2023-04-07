// ignore_for_file: avoid_print

import 'package:chat_gpt/constants/constants.dart';
import 'package:chat_gpt/services/api_service.dart';
import 'package:chat_gpt/services/assets_manager.dart';
import 'package:chat_gpt/widgets/chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../services/services.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final bool _isTyping = true;

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatGPT'),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.openaiLogo),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await Services.showModelSheet(context: context);
            },
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: chatMessages.length,
                itemBuilder: (context, index) {
                  return ChatWidget(
                    msg: chatMessages[index]['msg'].toString(),
                    chatIndex: int.parse(
                      chatMessages[index]['chatIndex'].toString(),
                    ),
                  );
                },
              ),
            ),
            // spread operator
            if (_isTyping) ...[
              const SpinKitThreeBounce(
                color: Colors.white,
                size: 18,
              ),
            ],
            const SizedBox(height: 15),
            Material(
              color: cardColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        controller: _textEditingController,
                        onSubmitted: (value) {},
                        decoration: const InputDecoration.collapsed(
                          hintText: 'Ask me anything',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        try {
                          await ApiService.getModels();
                        } catch (error) {
                          print('error--> $error');
                        }
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
