class ModelsModel {
  final String id;
  final int created;
  final String root;

  ModelsModel({
    required this.id,
    required this.created,
    required this.root,
  });

  factory ModelsModel.fromJson(Map<String, dynamic> json) {
    //factory & log
    return ModelsModel(
      id: json["id"],
      created: json["created"]?.toInt(),
      root: json["root"],
    );
  }
  // factory used for adding the return operator and helps in filling the
  //the complex data var of the class by using the constructor

  static List<ModelsModel> modelsFromSnapShot(List modelSnapShot) {
    return modelSnapShot.map((data) => ModelsModel.fromJson(data)).toList();
  }
}
