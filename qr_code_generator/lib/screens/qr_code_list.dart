import 'package:flutter/material.dart';
import '../components/utils/api/list_qr_codes.dart';

class QRCodeList extends StatefulWidget {
  const QRCodeList({super.key});

  @override
  State<QRCodeList> createState() => _QRCodeListState();
}

class _QRCodeListState extends State<QRCodeList> {
 late Stream<List<String>> streamQrCodes;

  @override
  void initState() {
    super.initState();
    streamQrCodes = fetchQrCodesStream();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<List<String>>(
          stream: streamQrCodes,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Card(child: Center(child: Text('Error: ${snapshot.error}')));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Card(child:  Center(child: Text('No QR codes found.')));
            }
      
            final qrCodes = snapshot.data!;
            return ListView.builder(
              itemCount: qrCodes.length,
              itemBuilder: (context, index) {
                final filename = qrCodes[index];
                final imageUrl = 'http://127.0.0.1:5000/generated_qr_codes/$filename';
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Card(
                    color: Colors.deepPurple.shade300,
                    child: ListTile(
                      title: Text(filename),
                      leading: SizedBox(
                        width: 100,
                        child: Image.network(imageUrl, fit: BoxFit.cover,errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.error); // Placeholder for error
                        },),
                        ),
                      onTap: () {
                        // Add functionality for tap if needed
                      },
                    ),
                  ),
                );
                
              },
            );
          },
      ),
    );
  }
}