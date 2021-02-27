
// import 'dart:io';
import 'dart:convert';

List<ImageModel> imageModelFromJson(String str) => List<ImageModel>.from(json.decode(str).map((x) => ImageModel.fromJson(x)));
String imageModelToJson(List<ImageModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ImageModel {

  final String pathImage;
  final String dateImage;
  // final File thumbImg;

  ImageModel({
    this.pathImage,
    this.dateImage,
    // this.thumbImg
  });


  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
    pathImage: json['pathImage'],
    dateImage: json["dateImage"],
    // thumbImg: json["thumbImg"],
  );

  Map<String, dynamic> toJson() => {
    "pathImage": pathImage,
    "dateImage": dateImage,
    // "thumbImg": thumbImg,
  };


}