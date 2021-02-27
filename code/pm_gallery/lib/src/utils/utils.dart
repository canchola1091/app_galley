import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Utils {

  /// Devuelve el porcentaje del ancho (width) de la pantalla (50 = 50% de la pantalla)
  static double percentW(BuildContext context, int valor) {
    final size = MediaQuery.of(context).size;
    return ((size.width / 100) * valor);
  }

  /// Devuelve el porcentaje del alto (height) de la pantalla (50 = 50% de la pantalla)
  static double percentH(BuildContext context, int valor) {
    final size = MediaQuery.of(context).size;
    return ((size.height / 100) * valor);
  }

  //FUNCION COLOR DE HEXADECIMAL
  static Color hexToColor(String codeColor) => Color(int.parse(codeColor.substring(1, 7), radix: 16) + 0xFF000000);

  /// Verifica el status de los permisos de Microfono y Camara y dependiendo
  /// de su estatus los vuelve a pedir (este Future resuelve un entero)
  static Future<int> reqPermission(BuildContext context) async{

    int reqper;
    var pCameraStatus = await Permission.camera.status;
    var pMicroStatus = await Permission.microphone.status;

    if(pCameraStatus.isUndetermined || pMicroStatus.isUndetermined)  {
        print('Permisos indeterminados');
        await [
          Permission.camera, 
          Permission.microphone
        ].request();
        return reqper = 0; // Permisos indeterminados
    }else if(pCameraStatus.isDenied || pMicroStatus.isDenied){
        print('Permisos negados');
        await [
          Permission.camera, 
          Permission.microphone
        ].request();
        return reqper = 1; // Permisos negados
    }else if(pCameraStatus.isPermanentlyDenied || pMicroStatus.isPermanentlyDenied) {
      print('Permisos negados permanentemente');
      return reqper = 2; // Permisos negados permanentemente
    }else if(pCameraStatus.isGranted || pMicroStatus.isGranted) {
      print('Permisos otorgados');
      return reqper = 3; // permisos otorgados
    }
    return reqper;
  }
  
}
