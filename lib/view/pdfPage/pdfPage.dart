
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:wizzsales/constants/ColorsUtil.dart';
import 'package:wizzsales/utils/res/StringUtils.dart';
import 'package:wizzsales/utils/style/ColorEnums.dart';
import 'package:wizzsales/utils/style/PdfAppBar.dart';
import 'package:wizzsales/utils/style/WidgetStyle.dart';

class PdfPage extends StatefulWidget {
  final String title;
  final String url;
  const PdfPage(this.title,this.url,{super.key});

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
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
        body:SfPdfViewer.network(
                  widget.url,
                  controller: controller,
                  key: _pdfViewerKey,
                  maxZoomLevel: 10,
                   canShowSignaturePadDialog:true,
                   canShowPaginationDialog: true,
                   pageLayoutMode: PdfPageLayoutMode.single,
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
