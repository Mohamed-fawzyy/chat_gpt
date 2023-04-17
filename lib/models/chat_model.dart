class ChatModel {
  final String msg;
  final int chatIndex;
  ChatModel({
    required this.msg,
    required this.chatIndex,
  });

//here im making a post method so i put my key & val as i named it in const
  factory ChatModel.fromJson(Map<String, dynamic> map) {
    return ChatModel(
      msg: map["msg"],
      chatIndex: map["chatIndex"]?.toInt(),
    );
  }

  // static List<ChatModel> modelsFromSnapShot(List chatSnapShot) {
  //   return chatSnapShot.map((choices) => ChatModel.fromJson(choices)).toList();
  // }
  //we can do this but instead ill do smth simliar to be more precise in making
  //the val of chatIndex is 1
}
