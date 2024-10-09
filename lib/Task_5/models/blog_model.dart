class BlogModel {
  final int id;
  final String title;
  final String blogContent;
  final String date;
  final String userInfo;

  BlogModel({
    required this.id,
    required this.title,
    required this.blogContent,
    required this.date,
    required this.userInfo,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      blogContent: json['blog_content'] ?? '',
      date: json['date'] ?? '',
      userInfo: json['user_info'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'blog_content': blogContent,
      'date': date,
      'user_info': userInfo,
    };
  }
}
