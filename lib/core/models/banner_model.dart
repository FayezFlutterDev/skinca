class BannerModel {
  final int id;
  final String imageUrl;
  final String title;
  final String description;


  BannerModel({required this.title,required this.description, required this.id, required this.imageUrl});

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id']??'',
      imageUrl: json['image']??'',
       title: json['title']??'',
        description:json['description']??'',
    );
  }

}