
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pm_gallery/src/models/image_model.dart';

class DialogViewImage extends StatelessWidget {

  final ImageModel myModel;

  const DialogViewImage(this.myModel);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.back(),
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(10.0)
        ),
        clipBehavior: Clip.antiAlias,
        contentPadding: EdgeInsets.zero,
        content: Container(
          child: Image.file(File('${myModel.pathImage}'), fit: BoxFit.cover)
        ),
      ),
    );
  }
}
