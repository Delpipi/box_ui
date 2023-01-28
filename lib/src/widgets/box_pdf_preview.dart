import 'package:box_ui/box_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

const PdfColor _secondColor = PdfColor.fromInt(0xFF082845);
const PdfColor _firstColor = PdfColor.fromInt(0xFFe4a923);

class BoxPdfPreviewPage extends StatelessWidget {
  final String? title;
  final String? typeEntete;
  final List<String> headers;
  final List<List<dynamic>> data;
  final String? datetime;
  final String? assetImagePortrait;
  final String? assetImageLanscape;

  const BoxPdfPreviewPage({
    Key? key,
    this.title,
    required this.typeEntete,
    required this.headers,
    required this.data,
    this.datetime,
    this.assetImagePortrait,
    this.assetImageLanscape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF'),
      ),
      body: PdfPreview(
        allowPrinting: false,
        canDebug: false,
        build: (format) => buildPdf(format),
      ),
    );
  }

  Future<Uint8List> buildPdf(PdfPageFormat format) async {
    // Create a PDF document.
    final doc = pw.Document();

    String imagePortrait =
        await rootBundle.loadString(assetImagePortrait ?? '');
    String imageLanscape =
        await rootBundle.loadString(assetImageLanscape ?? '');

    // Add page to PDF
    doc.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          pageFormat: format,
          theme: pw.ThemeData.withFont(
            base: await PdfGoogleFonts.robotoRegular(),
            bold: await PdfGoogleFonts.robotoBold(),
            italic: await PdfGoogleFonts.robotoItalic(),
          ),
          buildBackground: (context) => pw.FullPage(
            ignoreMargins: true,
            child: pw.Positioned(
              child: pw.SvgImage(
                  svg: format.dimension.y >= format.dimension.x
                      ? imagePortrait
                      : imageLanscape),
              left: 0,
              top: 0,
            ),
          ),
        ),
        footer: _buildPdfFooter,
        build: (context) => [
          _contentHeader(context),
          _contentTable(context),
        ],
      ),
    );

    return doc.save();
  }

  pw.Widget _contentHeader(pw.Context context) {
    return pw.Column(
      mainAxisAlignment: pw.MainAxisAlignment.start,
      children: [
        pw.SizedBox(height: sizeLarge),
        pw.Container(
          alignment: pw.Alignment.centerRight,
          child: pw.Text(datetime ?? ''),
        ),
        pw.SizedBox(height: sizeSmall),
        pw.Container(
          alignment: pw.Alignment.centerLeft,
          child: pw.Text(
            title ?? '',
            style: pw.TextStyle(
                color: _secondColor,
                fontSize: 15,
                fontWeight: pw.FontWeight.bold),
          ),
        ),
        pw.SizedBox(height: sizeSmall),
      ],
    );
  }

  pw.Widget _buildPdfFooter(pw.Context context) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.end,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Text(
          'Page ${context.pageNumber}/${context.pagesCount}',
          style: const pw.TextStyle(
            color: PdfColors.black,
            fontSize: 8,
          ),
        ),
      ],
    );
  }

  pw.Widget _contentTable(pw.Context context) {
    return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: const pw.BoxDecoration(
        borderRadius: pw.BorderRadius.all(pw.Radius.circular(2)),
        color: _secondColor,
      ),
      headerHeight: 5,
      cellHeight: 5,
      headerStyle: pw.TextStyle(
        fontSize: 8.0,
        color: PdfColors.white,
        fontWeight: pw.FontWeight.bold,
      ),
      cellStyle: const pw.TextStyle(
        fontSize: 8.0,
      ),
      rowDecoration: const pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            width: .5,
          ),
        ),
      ),
      headers: headers,
      data: data,
    );
  }
}