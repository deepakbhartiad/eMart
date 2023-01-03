import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:history_app/consts/consts.dart';
import 'package:history_app/servicess/firestore_servicess.dart';
import 'package:history_app/views/category_screen/items_dtails.dart';
import 'package:history_app/widgets_common/bg_widget.dart';

import '../../controllers/product_controller.dart';
import '../../widgets_common/loading_indicator.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;
  const CategoryDetails({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return bgWidget(Scaffold(
      appBar: AppBar(
        title: title!.text.fontFamily(bold).white.make(),
        elevation: 0,
      ),
      body: StreamBuilder(stream: FirestoreServices.getProduct(title),
      builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
        if(!snapshot.hasData){
          return Center(child: loadingIndicator(),);
        }else if(snapshot.data!.docs.isEmpty){
          return Center(child: "No products found!".text.color(darkFontGrey).make(),);
        }else{


          var data = snapshot.data!.docs;
          return  Container(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                  controller.subCat.length,
                  (index) => "${controller.subCat[index]}"
                      .text
                      .fontFamily(semibold)
                      .size(12)
                      .color(darkFontGrey)
                      .makeCentered()
                      .box
                      .rounded
                      .white
                      .size(120, 60)
                      .margin(EdgeInsets.symmetric(horizontal: 4))
                      .make()),
            ),
          ),
          // items containers
          20.heightBox,
          Expanded(
            child: GridView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 250,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8),
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        data[index]['p_imgs'][0],
                        width: 200,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                      "${data[index]['p_name']}"
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      10.heightBox,
                      "${data[index]['p_price']}".numCurrency
                          .text
                          .color(redColor)
                          .fontFamily(bold)
                          .size(16)
                          .make(),
                    ],
                  )
                      .box
                      .margin(EdgeInsets.symmetric(horizontal: 5))
                      .white
                      .outerShadowSm
                      .roundedSM
                      .padding(const EdgeInsets.all(12))
                      .make()
                      .onTap(() {
                    Get.to(() => ItemDetails(title: "${data[index]['p_name']}",data: data[index],));
                  });
                }),
          )
        ]),
      );
    
        }
      },
      )
    ));
  }
}
