import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pm_gallery/src/pages/gallery_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gallery',
      home: GalleryPage()
    );
  }
}