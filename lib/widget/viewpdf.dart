import 'package:cartoonex/models/cartoonmodel.dart';
import 'package:cartoonex/utility/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

//17.10.2021
class ViewCartoonPDF extends StatefulWidget {
  final CartoonModel cartoonModel;
  ViewCartoonPDF({Key key, this.cartoonModel}) : super(key: key);

  @override
  _ViewCartoonPDFState createState() => _ViewCartoonPDFState();
}

class _ViewCartoonPDFState extends State<ViewCartoonPDF> {
  CartoonModel model;
  PDFDocument pdfDocument;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = widget.cartoonModel;
    createPDFdecoment();
  }

  Future<Null> createPDFdecoment() async {
    try {
      var result = await PDFDocument.fromURL(model.pdf);
      setState(() {
        pdfDocument = result;
      });
    } catch (e) {
      print('${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style().prinaryColor,
        title: Text(model.name == null ? 'Read Cartoon PDF ' : model.name),
      ),
      body: pdfDocument == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : PDFViewer(document: pdfDocument),
    );
  }
}
