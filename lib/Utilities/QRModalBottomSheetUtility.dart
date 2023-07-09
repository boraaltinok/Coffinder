import 'package:flutter/material.dart';

import '../screens/BarcodeScanScreens/barcode_scan_page.dart';

class QRModalBottomSheetUtility {
  static Future<dynamic> buildQRScanBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return const BarcodeScanPage();
        });
  }
}
