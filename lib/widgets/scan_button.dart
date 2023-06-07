import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qrreader/providers/scan_list_provider.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  // Aqui hay configuraciones especiales para la ejecucion del qrScanner en IOS mirar video 166 curso flutter básico

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.center_focus_strong),
      onPressed: () async {
        //String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        //  "#B7CECE", "Cancelar", false, ScanMode.QR);
        //final barcodeScanRes = "mi url";
        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);
      },
    );
  }
}
