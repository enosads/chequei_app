import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDialog {
  Widget content;
  String textCancel;
  String textConfirm;
  Function onConfirm;
  Function onCancel;
  Color confirmColor;

  AppDialog(
    this.content, {
    this.textCancel,
    this.textConfirm,
    this.onConfirm,
    this.onCancel,
    this.confirmColor,
  });

  show() => Get.defaultDialog(
        title: 'Chequei',
        content: content,
        textCancel: textCancel != null ? textCancel : null,
        onCancel: onCancel,
        confirm: RaisedButton(
          color: confirmColor,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          child: Text(
            textConfirm != null ? textConfirm : 'Sim',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: onConfirm,
        ),
      );
}
