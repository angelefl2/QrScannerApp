import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrreader/providers/scan_list_provider.dart';

class DireccionesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
       final scanListProvider = Provider.of<ScanListProvider>(context);
  
    return ListView.builder(
      itemCount: scanListProvider.scans.length,
      itemBuilder: (_, int i) => ListTile(
        leading: Icon(
          Icons.link,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(scanListProvider.scans[i].valor),
        subtitle: Text("ID: ${scanListProvider.scans[i].id}"),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
        onTap: () => print(scanListProvider.scans[i].id),
      ),
    );
    
  }
}
