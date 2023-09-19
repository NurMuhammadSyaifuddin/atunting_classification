import 'package:equatable/equatable.dart';

class News extends Equatable{
  final String? title;
  final String? content;
  final String? author;
  final String? imageUrl;


  const News({
     this.title,
     this.content,
     this.author,
     this.imageUrl,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      author: json["author"],
      content: json["content"],
      imageUrl: json["imageUrl"],
      title: json["title"],
    );
  }

  toJson() {
    return {
      'title': title,
      'content': content,
      'author': author,
      'imageUrl': imageUrl,
    };
  }

  factory News.fromMap(Map<dynamic, dynamic> map){
    return News(title: map['title'], content: map['content'], author: map['author'], imageUrl: map['imageUrl']);
  }

  static List<News> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray.map((item) => News.fromJson(item)).toList();
  }

  @override
  List<Object?> get props => [title, content, author, imageUrl];
}
