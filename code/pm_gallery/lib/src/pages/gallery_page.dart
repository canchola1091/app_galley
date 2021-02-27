
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pm_gallery/src/controllers/gallery_controller.dart';
import 'package:pm_gallery/src/utils/utils.widgets.dart';
import 'package:pm_gallery/src/widgets/gridview_image.dart';
import 'package:pm_gallery/src/widgets/listview_image.dart';

class GalleryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GalleryController>(
      init: GalleryController(),
      id: 'body',
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text('Gallery'),
          centerTitle: true,
          actions: [_iconViewImages()],
        ),
        body: (_.gxIsLoading) 
        ? UtilsWidget.loading()
        : _body(),
        floatingActionButton: _btnsCameraGallery(_.imageCamera, _.imageGallery),
      ),
    );
  }

  Widget _btnsCameraGallery(Function _fotoCamara,Function _fotoCarrete) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          child: Icon(Icons.camera_alt, size: 35.0),
          onPressed: _fotoCamara
        ),
        SizedBox(height: 15.0),
        FloatingActionButton(
          child: Icon(Icons.photo, size: 35.0),
          onPressed: _fotoCarrete
        ),
      ]
    );
  }

  Widget _body() {
    return GetBuilder<GalleryController>(
      builder: (_) => Center(
        child: (_.gxListImages.length != 0)
        ? (_.gxTypeView == 'Lista')
          ? ListViewImage(_.gxListImages)
          : GridviewImage(_.gxListImages)
        : Text('No se han agregado imagenes'),
      ),
    );
  }

  /// Dropdown para cambiar la forma de ver la imagenes (Lista o Grid)
  Widget _iconViewImages() {
    return GetBuilder<GalleryController>(
      builder: (_) => Padding(
        padding :EdgeInsets.only(right: 8.0),
        child: DropdownButton(
          elevation: 0,
          icon: Icon(Icons.more_vert, color: Colors.white),
          underline: Container(),
          items: [
            DropdownMenuItem(
              value: 'Lista',
              child: Text('Lista')
            ),
            DropdownMenuItem(
              value: 'Grid',
              child: Text('Grid')
            ),
          ], 
          onChanged: (value) { 
            print(value);
            _.gxSetTypeView(value);
          },
        ),
      ),
    );
  }

}