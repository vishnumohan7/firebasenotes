class NotesModel{
  String? id;
  String title;
  String description;

  NotesModel({this.id,required this.title, required this.description});

  factory NotesModel.fromJson(Map<String, dynamic> json) {
    return NotesModel(
      id: json["id"],
      title: json["title"],
      description: json["description"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "title": this.title,
      "description": this.description,
    };
  }
//

}