import 'package:flutter/material.dart';
import 'package:scan/scan.dart';

// 二维码扫描页面
class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  StateSetter stateSetter;
  IconData lightIcon = Icons.flash_on;
  ScanController controller = ScanController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("扫码"),
      ),
      body: Stack(children: [
        ScanView(
          controller: controller,
          scanAreaScale: .7,
          scanLineColor: Color(0xFF4759DA),
          onCapture: (data) {
            Navigator.of(context).pop([data]);
          },
        ),
      ]),
    );
  }
}
