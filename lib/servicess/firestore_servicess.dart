import 'package:history_app/consts/consts.dart';
import 'package:history_app/models/category_model.dart';
// get users data 
class FirestoreServices{
  static getUser(uid){
    return firestore.collection(usersCollections).where('id',isEqualTo: uid).snapshots();

  }

  // get products according to category


static getProduct(category){
  return firestore.collection(productsCollection).where('p_category',isEqualTo: category).snapshots();
  
}


}