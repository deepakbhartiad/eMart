import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:history_app/consts/consts.dart';
import 'package:history_app/controllers/cart_controller.dart';
import 'package:history_app/servicess/firestore_servicess.dart';
import 'package:history_app/widgets_common/loading_indicator.dart';
import 'package:history_app/widgets_common/our_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
     var controller = Get.put(CartController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: "Shopping cart".text.color(darkFontGrey).fontFamily(semibold).make()),
      body: StreamBuilder(
        stream: FirestoreServices.getCart(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(child: loadingIndicator(),);
          }else if(snapshot.data!.docs.isEmpty){
            return Center(child: "No Data".text.make(),);
          }else{
            var data = snapshot.data!.docs;
            controller.calculate(data);
           
            return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Expanded(
            
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context,int index){
              return ListTile(leading: Image.network(data[index]['img']),
              title: "${data[index]['title']} (x${data[index]['qty']})".text.fontFamily(semibold).size(16).make(),
              subtitle: "${data[index]['tprice']}".numCurrency.text.size(14).fontFamily(semibold).color(redColor).make(),
              trailing: Icon(Icons.delete,color: redColor,).onTap(() { 
                //remove product
                FirestoreServices.deleteDocument(data[index].id);


              }),
              ) ;
            })),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              "Total price".text.fontFamily(semibold).color(darkFontGrey).make(),
              Obx(()=> "${controller.totalP.value}".numCurrency.text.fontFamily(semibold).color(redColor).make()),
            ],
          ).box.padding(EdgeInsets.all(12)).width(context.screenWidth-60).color(lightGolden).roundedSM.make(),
          10.heightBox,
          SizedBox(
            width: context.screenHeight-60,
            child: ourButton(
              color: redColor,onPress: (){},textColor: whiteColor,title: "Proceed to shipping"
            ))
        ],),
      );
          }

        },
      )
    );
  }
}
