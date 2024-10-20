import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:share_plus/share_plus.dart';
import '../components/utils/text_field_style.dart';

import 'qr_code_list.dart';

class QRCodeGenerator extends StatefulWidget {
  const QRCodeGenerator({super.key});
  
  @override
  State<QRCodeGenerator> createState() => _QRCodeGeneratorState();

}

class _QRCodeGeneratorState extends State<QRCodeGenerator> {
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _filenameController = TextEditingController();
  String? qrImagePath;

  void _generateQR() async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/generate_qr'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'data': _dataController.text,
        'filename': _filenameController.text.isNotEmpty
            ? _filenameController.text
            : 'qr_code.png',
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      setState(() {
        qrImagePath = jsonResponse['imagePath'];
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(jsonResponse['message'])),
      );
      _dataController.clear();
      _filenameController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to generate QR code')),
      );
    }
  }

  void _shareQR() async {
    if (qrImagePath != null) {
      final box = context.findRenderObject() as RenderBox?;
    final shareResult = await Share.shareXFiles(
      [XFile(qrImagePath!)],
      text: 'Check out my QR code!',
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
    ScaffoldMessenger.of(context).showSnackBar(SnackBar( content: Text(shareResult.toString()),));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No QR code to share')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('QR Code Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            children: [
              Card(
                color: Colors.deepPurple.shade300,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 20),
                      child: TextField(
                        controller: _dataController,
                        decoration: inputDecoration('Enter text or URL'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10,left: 8.0, right: 8.0),
                      child: TextField(
                        controller: _filenameController,
                        decoration: inputDecoration('Enter filename (optional)'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _generateQR,
                      child:const  Text('Generate QR Code'),
                    ),
                    const SizedBox(height: 30,)
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const QRCodeList()
            ],
          ),
        ),
    );
  }
}
