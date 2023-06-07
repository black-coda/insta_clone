// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:insta_clone/state/auth/constant/konstants.dart';
import 'package:insta_clone/state/auth/models/auth_result.dart';
import 'package:insta_clone/state/post/typedef/user_is.dart';

class Authenticator {
  const Authenticator();
  UserId? get userId => FirebaseAuth.instance.currentUser?.uid;
  bool get isAlreadyLoggedIn => userId != null;

  String get displayName =>
      FirebaseAuth.instance.currentUser?.displayName ?? "";

  String? get email => FirebaseAuth.instance.currentUser?.email;

  //* Logout Functionality
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
  }

  //*Login Functionality

  Future<AuthResult> loginWithFacebook() async {
    final loginResult = await FacebookAuth.instance.login();

    //To check if user is login, we have to check the token

    final accessToken = loginResult.accessToken?.token;
    if (accessToken == null) {
      // User has aborted the logging in process
      return AuthResult.aborted;
    }

    //? Oauth credential gotten from facebook must be passed to
    //? Firebase, so as to login to the firebase

    final oauthCredential = FacebookAuthProvider.credential(accessToken);

    try {
      await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      return AuthResult.success;
    } on FirebaseAuthException catch (e) {
      final email = e.email;
      final credential = e.credential;

      if (e.code == AuthKonstant.accountExistsWithDifferentCredential &&
          email != null &&
          credential == null) {
        final providers =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

        if (providers.contains(AuthKonstant.googleCom)) {
          await loginWithGoogle();

          FirebaseAuth.instance.currentUser?.linkWithCredential(credential!);
        }
        return AuthResult.success;
      }
      return AuthResult.failure;
    }
  }

  //? Login with google credential

  Future<AuthResult> loginWithGoogle() async {
    //?   Creates a GoogleSignIn object with the email scope.

    final GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
      AuthKonstant.emailScope,
    ]);

    //?   Waits for the user to sign in with their Google account.
    final signInAccount = await googleSignIn.signIn();

    //?   If the sign-in process is canceled, returns an AuthResult object with a value of aborted.
    if (signInAccount == null) {
      return AuthResult.aborted;
    }

    //? Gets the authentication data from the signed-in Google account.
    //? which will retrieve the authentication token after sign in.
    final googleAuth = await signInAccount.authentication;

    //? Uses the GoogleAuthProvider.credential method to create a OAuthCredential
    //? object
    //? with the access token and ID token from the authentication data.
    final oauthCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    //? Uses the signInWithCredential method from the FirebaseAuth class to sign
    //? in the user with the OAuth credential.
    try {
      await FirebaseAuth.instance.signInWithCredential(oauthCredential);

      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
  }
}
