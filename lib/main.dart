import 'package:flutter/material.dart';
import '/pages/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

/*
dart pub global activate flutter_cli
flutter pub add firebase_auth firebase_core cloud_firestore google_sign_in
*/

/*
Enter keystore password: android
Alias name: androiddebugkey
Creation date: 01-Jan-2022
Entry type: PrivateKeyEntry
Certificate chain length: 1
Certificate[1]:
Owner: C=US, O=Android, CN=Android Debug
Issuer: C=US, O=Android, CN=Android Debug
Serial number: 1
Valid from: Sat Jan 01 20:44:53 IST 2022 until: Mon Dec 25 20:44:53 IST 2051
Certificate fingerprints:
         SHA1: 08:50:88:2B:A0:82:D3:C2:B5:09:D0:90:B4:67:58:2A:98:CA:6D:EF
         SHA256: 39:A3:E6:34:CD:73:CA:CC:E5:24:B0:FC:0B:E4:B8:AE:90:00:81:CC:D4:32:19:58:D3:BC:ED:33:71:BD:D7:0C
Signature algorithm name: SHA1withRSA (weak)
Subject Public Key Algorithm: 2048-bit RSA key
*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}
