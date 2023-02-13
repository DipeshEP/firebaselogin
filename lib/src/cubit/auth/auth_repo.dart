import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo{
  loginWithEmailPassword(String email, String password)async{
    try{
      UserCredential userCredential=await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      print(userCredential.user!.email);
      return userCredential;
    }catch(ex){
      throw Exception(ex);
    }
  }
  registerWithEmailPassword(String email, String password)async{
    UserCredential userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }
}