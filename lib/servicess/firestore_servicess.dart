import 'package:history_app/consts/consts.dart';
// get users data 
class FirestoreServices{
  static getUser(uid){
    return firestore.collection(usersCollections).where('id',isEqualTo: uid).snapshots();

  }
}