import 'package:ed_tool_fronend/decryption.dart';
import 'package:ed_tool_fronend/encryption.dart';
// import 'package:ed_tool_fronend/decryption.dart';
// import 'package:ed_tool_fronend/encryption.dart';
import 'package:flutter/material.dart';
void main(){

  runApp(HomePage());

}


class HomePage extends StatelessWidget{

  Widget build (BuildContext context){
    return  MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Encryption-Decryption-tool'),
        ),
        body: Center(
          child: Row(
            children: [
              Padding(padding: EdgeInsets.all(40)),
              Builder(
                builder: (context) =>ElevatedButton(
                // onPressed: Navigator.of(context).push(EncryptionPage()),
                onPressed: (){
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => EncryptionPage()));
                },
                child: Text('Encryption'))),
              Padding(padding:EdgeInsets.all(40)),
              Builder(
                builder: (context) => ElevatedButton(
                child: Text('Decryption'),
                // onPressed: Navigator.of(context).push(DcryptionPage())
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => decryptionPage() )
                  );
                }

              )
              )
            ],
          )
        ),
      ),
      );
  }
}




















// import 'dart:io';
// import 'dart:typed_data';

// import 'package:file_picker/file_picker.dart';

// import 'package:flutter/material.dart';

// import 'package:aes_crypt_null_safe/aes_crypt_null_safe.dart';
// // import 'package:google_fonts/google_fonts.dart';
// import 'package:path_provider/path_provider.dart';

// // class EncryptionScreen extends StatefulWidget {
// //   const EncryptionScreen({Key? key}) : super(key: key);

// //   @override
// //   _IdentityPageState createState() => _IdentityPageState();
// // }

// // class _IdentityPageState extends State<EncryptionScreen> {
// //   String? _path;
// //   String? pat;
// //   String? encFilepath;
// //   String? filename;

// //   Future<File> saveFilePermanently(PlatformFile file) async {
// //     final appStorage = await getExternalStorageDirectory();
// //     final newFile = File('${appStorage!.path}/${file.name}');
// //     return File(file.path!).copy(newFile.path);
// //   }

// //   bool _validate = false;
// //   @override
// //   void dispose() {
// //     _textController.dispose();
// //     super.dispose();
// //   }

// //   Future<File> saveFile(String file) async {
// //     Directory? appStorage = await getExternalStorageDirectory();
// //     var fileName = (file.split('/').last);
// //     final newfile = ('${appStorage!.path}/$fileName');

// //     return File(file).copy(newfile);
// //   }

// //   Future<File> saveFile1(String file) async {
// //     const appStorage = ('/storage/emulated/0/Download');
// //     var fileName = (file.split('/').last);
// //     final newfile = ('$appStorage/$fileName');

// //     return (File(file).copy(newfile));
// //   }

// //   final _textController = TextEditingController();
// //   @override
// //   Widget build(BuildContext context) {
// //     //requestStoragePermission();
// //     return Scaffold(
// //       backgroundColor: const Color(0xFF1D1D35),
// //       resizeToAvoidBottomInset: false,
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 0),
// //               child: TextField(
// //                 controller: _textController,
    
// //                 // style: TextStyle(color: Colors.white),
// //                 decoration: InputDecoration(
// //                     errorText: _validate ? 'please enter password' : null,
// //                     hintText: 'Enter your pin or password',
// //                     filled: true,
// //                     fillColor: Colors.white,
// //                     border: const OutlineInputBorder(
// //                         borderSide: BorderSide(width: 4),
// //                         borderRadius: BorderRadius.all(
// //                           Radius.circular(20),
// //                         )),
// //                     suffixIcon: IconButton(
// //                         onPressed: () {
// //                           _textController.clear();
// //                         },
// //                         icon: const Icon(Icons.clear))),
// //                 obscureText: true,
// //                 maxLength: 20,
// //               ),
// //             ),
// //             ElevatedButton(
// //                 onPressed: () async {
// //                   // PlatformFile? _platformFile;
// //                   final file = await FilePicker.platform.pickFiles();
// //                   if (file != null) {
// //                         setState(() {
                          
// //                           Uint8List? uploadfile = file.files.single.bytes;
// //                           print(uploadfile);
// //                           _path = file.files.single.path;
// //                           print("here$_path");
// //                         });
                        
// //                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
// //                             backgroundColor: const Color.fromARGB(255, 16, 240, 23),
// //                             content: Text('File Selected\nFile path: $_path')));
// //                       } else {
// //                         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
// //                             backgroundColor: Color.fromARGB(255, 224, 5, 5),
// //                             content: Text('File not selected. Abort')));
// //                         print("abort");
// //                       }

// //                   // if (file != null) {
// //                   //   //String? selectedDirectory =
// //                   //   // (await FilePicker.platform.getDirectoryPath());
// //                   //   _platformFile = file.files.first;

// //                   //   pat = _platformFile.name;
// //                   //   _path = _platformFile.path;
// //                   //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
// //                   //       backgroundColor: const Color.fromARGB(255, 16, 240, 23),
// //                   //       content: Text(' File Selected\n File path:$_path')));
// //                   // } else {
// //                   //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
// //                   //       backgroundColor: Color.fromARGB(255, 224, 5, 5),
// //                   //       content: Text(' File not Selected.Abort')));
// //                   //   print("abort");
// //                   // }
// //                 },
// //                 child: const Text('add file',
// //                     style: TextStyle(fontSize: 22, color: Colors.white)),
// //                 style: ElevatedButton.styleFrom(
// //                   primary: Color(0xffee122a),
// //                   shape: const StadiumBorder(),
// //                 )),
// //             ElevatedButton(
// //                 child: const Text('Encrypt',
// //                     style: TextStyle(fontSize: 22, color: Colors.white)),
// //                 style: ElevatedButton.styleFrom(
// //                   primary: Colors.green,
// //                   shape: const StadiumBorder(),
// //                 ),
                
// //                 onPressed: () async {
// //                   setState(() {
// //                     _textController.text.isEmpty
// //                         ? _validate = true
// //                         : _validate = false;
// //                   });
// //                   if (_path != null && _textController.text != null) {
// //                     // print(_path);

// //                     // Creates an instance of AesCrypt class.
// //                     AesCrypt crypt = AesCrypt();

// //                     // Sets encryption password.
// //                     // Optionally you can specify the password when creating an instance
// //                     // of AesCrypt class like:
// //                     crypt.aesSetMode(AesMode.cbc);
// //                     crypt.setPassword(_textController.text);

// //                     // Sets overwrite mode.
// //                     // It's optional. By default the mode is 'AesCryptOwMode.warn'.
// //                     crypt.setOverwriteMode(AesCryptOwMode.rename);

// //                     try {
// //                       // Encrypts  file and save encrypted file to a file with
// //                       // '.aes' extension added. In this case it will be '$_path.aes'.
// //                       // It returns a path to encrypted file.

// //                       encFilepath = crypt.encryptFileSync(_path!);

// //                       print('The encryption has been completed successfully.');
// //                       print('Encrypted file: $encFilepath');
// //                       final newFile = await saveFile(encFilepath!);
// //                       //final newfile1 = await saveFile1(encFilepath!);
// //                       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
// //                           backgroundColor: Color.fromARGB(255, 16, 240, 23),
// //                           content: Text(' File Encryption Success')));
// //                       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
// //                           backgroundColor: Color.fromARGB(255, 16, 240, 23),
// //                           content: Text(' File Saved')));
// //                       print(newFile);
// //                       // print(newfile1);
// //                     } on AesCryptException catch (e) {
// //                       // It goes here if overwrite mode set as 'AesCryptFnMode.warn'
// //                       // and encrypted file already exists.
// //                       if (e.type == AesCryptExceptionType.destFileExists) {
// //                         print(
// //                             'The encryption has been completed unsuccessfully.');
// //                         print(e.message);
// //                       }
// //                     }
// //                   }
// //                   if (_path == null) {
// //                     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
// //                         backgroundColor: Colors.red,
// //                         content: Text('Please select file')));
// //                   }
// //                 }),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }










// // void main() {
// //   runApp(MaterialApp(
// //     title: 'My App',
// //     home: Directionality(
// //       textDirection: TextDirection.ltr,
// //       child: EncryptionPage(),
// //     ),
// //   ));

// // }
// class EncryptionPage extends StatefulWidget {
//   const EncryptionPage({Key? key}) : super(key: key);

//   @override
//   State<EncryptionPage> createState() => _EncryptionPageState();
// }

// class _EncryptionPageState extends State<EncryptionPage> {
//   Uint8List? fileAsB;
//   String? _path;
//   String? pat;
//   String? encFilepath;
//   String? filename;

//   Future<File> saveFilePermanently(PlatformFile file) async {
//     final appStorage = await getExternalStorageDirectory();
//     final newFile = File('${appStorage!.path}/${file.name}');
//     return File(file.path!).copy(newFile.path);
//   }

//   bool _validate = false;
//   @override
//   void dispose() {
//     _textController.dispose();
//     super.dispose();
//   }

//   Future<File> saveFile(String file) async {
//     Directory? appStorage = await getExternalStorageDirectory();
//     var fileName = (file.split('/').last);
//     final newfile = ('${appStorage!.path}/$fileName');

//     return File(file).copy(newfile);
//   }

//   Future<File> saveFile1(String file) async {
//     const appStorage = ('/storage/emulated/0/Download');
//     var fileName = (file.split('/').last);
//     final newfile = ('$appStorage/$fileName');

//     return (File(file).copy(newfile));
//   }

//   final _textController = TextEditingController();

//   Widget _buildLogo() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 15),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Text('Encryption',
//               style: TextStyle(
//                 fontSize: MediaQuery.of(context).size.height / 75,
//                 fontWeight: FontWeight.bold,
//                 color: const Color.fromARGB(255, 255, 255, 255),
//               )),
//         ],
//       ),
//     );
//   }

//   Widget _buildAddFileButton() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Container(
//           height: 1.4 * (MediaQuery.of(context).size.height / 20),
//           width: 1 * (MediaQuery.of(context).size.width / 10),
//           margin: const EdgeInsets.only(bottom: 20),
//           child: ElevatedButton(
//             onPressed: () async {
//               PlatformFile? _platformFile;
//               final file = await FilePicker.platform.pickFiles();
//               print(file);
              
//               print(fileAsB);

              
//               if (file != null) {
//                fileAsB = file.files.single.bytes;
//                 print("I am testing it$fileAsB");
//                 // _platformFile = file.files.first;
//                 // pat = _platformFile.name;
//                 // _path = _platformFile.path;
//                 // _path = file.files.single.path;

               
//                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                     backgroundColor: const Color(0xff006aff),
//                     content: Text(
//                       ' File Selected\n File path:$_path',
//                       textAlign: TextAlign.center,
//                     )));
//               } else {
//                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                     backgroundColor: Color(0xffee122a),
//                     content: Text(
//                       ' File not Selected.Abort',
//                       textAlign: TextAlign.center,
//                     )));
//                 print("abort");
//               }
//             },
//             style: ElevatedButton.styleFrom(
//               primary: const Color(0xffee122a),
//               shape: const StadiumBorder(),
//             ),
//             child: Text(
//               "Add File",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: const Color.fromARGB(255, 255, 255, 255),
//                 letterSpacing: 1.5,
//                 fontSize: MediaQuery.of(context).size.height / 40,
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }
//   Widget _buildEncryptButton() {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: <Widget>[
//       Container(
//         height: 1 * (MediaQuery.of(context).size.height / 20),
//         width: 1 * (MediaQuery.of(context).size.width / 10),
//         margin: const EdgeInsets.only(bottom: 20),
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: const Color(0xffee122a),
//             shape: const StadiumBorder(),
//           ),
//           onPressed: () async {
//             FocusScope.of(context).unfocus();
//             setState(() {
//               _textController.text.isEmpty
//                   ? _validate = true
//                   : _validate = false;
//             });
//             if (fileAsB != null && _textController.text.isNotEmpty) {
//               // Creates an instance of AesCrypt class.
//               AesCrypt crypt = AesCrypt();
//               // Sets encryption password.
//               crypt.aesSetMode(AesMode.cbc);
//               crypt.setPassword(_textController.text);
//               print(_textController.text);

//               // Sets overwrite mode.
//               crypt.setOverwriteMode(AesCryptOwMode.rename);

//               try {
//                 // Encrypts file data and returns the encrypted bytes.
//                 // var pat = Uint8List.fromList(fileAsB!);
//                 String encryptedFileData = crypt.encryptDataToFileSync(Uint8List.fromList(fileAsB!),'notes.txt.aes');

//                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                     backgroundColor: Color(0xff006aff),
//                     content: Text(
//                       ' File Encryption Success',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                           color: Colors.white, fontWeight: FontWeight.bold),
//                     )));

//                 // TODO: Do something with the encrypted file data.
//                 // For example, you can save it to a file using the
//                 // `writeAsBytes` method of the `File` class.

//               } on AesCryptException catch (e) {
//                 if (e.type == AesCryptExceptionType.destFileExists) {
//                     print('The encryption has been completed unsuccessfully.');
//                     print(e.message);
//                   }
//                 // Handle any exceptions that may occur during encryption.
//               }
//             } else {
//               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                   backgroundColor: Color(0xffee122a),
//                   content: Text(
//                     'Please select file',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                         color: Colors.white, fontWeight: FontWeight.bold),
//                   )));
//             }
//             setState(() {
//               _textController.clear();
//             });
//           },
//           child: Text(
//             "Encrypt",
//           ),
//         ),
//       )
//     ],
//   );
// }

//   // Widget _buildEncryptButton() {
//   //   return Row(
//   //     mainAxisAlignment: MainAxisAlignment.center,
//   //     children: <Widget>[
//   //       Container(
//   //         height: 1 * (MediaQuery.of(context).size.height / 20),
//   //         width: 1 * (MediaQuery.of(context).size.width / 10),
//   //         margin: const EdgeInsets.only(bottom: 20),
//   //         child: ElevatedButton(
//   //           style: ElevatedButton.styleFrom(
//   //             backgroundColor: const Color(0xffee122a),
//   //             shape: const StadiumBorder(),
//   //           ),
//   //           onPressed: () async {
//   //             FocusScope.of(context).unfocus();
//   //             setState(() {
//   //               _textController.text.isEmpty
//   //                   ? _validate = true
//   //                   : _validate = false;
//   //             });
//   //             if (fileAsB != null) {
//   //               // print(_path);

//   //               // Creates an instance of AesCrypt class.
//   //               AesCrypt crypt = AesCrypt();

//   //               // Sets encryption password.
//   //               // Optionally you can specify the password when creating an instance
//   //               // of AesCrypt class like:
//   //               crypt.aesSetMode(AesMode.cbc);
//   //               crypt.setPassword(_textController.text);

//   //               // Sets overwrite mode.
//   //               // It's optional. By default the mode is 'AesCryptOwMode.warn'.
//   //               crypt.setOverwriteMode(AesCryptOwMode.rename);

//   //               try {
//   //                 // Encrypts  file and save encrypted file to a file with
//   //                 // '.aes' extension added. In this case it will be '$_path.aes'.
//   //                 // It returns a path to encrypted file.

//   //                 // encFilepath = crypt.encryptFileSync(_path!);
//   //                 print('here');
//   //                 var encFileBytes = crypt.encryptDataToFileSync(fileAsB!,'notes.txt.aes');
//   //                 print(encFileBytes);
//   //                 print('The encryption has been completed successfully.');
//   //                 print('Encrypted file: $encFilepath');
//   //                 // final newFile = await saveFile(encFilepath!);
//   //                 //final newfile1 = await saveFile1(encFilepath!);
//   //                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//   //                     backgroundColor: Color(0xff006aff),
//   //                     content: Text(
//   //                       ' File Encryption Success',
//   //                       textAlign: TextAlign.center,
//   //                       style: TextStyle(
//   //                           color: Colors.white, fontWeight: FontWeight.bold),
//   //                     )));
//   //                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//   //                     backgroundColor: Color(0xff006aff),
//   //                     content: Text(
//   //                       ' File Saved',
//   //                       textAlign: TextAlign.center,
//   //                       style: TextStyle(
//   //                           color: Colors.white, fontWeight: FontWeight.bold),
//   //                     )));
//   //                 print(encFileBytes);
//   //                 // print(newfile1);
//   //               } on AesCryptException catch (e) {
//   //                 // It goes here if overwrite mode set as 'AesCryptFnMode.warn'
//   //                 // and encrypted file already exists.
//   //                 if (e.type == AesCryptExceptionType.destFileExists) {
//   //                   print('The encryption has been completed unsuccessfully.');
//   //                   print(e.message);
//   //                 }
//   //               }
//   //             }
//   //             if (fileAsB == null) {
//   //               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//   //                   backgroundColor: Color(0xffee122a),
//   //                   content: Text(
//   //                     'Please select file',
//   //                     textAlign: TextAlign.center,
//   //                     style: TextStyle(
//   //                         color: Colors.white, fontWeight: FontWeight.bold),
//   //                   )));
//   //             }
//   //             setState(() {
//   //               _textController.clear();
//   //             });
//   //           },
//   //           child: Text(
//   //             "Encrypt"
//   //             // style: GoogleFonts.poppins(
//   //             //     color: const Color.fromARGB(255, 255, 255, 255),
//   //             //     letterSpacing: 1.5,
//   //             //     fontSize: MediaQuery.of(context).size.height / 40,
//   //             //     fontWeight: FontWeight.bold),
//   //           ),
//   //         ),
//   //       )
//   //     ],
//   //   );
//   // }

//   Widget _buildPasswordRow() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
//       child: TextField(
//         controller: _textController,
//         textAlign: TextAlign.center,
//         decoration: InputDecoration(
//           errorText: _validate ? 'please enter password' : null,
//           focusedBorder: const OutlineInputBorder(
//             borderSide: BorderSide(color: Color(0xffee122a), width: 2.0),
//           ),
//           enabledBorder: const OutlineInputBorder(
//               borderSide: BorderSide(color: Color(0xffee122a), width: 1.5)),
//           hintText: "Enter password",
//         ),
//         obscureText: true,
//       ),
//     );
//   }

//   Widget _buildContainer() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         ClipRRect(
//           borderRadius: const BorderRadius.all(Radius.circular(20)),
//           child: Container(
//             height: MediaQuery.of(context).size.width * 0.3,
//             width: MediaQuery.of(context).size.width * 0.5,
//             decoration: const BoxDecoration(
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey,
//                   spreadRadius: 10,
//                   blurRadius: 100,
//                   offset: Offset(20, 20), // changes position of shadow
//                 ),
//               ],
//               color: Color(0xff282828),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 _buildPasswordRow(),
//                 _buildAddFileButton(),
//                 _buildEncryptButton(),
//                  Builder(
//                   builder: (context) => ElevatedButton(
//                     onPressed: (){
//                       Navigator.of(context).pop();
//                     }, 
//                     child: Text("Back to HomePage") ) 
//                 )
//               ],
//             ),
//           ),
//         )
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     //return SafeArea(
//     //child:
//     return GestureDetector(
//       onTap: () {
//         FocusManager.instance.primaryFocus?.unfocus();
//       },
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: Stack(
//           children: <Widget>[
//             Container(
//                 height: MediaQuery.of(context).size.height * 0.53,
//                 width: MediaQuery.of(context).size.width,
//                 child: Container(
//                   decoration: const BoxDecoration(
//                       color: Color(0xffee122a),
//                       borderRadius: BorderRadius.only(
//                           // bottomLeft: Radius.circular(70),
//                           // bottomRight: Radius.circular(70),
//                           )),
//                 )),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 _buildLogo(),
//                 _buildContainer()
               
//               ],
//             )
//           ],
//         ),
//       ),
//       // ),
//     );
//   }
// }
