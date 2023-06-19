/*
There is no extra configuration required to use Google Sign-In on an Android device. But to use it on an iOS device, you have to do just one more thing.

Go to your project directory -> ios -> Runner -> Info.plist file, and add the following there:


<!-- Put me in the [my_project]/ios/Runner/Info.plist file -->
<!-- Google Sign-In section -->
<key>CFBundleURLTypes</key>
<array>
	<dict>
		<key>CFBundleTypeRole</key>
		<string>Editor</string>
		<key>CFBundleURLSchemes</key>
		<array>
			<!-- Replace this value: -->
			<!-- Copied from GoogleService-Info.plist key REVERSED_CLIENT_ID -->
			<string>com.googleusercontent.apps.861823949799-vc35cprkp249096uujjn0vvnmcvjppkn</string>
		</array>
	</dict>
</array>
<!-- End of the Google Sign-In section -->
Don’t forget to replace the value as per the above comment with the REVERSED_CLIENT_ID present in the GoogleService-Info.plist file.

Initialize Firebase


Project public-facing name
project-544064451115


Web SDK configuration
Web client ID
544064451115-qh1g6en5nj0mvn06cmg7f0jfbujgtnm6.apps.googleusercontent.com
Web client secret
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
*/

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth {
  static Future<UserCredential?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        return userCredential;
      } on FirebaseAuthException {
        return null;
      }
        // if (e.code == 'account-exists-with-different-credential') {
        //   // handle the error here
        // }
        // else if (e.code == 'invalid-credential') {
        //   // handle the error here
        // }
    }
    else {
      return null;
    }
  }
}
