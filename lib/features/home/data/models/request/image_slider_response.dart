// class BannerResponse {
//   late String? link;

//   BannerResponse({this.link});

//   factory BannerResponse.fromJson(Map<String, dynamic> json) {
//     String link = json['image'];

//     return BannerResponse(link: link);
//   }
// }
class AdBannerResponse {
  late int id;
  late String name;
  late String image;
  late String videoLink;
  // late int addedBy;
  // late int status;
  // late int page;
  // late int priority;
  // late String link;
  // late int views;
  // late String type;

  AdBannerResponse({
    required this.id,
    required this.name,
    required this.image,
    required this.videoLink,
    // required this.addedBy,
    // required this.status,
    // required this.page,
    // required this.priority,
    // required this.link,
    // required this.views,
    // required this.type,
  });

  factory AdBannerResponse.fromJson(Map<String, dynamic> json) {
    return AdBannerResponse(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      videoLink: json['video_link'],
      // addedBy: json['added_by'],
      // status: json['status'],
      // page: json['page'],
      // priority: json['priority'],
      // link: json['link'],
      // views: json['views'],
      // type: json['type'],
    );
  }
}

class BannerResponse {
  late int id;
  late String title;
  late String body;
  late String image;
  late String link;
  late int added_by;
  late int status;
  late int is_popup;
  late int priority;

  BannerResponse({
    required this.id,
    required this.title,
    required this.body,
    required this.image,
    required this.link,
    required this.added_by,
    required this.status,
    required this.is_popup,
    required this.priority,
  });

  factory BannerResponse.fromJson(Map<String, dynamic> json) {
    return BannerResponse(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      image: json['image'],
      link: json['link'],
      added_by: json['added_by'],
      status: json['status'],
      is_popup: json['is_popup'],
      priority: json['priority'],
    );
  }
}
