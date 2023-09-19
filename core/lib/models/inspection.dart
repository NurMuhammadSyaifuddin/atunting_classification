class Inspection{
  String question;
  String category;
  List<String> answer;

  Inspection({required this.question, required this.category, required this.answer});

  factory Inspection.fromJson(Map<String, dynamic> json) =>
      Inspection(question: json['question'], category: json['category'], answer: List<String>.from(json['answer'] as List));
}