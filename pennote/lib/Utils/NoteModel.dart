class Note {
  String id = DateTime.now().toString();
  String title;
  String noteTxt;
  DateTime creationDate = DateTime.now();
  DateTime lastEdited = DateTime.now();

  Note({this.title, this.noteTxt,});

  Note.fromStorage({Map<String, dynamic> data}) {
    id = data["id"];
    title = data["title"];
    noteTxt = data["noteTxt"];
    creationDate = DateTime.parse(data["creationDate"]);
    lastEdited = DateTime.parse(data["lastEdited"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id" : id,
      "title" : title,
      "noteTxt" : noteTxt,
      "creationDate" : creationDate.toString(),
      "lastEdited" : lastEdited.toString(),
    };
  }
}