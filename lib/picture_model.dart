class PictureModel {
  String? url;
  String? title;
  String? date;
  String? explanation;

  PictureModel({
    this.url,
    this.title,
    this.date,
    this.explanation,
  });

  PictureModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    date = json['date'];
    title = json['title'];
    explanation = json['explanation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['date'] = date;
    data['title'] = title;
    data['explanation'] = explanation;
    return data;
  }
}
