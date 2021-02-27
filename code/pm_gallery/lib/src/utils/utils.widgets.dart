
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pm_gallery/src/utils/utils.dart';

class UtilsWidget {

  /// Muestra una alerta/dialog básica (Usando GetX)
  static Future<AlertDialog> showAlert(BuildContext context, String titulo, String mensaje, String txtBoton) {
    return  Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))
        ),
        contentPadding: EdgeInsets.only(top: 20.0),
        content: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Center(
                  child: Text(
                    titulo,
                    style: TextStyle(
                      fontSize: 22.0, fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Center(
                    child: Text(
                      mensaje,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  children: <Widget>[
                    Expanded(child: _cBotonAlerta(context, txtBoton))
                  ],
                )
              ],
            ),
          ),
        ),
      )
    );
  }

  static Widget _cBotonAlerta(BuildContext context, String txtBoton) {
    return RaisedButton(
      color: Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0)
        )
      ),
      child: Container(
        height: 50.0,
        width: Utils.percentW(context, 50),
        child: Center(
          child: Text(
            txtBoton,
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
      onPressed: () => Get.back(),
    );
  }

  /// Muestra un CircularProgressIndicator
  static Widget loading() {
    return Center(
      child: CircularProgressIndicator(backgroundColor: Colors.blue),
    );
  }

  static void showMyRawSnackBar(String myMessage) {
    Get.rawSnackbar(
      message: myMessage,
      snackStyle: SnackStyle.GROUNDED,
      duration: Duration(milliseconds: 2000),
      snackPosition: SnackPosition.BOTTOM
    );
  }

  static void showMySnackBar(String myTitle, String myMessage) {
    Get.snackbar(
      myTitle,
      myMessage,
      backgroundColor: Color(0xFF20B6A2),
      snackPosition: SnackPosition.BOTTOM
    );
  }

}