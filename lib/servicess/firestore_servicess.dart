import 'package:history_app/consts/consts.dart';
// get users data 
class FirestoreServices{
  static getUser(uid){
    return firestore.collection(usersCollections).where('id',isEqualTo: uid).snapshots();

  }

  // get products according to category


static getProduct(category){
  return firestore.collection(productsCollection).where('p_category',isEqualTo: category).snapshots();
  
}


// get cart or create stream
static getCart(uid){
  return firestore.collection(cartCollection).where('added_by',isEqualTo: uid).snapshots();
}

// delete document
static deleteDocument(docId){
  return firestore.collection(cartCollection).doc(docId).delete();
}

}