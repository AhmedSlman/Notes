class Note {
  final String text;
  final String title;

  Note({
    required this.text,
    required this.title,
  });

  // تحويل الكائن إلى Map لحفظه في التفضيلات
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'text': text,
    };
  }

  // من ال JSON إلى كائن Note
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      text: json['text'],
      title: json['title'],
    );
  }
}
