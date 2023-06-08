import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qrreader/models/scan_model.dart';
import 'package:qrreader/providers/scan_list_provider.dart';
import 'package:qrreader/utils/utils.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  // Aqui hay configuraciones especiales para la ejecucion del qrScanner en IOS mirar video 166 curso flutter básico

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.center_focus_strong),
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode("#B7CECE", "Cancelar", false, ScanMode.QR);
        //final barcodeScanRes = "geo:36.808989,-2.589674";

        if (barcodeScanRes == -1) return; // Si devuelve -1, el usuario canceló
        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);
        final nuevoScan = await scanListProvider.nuevoScan(barcodeScanRes);
        launchURL(nuevoScan, context);
      },
    );
  }
}
