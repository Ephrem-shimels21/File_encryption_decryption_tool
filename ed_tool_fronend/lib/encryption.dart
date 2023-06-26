import 'dart:io';
import 'dart:typed_data';
import  'dart:math';
import   'dart:convert';
import 'package:convert/convert.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:aes_crypt_null_safe/aes_crypt_null_safe.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:html' as ht;




class EncryptionPage extends StatefulWidget {
  const EncryptionPage({Key? key}) : super(key: key);

  @override
  State<EncryptionPage> createState() => _EncryptionPageState();
}

class _EncryptionPageState extends State<EncryptionPage> {
  final storage = FlutterSecureStorage();
  Uint8List? fileAsB;
  String? _path;
  String? pat;
  String? encFilepath;
  String? filename;

  Future<File> saveFilePermanently(PlatformFile file) async {
    final appStorage = await getExternalStorageDirectory();
    final newFile = File('${appStorage!.path}/${file.name}');
    return File(file.path!).copy(newFile.path);
  }

  
  @override
  
  

  Widget _buildLogo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Encryption',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height / 75,
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
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 1 * (MediaQuery.of(context).size.width / 10),
          margin: const EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
            onPressed: () async {
              PlatformFile? _platformFile;
              final file = await FilePicker.platform.pickFiles();
         
              
              if (file != null) {
               fileAsB = file.files.single.bytes;
              

               
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: const Color(0xff006aff),
                    content: Text(
                      ' File Selected',
                      textAlign: TextAlign.center,
                    )));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Color(0xffee122a),
                    content: Text(
                      ' File not Selected.Abort',
                      textAlign: TextAlign.center,
                    )));
                print("abort");
              }
            },
            style: ElevatedButton.styleFrom(
              primary: const Color(0xffee122a),
              shape: const StadiumBorder(),
            ),
            child: Text(
              "Add File",
              textAlign: TextAlign.center,
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
  Widget _buildEncryptButton() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        height: 1 * (MediaQuery.of(context).size.height / 20),
        width: 1 * (MediaQuery.of(context).size.width / 10),
        margin: const EdgeInsets.only(bottom: 20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xffee122a),
            shape: const StadiumBorder(),
          ),
          onPressed: () async {
            FocusScope.of(context).unfocus();
          
            if (fileAsB != null) {
              final token =  storage.read(key: 'token');
              final encKeyHex =  await storage.read(key: 'enckey');
              final encKeyBytes = Uint8List.fromList(hex.decode(encKeyHex!));
              
              AesCrypt crypt = AesCrypt();
              crypt.aesSetMode(AesMode.cbc);
              crypt.setOverwriteMode(AesCryptOwMode.rename);
              Uint8List key = encKeyBytes;

              final random = Random.secure();
              final keyBytes = List.generate(16, (_) => random.nextInt(256));

              Uint8List iv = Uint8List.fromList(keyBytes);
             

              AesMode mode = AesMode.cbc; 
           
              crypt.aesSetKeys(key, iv);
              crypt.aesSetMode(mode);
              
                final blockLength = 16;
                final paddingLength = blockLength - fileAsB!.length % blockLength;
                final paddedData = Uint8List(fileAsB!.length + paddingLength)..setAll(0, fileAsB!);
              try {

                Uint8List encryptedData = crypt.aesEncrypt(paddedData);

                final dataWithIv = Uint8List.fromList([...iv, ...encryptedData]);
                 final blob = ht.Blob([dataWithIv], 'application/octet-stream');
                  final url = ht.Url.createObjectUrlFromBlob(blob);
                  final anchor = ht.document.createElement('a') as ht.AnchorElement;
                  anchor.href = url;
                  anchor.download = 'encrypted_file.aes';
                  anchor.click();

                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Color(0xff006aff),
                    content: Text(
                      ' File Encryption Success',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )));

               
              } on AesCryptException catch (e) {
                if (e.type == AesCryptExceptionType.destFileExists) {
                    print('The encryption has been completed unsuccessfully.');
                    print(e.message);
                  }
              }
            } else {
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
            "Encrypt",
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
            height: MediaQuery.of(context).size.width * 0.5,
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 10,
                  blurRadius: 100,
                  offset: Offset(20, 20), // changes position of shadow
                ),
              ],
              color: Color(0xff282828),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildAddFileButton(),
                _buildEncryptButton(),
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
 
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 241, 217, 224),
                      borderRadius: BorderRadius.only(
                         
                          )),
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // _buildLogo(),
                _buildContainer(),
               
              ],
            )
          ],
        ),
      ),
      // ),
    );
  }
}
