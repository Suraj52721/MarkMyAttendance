import 'dart:io';
import 'package:attendance_manager/process.dart';
import 'package:attendance_manager/view_attendance.dart';
import 'package:device_uuid/device_uuid.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRpage extends StatefulWidget {
  const QRpage({super.key});

  @override
  State<QRpage> createState() => _QRpageState();
}

class _QRpageState extends State<QRpage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 9,
                child: Container(
                    alignment: Alignment.bottomCenter,
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).size.height / 8,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        OutlinedButton(onPressed: (){
                          //pause camera
                          controller!.pauseCamera();
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewAttendance()));
                        }, child: Text('View Attendance', style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),)),
                        FutureBuilder(
                      future: DeviceUuid().getUUID(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print(snapshot.data.toString());
                          return SelectableText(
                            '${snapshot.data}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          );
                        } else {
                          return const Text('Loading...',
                              textAlign: TextAlign.center);
                        }
                      },
                    )
                      ]
                    )),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: AlignmentDirectional.bottomCenter,
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 50, right: 50, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Scanning...',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if (result!.code == 'hello') {
          controller.stopCamera();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ProcessPage()),
          );
        }
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
