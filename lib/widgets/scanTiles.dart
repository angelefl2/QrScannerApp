import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrreader/providers/scan_list_provider.dart';
import 'package:qrreader/utils/utils.dart';

class ScanTiles extends StatelessWidget {
  final String tipo;
  const ScanTiles({super.key, required this.tipo});

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);

    return ListView.builder(
      itemCount: scanListProvider.scans.length,
      itemBuilder: (_, int i) => Dismissible(
        // Permite hacer swipe y borrar el elemento pero no borra de la bd
        key: UniqueKey(),
        onDismissed: (DismissDirection direction) {
          Provider.of<ScanListProvider>(context, listen: false)
              .borrarScanPorId(scanListProvider.scans[i].id!);
        },
        background: Container(
          color: Colors.red,
        ), // Esta funcion genera un key unico para cada elemento
        child: ListTile(
          leading: Icon(
            this.tipo == "http" ? Icons.link : Icons.map,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(scanListProvider.scans[i].valor),
          subtitle: Text("ID: ${scanListProvider.scans[i].id}"),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
          onTap: () => launchURL(scanListProvider.scans[i], context)
        ),
      ),
    );
  }
}
