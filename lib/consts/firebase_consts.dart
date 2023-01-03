import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// use for authentication .....
FirebaseAuth auth = FirebaseAuth.instance;
// use for cloud store data enter and get .....
FirebaseFirestore firestore = FirebaseFirestore.instance;
// for use get data to login user .....
User? currentUser = auth.currentUser;

//// collection

const usersCollections = "users";


const productsCollection = "products";