import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:convert/convert.dart';
import 'package:flutter/material.dart';

import 'package:aes_crypt_null_safe/aes_crypt_null_safe.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:html' as ht;
//import 'package:path/path.dart';


class decryptionPage extends StatefulWidget {
  const decryptionPage({Key? key}) : super(key: key);

  @override
  State<decryptionPage> createState() => _decryptionPageState();
}

class _decryptionPageState extends State<decryptionPage> {
  Uint8List? encryFileAsB;
  int count = 0;
  String? _path;
  String? _pathpic;
  String? pat;
  String? decFilepath;
  String? filename;
  String? _tempfilename;

  final storage = FlutterSecureStorage();


  Widget _buildLogo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Decryption',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height / 25,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 255, 255, 255),
              )),
        ],
      ),
    );
  }

 

  
  Widget _buildAddFileButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1 * (MediaQuery.of(context).size.height / 20),
          width: 1 * (MediaQuery.of(context).size.width / 10),
          margin: const EdgeInsets.only(bottom: 20, top: 5),
          child: ElevatedButton(
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles();

              if (result != null) {
                encryFileAsB = result.files.single.bytes;

                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Color(0xff006aff),
                    content: Text(' File Selected')));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Color(0xffee122a),
                    content: Text(' File not Selected.Abort')));
              }
            },
            style: ElevatedButton.styleFrom(
              primary: const Color(0xffee122a),
              shape: const StadiumBorder(),
            ),
            child: Text(
              "Add File",
              style: TextStyle(
                color: const Color.fromARGB(255, 255, 255, 255),
                letterSpacing: 1.5,
                fontSize: MediaQuery.of(context).size.height / 40,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _builddecryptButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 1 * (MediaQuery.of(context).size.width / 10),
          margin: const EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: const Color(0xffee122a),
              shape: const StadiumBorder(),
            ),
            onPressed: () async {
              FocusScope.of(context).unfocus();
              
              final token =  storage.read(key: 'token');
              final encKeyHex =  await storage.read(key: 'enckey');
              final encKeyBytes = Uint8List.fromList(hex.decode(encKeyHex!));
             
            
                AesCrypt crypt = AesCrypt();
               final ivBytes = (encryFileAsB!.sublist(0, 16));
           
                final encryptedBytes = encryFileAsB!.sublist(16);
            
              crypt.setOverwriteMode(AesCryptOwMode.rename);
              
              Uint8List key = encKeyBytes;
              Uint8List iv = Uint8List.fromList(ivBytes);

              AesMode mode = AesMode.cbc; // Ok. I know it's meaningless here.
              crypt.aesSetKeys(key, iv);
          
              crypt.aesSetMode(mode);

                try {
                  Uint8List decryptedData = crypt.aesDecrypt(encryptedBytes);

                  final fileHeader = Uint8List.view(decryptedData.buffer, 0, 8);

                    if (fileHeader[0] == 0xFF && fileHeader[1] == 0xD8) {
                      final blob = ht.Blob([decryptedData], 'application/octet-stream');
                      final url = ht.Url.createObjectUrlFromBlob(blob);
                      final anchor = ht.document.createElement('a') as ht.AnchorElement;
                      anchor.href = url;
                      anchor.download = 'decrypted_file.JPEG';
                      anchor.click();
                      
                       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Color(0xff006aff),
                      content: Text(
                        ' File Decryption Success',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )));
                    } else if (fileHeader[0] == 0x89 && fileHeader[1] == 0x50 && fileHeader[2] == 0x4E && fileHeader[3] == 0x47) {
                      // File is a PNG image
                      final blob = ht.Blob([decryptedData], 'application/octet-stream');
                      final url = ht.Url.createObjectUrlFromBlob(blob);
                      final anchor = ht.document.createElement('a') as ht.AnchorElement;
                      anchor.href = url;
                      anchor.download = 'decrypted_file.PNG';
                      anchor.click();
                      
                       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Color(0xff006aff),
                      content: Text(
                        ' File Decryption Success',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )));
                    } else if (fileHeader[0] == 0x25 && fileHeader[1] == 0x50 && fileHeader[2] == 0x44 && fileHeader[3] == 0x46) {
                      // File is a PDF document
                      final blob = ht.Blob([decryptedData], 'application/octet-stream');
                      final url = ht.Url.createObjectUrlFromBlob(blob);
                      final anchor = ht.document.createElement('a') as ht.AnchorElement;
                      anchor.href = url;
                      anchor.download = 'decrypted_file.PDF';
                      anchor.click();
             
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Color(0xff006aff),
                      content: Text(
                        ' File Decryption Success',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )));
                    } else if (fileHeader[0] == 0x50 && fileHeader[1] == 0x4B && fileHeader[2] == 0x03 && fileHeader[3] == 0x04) {
                      // File is a ZIP archive
                      final blob = ht.Blob([decryptedData], 'application/octet-stream');
                      final url = ht.Url.createObjectUrlFromBlob(blob);
                      final anchor = ht.document.createElement('a') as ht.AnchorElement;
                      anchor.href = url;
                      anchor.download = 'decrypted_file.ZIP';
                      anchor.click();
                       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Color(0xff006aff),
                      content: Text(
                        ' File Decryption Success',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )));
                    } else if (fileHeader[0] == 0xD0 && fileHeader[1] == 0xCF && fileHeader[2] == 0x11 && fileHeader[3] == 0xE0 && fileHeader[4] == 0xA1 && fileHeader[5] == 0xB1 && fileHeader[6] == 0x1A && fileHeader[7] == 0xE1) {
                    // File is a Word document
                    final blob = ht.Blob([decryptedData], 'application/octet-stream');
                      final url = ht.Url.createObjectUrlFromBlob(blob);
                      final anchor = ht.document.createElement('a') as ht.AnchorElement;
                      anchor.href = url;
                      anchor.download = 'decrypted_file.docx';
                      anchor.click();
                       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Color(0xff006aff),
                      content: Text(
                        ' File Decryption Success',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )));

                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Color.fromARGB(255, 255, 51, 0),
                      content: Text(
                        'File format is unknown or unsupported',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )));
                    }
                 
                } catch (e) {
                  print('The decryption has been completed unsuccessfully.');
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Color(0xffee122a),
                      content: Text(
                        ' Decryption unsuccessfull! please enter valid password',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )));
                  print(e);
                }
              
              if (encryFileAsB == null) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Color(0xffee122a),
                    content: Text(
                      'Please select file',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )));
              }
             
            },
            child: Text(
              "Decrypt",
              style: TextStyle(
                color: const Color.fromARGB(255, 255, 255, 255),
                letterSpacing: 1.5,
                fontSize: MediaQuery.of(context).size.height / 40,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Container(
            height: MediaQuery.of(context).size.width  * 0.5,
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  spreadRadius: 10,
                  blurRadius: 100,
                  offset: Offset(15, 15), // changes position of shadow
                ),
              ],
              color: Color(0xff282828),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(5),
                ),
                _buildAddFileButton(),
                _builddecryptButton(),
                 Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    }, 
                    child: Text("Back to HomePage") ) 
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // return SafeArea(
    //  child:
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,

        body: Stack(
          children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height ,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 241, 225, 227),
                      borderRadius: BorderRadius.only(
                          // bottomLeft: Radius.circular(70),
                          //bottomRight: Radius.circular(70),
                          )),
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[_buildLogo(), _buildContainer()],
            ),
          ],
        ),
        // ),
      ),
    );
  }
}
