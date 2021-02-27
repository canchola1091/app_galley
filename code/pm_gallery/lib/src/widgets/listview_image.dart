
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pm_gallery/src/models/image_model.dart';
import 'package:pm_gallery/src/widgets/dialog_view_image.dart';

class ListViewImage extends StatelessWidget {

  final List<ImageModel> myListModel;

  ListViewImage(this.myListModel);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      physics: BouncingScrollPhysics(),
      itemCount: this.myListModel.length,
      separatorBuilder: (context, int i) => Divider(color: Colors.blue), 
      itemBuilder: (context, int index) {
        return Wrap(
          children: [
            _itemListImage(this.myListModel[index], index), 
          ],
        );
      }
    );
  }

  Widget _itemListImage(ImageModel myModel, int index) {

    List<String> _splitPath = myModel.pathImage.split('/');
    String _nameImage = _splitPath.last;

    return ListTile(
      dense: true,
      leading: Container(
        width: 100.0,
        height: 100.0,
        child: Image.file(File('${myModel.pathImage}'), fit: BoxFit.cover)
      ),
      title: Text(_nameImage),
      trailing: Text('${myModel.dateImage}'),
      onTap: () => _dialogViewImage(this.myListModel[index])
    );
  }

  void _dialogViewImage(ImageModel myModel) {
    Get.dialog(DialogViewImage(myModel));
  }

}