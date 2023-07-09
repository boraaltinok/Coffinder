import 'package:coffinder/Utilities/FontSizeUtility.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:get/get.dart';

class BarcodeScanPage extends StatefulWidget {
  const BarcodeScanPage({Key? key}) : super(key: key);

  @override
  _BarcodeScanPageState createState() => _BarcodeScanPageState();
}

class _BarcodeScanPageState extends State<BarcodeScanPage> {
  late MobileScannerController cameraController;
  bool _screenOpened = false;
  late bool _isBookAdded;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cameraController = MobileScannerController(
        detectionSpeed: DetectionSpeed.noDuplicates, autoStart: true);
    cameraController.stop(); //to avoid reopening bug
    _isBookAdded = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    cameraController.stop();
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double appBarHeight = AppBar().preferredSize.height;
    final double appBarActionsHeight = AppBar().preferredSize.height;

    var statusBarHeight = MediaQuery.of(context).viewPadding.top;

    final double availableHeight =
        screenHeight - (appBarHeight + statusBarHeight);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: FittedBox(
          fit: BoxFit.cover,
          child: Text(
            "Scan the QR of the Coffe Shop",
            style: TextStyle(color: Colors.black),
          ),
        ),
        actions: [
          IconButton(
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state as TorchState) {
                  case TorchState.off:
                    return Icon(
                      Icons.flash_off,
                    );
                  case TorchState.on:
                    return Icon(
                      Icons.flash_on,
                    );
                }
              },
            ),
            onPressed: () => cameraController.toggleTorch(),
            iconSize: 32,
          ),
          IconButton(
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state as CameraFacing) {
                  case CameraFacing.front:
                    return Icon(
                      Icons.camera_front,
                    );
                  case CameraFacing.back:
                    return Icon(
                      Icons.camera_rear,
                    );
                }
              },
            ),
            onPressed: () => cameraController.switchCamera(),
            iconSize: 32,
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            //allowDuplicates: true,
            controller: cameraController,
            onDetect: _foundBarcode,
          ),
          Positioned(
            top: 0,
            child: Container(
              height: availableHeight / 3,
              width: Get.width,
              color: Colors.black.withOpacity(
                  0.7), // Set the desired overlay color and opacity
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: availableHeight / 3,
              width: Get.width,
              color: Colors.black.withOpacity(
                  0.7), // Set the desired overlay color and opacity
            ),
          ),
          Positioned(
            top: availableHeight / 3,
            bottom: availableHeight / 3,
            right: 0,
            child: Container(
              height: availableHeight / 3,
              width: Get.width / 5,
              color: Colors.black.withOpacity(
                  0.7), // Set the desired overlay color and opacity
            ),
          ),
          Positioned(
            top: availableHeight / 3,
            bottom: availableHeight / 3,
            left: 0,
            child: Container(
              height: availableHeight / 3,
              width: Get.width / 5,
              color: Colors.black.withOpacity(
                  0.7), // Set the desired overlay color and opacity
            ),
          ),
          Positioned(
            top: availableHeight / 3 / 2,
            child: Container(
              height: availableHeight / 6,
              width: Get.width,
              child: Center(
                  child: Text("Please scan the Barcode of your Coffe Shop", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: FontSizeUtility.font20),)),
            ),
          ),
          Center(
            child: Container(
              width: Get.width * 3 / 5,
              // Adjust the size of the indicator as needed
              height: availableHeight / 3,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _foundBarcode(BarcodeCapture barcode) async {
    ///open screen
    if (!_screenOpened) {
      final String code = barcode.barcodes[0].rawValue ?? "----";
      debugPrint('Barcode found $code');
      _screenOpened = true;
      //fetchBooksInfo(code);
    }
  }

  /*void fetchBooksInfo(String code) async {
    String result = "";
    var response;
    try {
      response = await Dio().get('https://api2.isbndb.com/book/$code',
          options: Options(
            headers: {"Authorization": ISBN_API_KEY},
          ));
      if (response.statusCode == 200) {
        print("I AM 200 success");
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        var snackBar =
        SnackBar(content: Text('This is not a valid ISBN barcode $code'));

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        print(e.response?.statusCode);
      }
    }
    late Book scannedBook;
    var scannedBookInfo;
    if (response != null) {
      scannedBookInfo = response.data; // this is a map
    }
    if (scannedBookInfo != null) {
      scannedBook = Book(
          bookName: scannedBookInfo['book']['title'],
          bookAuthor: scannedBookInfo['book']['authors'][0],
          dateAdded: DateTime.now(),
          userId: authController.user.uid,
          bookCover: scannedBookInfo['book']['image']);
      print(scannedBookInfo['book']['image']);
      //await bookController.uploadBookCoverToStorage(authController.user.uid, scannedBookInfo['book']['image']);
      await bookController.uploadBook(
          bookName: scannedBookInfo['book']['title'],
          bookAuthor: scannedBookInfo['book']['authors'][0],
          isItScan: true,
          bookCoverPath: scannedBookInfo['book']['image']);
      //NotesDatabase.instance.createBook(scannedBook);
      setState(() {
        _isBookAdded = true;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const BooksPage()));
      });
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const BooksPage()));

    //return scannedBook;
  }*/

  void _screenWasClosed() {
    _screenOpened = false;
  }
}

class FoundCodeScreen extends StatefulWidget {
  final String value;
  final Function() screenClosed;

  const FoundCodeScreen(
      {Key? key, required this.value, required this.screenClosed})
      : super(key: key);

  @override
  _FoundCodeScreenState createState() => _FoundCodeScreenState();
}

class _FoundCodeScreenState extends State<FoundCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Found Code"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            widget.screenClosed();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.chevron_left),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Scanned Code",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.value,
                style: const TextStyle(fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
