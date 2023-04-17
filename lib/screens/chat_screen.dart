// ignore_for_file: avoid_print

import 'package:chat_gpt/constants/constants.dart';
import 'package:chat_gpt/provider/models_provider.dart';
import 'package:chat_gpt/services/assets_manager.dart';
import 'package:chat_gpt/widgets/chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../provider/chat_provider.dart';
import '../services/services.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isTyping = false;

  late final TextEditingController _textEditingController;
  late final ScrollController _listScrollController;
  late final FocusNode _focusNode;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    _listScrollController = ScrollController();
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _listScrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final modelProvider = Provider.of<ModelsProvider>(context, listen: false);
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
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
                controller: _listScrollController,
                itemCount: chatProvider.getChatList.length,
                itemBuilder: (context, index) {
                  return ChatWidget(
                    msg: chatProvider.getChatList[index].msg,
                    chatIndex: chatProvider.getChatList[index].chatIndex,
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
                        focusNode: _focusNode,
                        style: const TextStyle(color: Colors.white),
                        controller: _textEditingController,
                        onSubmitted: (_) async {
                          await _sendMessage(
                            modelProvider: modelProvider,
                            chatProvider: chatProvider,
                          );
                        },
                        decoration: const InputDecoration.collapsed(
                          hintText: 'Ask me anything',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await _sendMessage(
                          modelProvider: modelProvider,
                          chatProvider: chatProvider,
                        );
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

  void scrollListToEnd() {
    _listScrollController.animateTo(
      _listScrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.ease,
    );
  }

  Future<void> _sendMessage(
      {required ModelsProvider modelProvider,
      required ChatProvider chatProvider}) async {
    {
      try {
        setState(() {
          _isTyping = true;
          chatProvider.addUserMessage(msg: _textEditingController.text);
          _textEditingController.clear();
          _focusNode.unfocus();
        });
        await chatProvider.sendMessageAndGetResponse(
          msg: _textEditingController.text,
          chosenModel: modelProvider.currentModel,
        );
      } catch (error) {
        print('error--> $error');
      } finally {
        setState(() {
          scrollListToEnd();
          _isTyping = false;
        });
      }
    }
  }
}
