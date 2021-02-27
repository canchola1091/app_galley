
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pm_gallery/src/models/image_model.dart';
import 'package:pm_gallery/src/utils/utils.widgets.dart';
import 'package:sqflite/sqflite.dart';

// import 'dart:convert';
// import 'package:sqflite/sqflite.dart';

class GalleryController extends GetxController {

  ImagePicker picker = ImagePicker();
  PickedFile _image;
  String _imagePath;
  File _savedImage;
  bool _isLoading = true;
  String _typeView;
  List<ImageModel> _listImages;

  // DataBase
  Database _db;


  //? GETTERS
  PickedFile get gxImage => _image;
  String get gxImagePath => _imagePath;
  File get gxSavedImage => _savedImage;
  String get gxTypeView=> _typeView;
  bool get gxIsLoading => _isLoading;
  List<ImageModel> get gxListImages => _listImages;

  //? SETTERS
  void gxSetTypeView(String value) {
    _typeView = value;
    update(['body']);
  }

  //* ======= ESTADOS ============
  @override
    void onInit() {
      initializeDataBase();
      super.onInit();
    }
  //* ============================

  //? ========== METODOS =============

  // Inicializa la base de datos
  Future<Database> initializeDataBase() async {
    print('-->✅ Iniciando Base de Datos');
    try {
      var _dataBase = openDatabase(
        join(await getDatabasesPath(), 'imageDB.db'), // Nombre de la base de datos
        onCreate: (db, version) {
          return db.execute(
            "CREATE TABLE imageTable(id INTEGER PRIMARY KEY autoincrement, pathImage TEXT, dateImage TEXT)"
          );
        },
        version: 1
      );
      _db = await _dataBase;
      _listImages = await gxGetListImages();
      print('Largo de Lista imagenes: ${_listImages.length}');
      return _dataBase;
    } catch (e) {
      UtilsWidget.showAlert(Get.overlayContext, 'Error', 'Ocurrio un error al recuperar los datos', 'Cerrar');
      print(e);
      return null;
    }
  }

  ///Inserta los datos de la imagen a la base de datos (path , fecha)
  void addImageToDB() async {
    final DateTime _dateTime = DateTime.now();
    try {
      ImageModel _mapDataImage = ImageModel(
        pathImage: _savedImage.path,
        dateImage: '${_dateTime.day}/${_dateTime.month}/${_dateTime.year}',
      );
      await _db.insert(
        'imageTable', 
        _mapDataImage.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      _isLoading = true;
      _listImages = await gxGetListImages();
      update(['body']);
    } catch (e) {
      print('Error en insert: $e');
    }
  }
  

  /// Consulta y obtiene la lista de imagenes guardadas en la base de datos
  Future<List<ImageModel>> gxGetListImages() async {
    try {
      final List<Map<String, dynamic>> _listIMG = await _db.query('imageTable');
      _isLoading = false;
      update(['body']);
      final myListImages = imageModelFromJson(json.encode(_listIMG));
      return myListImages.reversed.toList(); //Mostar la lista de reversa
    } catch (e) {
      print('--> Error: $e');
      return [];
    }
  }

  /// Accede a la galería
  Future<bool>imageGallery() async {
    // _image = null;
    try{
      final Directory directory = await getApplicationDocumentsDirectory();
      final path = directory.path;
      _image = await picker.getImage(source: ImageSource.gallery);
      _imagePath = _image.path;
      final fileName = basename(_imagePath);
      _savedImage = await File(_imagePath).copy('$path/$fileName');
      print('--> Path de imagen: $_savedImage');
      addImageToDB();
      update(['body']);
      return true;
    }
    catch(e){
      UtilsWidget.showAlert(Get.context, 'Upss', 'No seleccionaste ninguna foto', 'Cerrar');
      return false;
    }
  }

  /// Capturar una foto
  Future<bool>imageCamera() async {
    // _image = null;
    try{
      final Directory directory = await getApplicationDocumentsDirectory();
      final path = directory.path;
      _image = await picker.getImage(source: ImageSource.camera);
      _imagePath = _image.path;
      final fileName = basename(_imagePath);
      _savedImage = await File(_imagePath).copy('$path/$fileName');
      print('--> Path de imagen: $_savedImage');
      addImageToDB();
      update(['body']);
      return true;
    }
    catch(e){
      UtilsWidget.showAlert(Get.context, 'Upss', 'No capturaste ninguna foto', 'Cerrar');
      return false;
    }
  }



}