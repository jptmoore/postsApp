class Comment {
  final int id;
  final int postId;

  Comment({this.id, this.postId});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] as int,
      postId: json['postId'] as int,
    );
  }
}