import 'package:flutter/cupertino.dart';
import 'package:qrreader/models/scan_model.dart';
import "package:url_launcher/url_launcher.dart";

launchURL(ScanModel scan, BuildContext context) async {
  final url = scan.valor;

  if (scan.tipo == "http") {
    // Arbir sitio web
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not launch $url";
    }
  } else {
    Navigator.pushNamed(context, "mapa", arguments: scan);
  }
}
