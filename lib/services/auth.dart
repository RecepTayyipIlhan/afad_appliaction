import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?>signIn(String email, String password)async{
    var user = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return user.user;

  }
  signOut()async{
    return await _auth.signOut();
  }

  Future<User?> createPerson(String name,String surname, String email, String password, String phone)async{
    var user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    await _firestore
    .collection("user")
    .doc(user.user?.uid)
    .set({
      'name': name,
      'surname':surname,
      'email':email,
      'password':password,
      'phone' : phone,
    });
    return user.user;

  }



}