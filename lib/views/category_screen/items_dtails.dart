import 'package:get/get.dart';
import 'package:history_app/consts/consts.dart';
import 'package:history_app/consts/list.dart';
import 'package:history_app/controllers/product_controller.dart';
import 'package:history_app/widgets_common/our_button.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemDetails({Key? key, required this.title,required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        title: title!.text.color(darkFontGrey).fontFamily(semibold).make(),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.share,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite_outline,
              ))
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(8),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // swiper section
                VxSwiper.builder(
                  viewportFraction: 1.0,
                  autoPlay: true,
                  height: 350,
                  aspectRatio: 25 / 9,
                  itemCount: data['p_imgs'].length,
                  itemBuilder: ((context, index) {
                    return Image.network(
                      data['p_imgs'][index],
                      width: double.infinity,
                      fit: BoxFit.cover,
                    );
                  }),
                ),
                10.heightBox,
                // title and details screen
                title!.text
                    .size(16)
                    .color(darkFontGrey)
                    .fontFamily(bold)
                    .make(),
                10.heightBox,
                // rating
                VxRating(
                  isSelectable: false,
                  value: double.parse(data['p_rating']),
                  onRatingUpdate: (value) {},
                  normalColor: textfieldGrey,
                  selectionColor: golden,
                  size: 25,
                  count: 5,
                 maxRating: 5,
                ),
                10.heightBox,
                "${data['p_price']}".numCurrency.text.color(redColor).fontFamily(bold).make(),
                10.heightBox,
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Seller".text.white.fontFamily(semibold).make(),
                        5.heightBox,
                        "${data['p_seller']}"
                            .text
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .size(16)
                            .make()
                      ],
                    )),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.message_rounded,
                        color: darkFontGrey,
                      ),
                    )
                  ],
                )
                    .box
                    .height(60)
                    .padding(EdgeInsets.symmetric(horizontal: 16))
                    .color(textfieldGrey)
                    .make(),
                // COLORS sECTIONS
                20.heightBox,
                Obx(()=>
                   Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: "Color: ".text.color(textfieldGrey).make(),
                          ),
                          Row(
                            children: List.generate(
                                data["p_colors"].length,
                                (index) => Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    VxBox()
                                        .size(40, 40)
                                        .roundedFull
                                        .color(Color(data["p_colors"][index]).withOpacity(0.7))
                                        .margin(EdgeInsets.symmetric(horizontal: 4))
                                        .make().onTap(() {
                                          controller.changeColorIndex(index);
                                        }),
                                        Visibility(
                                          visible: index == controller.colorIndex.value,
                                          child:                                        
                                        Icon(Icons.done,color: Colors.white,)
                                        
                                        )
                
                
                                  ],
                                )),
                          )
                        ],
                      ).box.padding(EdgeInsets.all(8)).make(),
                
                      // Quantity row
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: "Quantity: ".text.color(textfieldGrey).make(),
                          ),
                          Obx(()=>
                            Row(
                              children: [
                              IconButton(
                                  onPressed: () {
                                    controller.decreseQuantity();

                                    controller.culculateTotalPrice(int.parse(data['p_price']));
                                    
                                  }, icon: Icon(Icons.remove)),
                              controller.quantity.value
                                  .text
                                  .size(16)
                                  .color(darkFontGrey)
                                  .fontFamily(bold)
                                  .make(),
                              IconButton(onPressed: () {
                                 controller.increaseQuantity(int.parse(data['p_quantity']));
                                 controller.culculateTotalPrice(int.parse(data['p_price']));

                                 }, icon: Icon(Icons.add)),
                              "(${data['p_quantity']} available)".text.color(textfieldGrey).make(),
                            ]),
                          ),
                        ],
                      ).box.padding(EdgeInsets.all(8)).make(),
                      //  total row
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: "Total: ".text.color(textfieldGrey).make(),
                          ),
                          "${controller.totalPrice.value}".numCurrency
                              .text
                              .color(redColor)
                              .size(16)
                              .fontFamily(bold)
                              .make()
                        ],
                      ).box.padding(EdgeInsets.all(8)).make()
                    ],
                  ).box.white.shadowSm.make(),
                ),
                // description sections
                10.heightBox,
                "Description"
                    .text
                    .color(darkFontGrey)
                    .fontFamily(semibold)
                    .make(),
                10.heightBox,
                "${data['p_desc']}"
                    .text
                    .color(darkFontGrey)
                    .make(),
                // buttons section
                10.heightBox,
                ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(
                      itemDetailButtonsList.length,
                      (index) => ListTile(
                            title: "${itemDetailButtonsList[index]}"
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                            trailing: Icon(Icons.arrow_forward),
                          )),
                ),
                20.heightBox,

                /// product may like sections
                productyoumaylikes.text
                    .fontFamily(bold)
                    .size(16)
                    .color(darkFontGrey)
                    .make(),
                10.heightBox,
                // i copied this widgets from home_screen feauture products
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                        6,
                        (index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  imgP1,
                                  width: 130,
                                  fit: BoxFit.cover,
                                ),
                                10.heightBox,
                                "Laptop 4GB/64GB"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                10.heightBox,
                                "\$600"
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
                                .roundedSM
                                .padding(const EdgeInsets.all(8))
                                .make()),
                  ),
                )
                // heare our details UI is also completed.....
              ],
            )),
          )),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ourButton(
                color: redColor,
                onPress: () {},
                textColor: whiteColor,
                title: "Add to Cart"),
          )
        ],
      ),
    );
  }
}
