import 'package:flutter/material.dart';

import '../models/chat_model.dart';
import '../services/api_service.dart';

class ChatProvider with ChangeNotifier {
  final List<ChatModel> _chatList = [];
  List<ChatModel> get getChatList {
    return _chatList;
  }

  int get getChatListLength {
    return _chatList.length;
  }

  void addUserMessage({required String msg}) {
    _chatList.add(ChatModel(msg: msg, chatIndex: 0));
    notifyListeners();
  }

  // to add in chat list in 1st index chatmodel which is the bot then
  // the 2nd index the response so that why we used the .addAll
  Future<void> sendMessageAndGetResponse(
      {required String msg, required String chosenModel}) async {
    _chatList.addAll(await ApiService.sendMessage(
      message: msg,
      modelId: chosenModel,
    ));
    notifyListeners();
  }
}
