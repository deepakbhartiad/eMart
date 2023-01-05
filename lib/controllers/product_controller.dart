import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:history_app/consts/consts.dart';
import 'package:history_app/models/category_model.dart';

class ProductController extends GetxController{
  // increase quantity 
  var quantity = 0.obs;
  // collor select index check mark
  var colorIndex = 0.obs;
  // total price sho on add and multiply
  var totalPrice = 0.obs;

var subCat = [];
getSubCtegories(title)async{  /// this is a method
  subCat.clear();     

var data = await rootBundle.loadString("lib/servicess/category_model.json");
var decoded = categoryModelFromJson(data);
var s = decoded.categories.where((element) => element.name == title).toList();
for(var e in s[0].subcategory){
  subCat.add(e);
};


}
// chenge color method 
changeColorIndex(index){
  colorIndex = index;

}

// increse quantity method
increaseQuantity(totalQuantity){
  if(quantity.value < totalQuantity){
quantity.value++;
  }

  

}

decreseQuantity(){
  if(quantity.value > 0){
    quantity.value--;
  }
}



// culculate price method
culculateTotalPrice(price){
  totalPrice.value = price * quantity.value;

}
// to add new collectin firebase store and add this data in your phone
adToCart({title,img,seller,color,qty,tprice,context})async{
  await firestore.collection(cartCollection).doc().set({
'title':title,
'img':img,
'seller':seller,
'color':color,
'qty':qty,
'tprice':tprice,
'added_by': currentUser!.uid
  }).catchError((error){
    VxToast.show(context, msg: error.toString());
  });

}

// reset price values in item cart
resetValue(){
  totalPrice.value = 0;
  quantity.value = 0;
  colorIndex.value = 0;
}



}