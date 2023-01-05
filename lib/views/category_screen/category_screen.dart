import 'package:get/get.dart';
import 'package:history_app/consts/consts.dart';
import 'package:history_app/consts/list.dart';
import 'package:history_app/widgets_common/bg_widget.dart';

import '../../controllers/product_controller.dart';
import 'categories_details.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {

var controller = Get.put(ProductController());



    return bgWidget(Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
          elevation: 0, title: "Categories".text.fontFamily(bold).white.make()),
      body: Container(
        padding: EdgeInsets.all(12),
        child: GridView.builder(
            shrinkWrap: true,
            itemCount: 9,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 200,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Image.asset(
                    categoriesImages[index],
                    height: 130,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                  10.heightBox,
                  "${categoriesList[index]}"
                      .text
                      .color(darkFontGrey)
                      .align(TextAlign.center)
                      .make()
                ],
              )
                  .box
                  .white
                  .rounded
                  .clip(Clip.antiAlias)
                  .outerShadowSm
                  .make()
                  .onTap(() {
                    controller.getSubCtegories(categoriesList[index]);
                Get.to(() => CategoryDetails(
                      title: categoriesList[index],
                    ));
              });
            }),
      ),
    ));
  }
}
