import 'package:ed_tool_fronend/decryption.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'encryption.dart';
import 'login.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final Box _boxLogin = Hive.box("login");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login App"),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white),
              ),
              child: IconButton(
                onPressed: () {
                  _boxLogin.clear();
                  _boxLogin.put("loginStatus", false);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const Login();
                      },
                    ),
                  );
                },
                icon: const Icon(Icons.logout_rounded),
              ),
            ),
          )
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome 🎉\n Please choose what you want to do",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 10),
            // Text(
            //   // _boxLogin.get("userName"),
            //   style: Theme.of(context).textTheme.headlineLarge,
            // ),
            Padding(padding:EdgeInsets.only(left: 100),
            child :Row(
               mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Builder(
                builder: (context) =>ElevatedButton(
                // onPressed: Navigator.of(context).push(EncryptionPage()),
                onPressed: (){
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => EncryptionPage()));
                },
                child: Text('Encryption'
                ,))),
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
              ],))
             
          ],
        ),
      ),
    );
  }
}
