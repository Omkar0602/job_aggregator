import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> _signInWithGoogle() async {
    try {
      // Trigger the Google Authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // If the user cancels the sign-in
        return null;
      }

      // Obtain the Google Sign-In authentication details
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential for Firebase
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google user credentials
      final UserCredential userCredential = await _auth.signInWithCredential(credential);

      // Return the Firebase user
      return userCredential.user;
    } catch (e) {
      print("Error during Google Sign-In: $e");
      return null;
    }
  }

  void _signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    print("User Signed Out");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Sign-In'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                User? user = await _signInWithGoogle();
                if (user != null) {
                  // Navigate to the HomeScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen(user: user)),
                  );
                }
              },
              child: Text('Sign in with Google'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signOut,
              child: Text('Sign out'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final User user;

  HomeScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, ${user.displayName}'),
            SizedBox(height: 20),
            CircleAvatar(
              backgroundImage: NetworkImage(user.photoURL ?? ''),
              radius: 40,
            ),
          ],
        ),
      ),
    );
  }
}
