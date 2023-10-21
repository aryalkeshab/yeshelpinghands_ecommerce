class CRMModels {
  String? title;
  String? content;

  CRMModels({this.content, this.title});

  factory CRMModels.fromJson(Map<String, dynamic> json) {
    return CRMModels(content: json['content'], title: json['title']);
  }
}
