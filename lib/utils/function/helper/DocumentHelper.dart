import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';
import 'package:wizzsales/widgets/Constant.dart';
import 'package:wizzsales/widgets/Extension.dart';
import 'package:wizzsales/widgets/WidgetExtension.dart';
// ignore_for_file: use_build_context_synchronously

class DocumentHelper {
  static Future<Map<String, dynamic>> getDocument(BuildContext context) async {
    Map<String, dynamic> docFile = {};
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    File? selectedFile;

    if (result != null) {
      selectedFile = File(result.files.single.path!);
      int fileSize = await selectedFile.length();
      double mg = bytesToMegabytes(fileSize);
      print("fileSize :$mg");
      if(mg<10.00){
        docFile["document"] = selectedFile;
        docFile["fileType"] = _getFileType(selectedFile.path);
      }else{
        snackBarDesign(context, StringUtil.error, "fileSize10mb".tr());
      }
    }
    return docFile;
  }

  static String _getFileType(String filePath) {
    List<String> segments = filePath.split('.');
    return segments.last.toLowerCase();
  }
}