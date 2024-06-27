
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/PdfAppBar.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';

class PdfPageFile extends StatefulWidget {
  final String title;
  final File url;
  const PdfPageFile(this.title,this.url,{super.key});

  @override
  State<PdfPageFile> createState() => _PdfPageFileState();
}

class _PdfPageFileState extends State<PdfPageFile> {

  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  PdfViewerController controller = PdfViewerController();

  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorUtil().getColor(context, ColorEnums.background),
      appBar:PdfAppBar(name: widget.title,controller: controller,),
      body:SfPdfViewer.file(
        widget.url,
        controller: controller,
        key: _pdfViewerKey,
        maxZoomLevel: 10,
        pageLayoutMode: PdfPageLayoutMode.single,
        scrollDirection: PdfScrollDirection.horizontal, //scrool hizası
        canShowPaginationDialog: true,
        canShowPageLoadingIndicator: true,
        onAnnotationEdited:(Annotation annotation){
          annotation.isLocked = true;
        },
        onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
          snackBarDesign(context, StringUtil.error, details.description);
        },
      ),

    );
  }

}