
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pm_gallery/src/models/image_model.dart';
import 'package:pm_gallery/src/utils/utils.dart';
import 'package:pm_gallery/src/widgets/dialog_view_image.dart';

class GridviewImage extends StatelessWidget {

  final List<ImageModel> myListModel;

  GridviewImage(this.myListModel);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 0.0,
        mainAxisSpacing: 0.0
      ),
      itemCount: this.myListModel.length,
      itemBuilder: (context, int index) => _itemGridImage(this.myListModel[index], index)
    );
  }

  Widget _itemGridImage(ImageModel myModel, int index) {
    return GestureDetector(
      onTap: () => _dialogViewImage(this.myListModel[index]),
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: Utils.percentW(Get.context, 50),
        height: Utils.percentH(Get.context, 15),
        margin: EdgeInsets.all(7.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Image.file(File('${myModel.pathImage}'), fit: BoxFit.cover)
        //Text(myModel.dateImage)
      ),
    );
  }

  void _dialogViewImage(ImageModel myModel) {
    Get.dialog(DialogViewImage(myModel));
  }

}