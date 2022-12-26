import 'package:history_app/consts/consts.dart';

Widget dtailsCart({width, String? count, String? title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold).size(16).color(darkFontGrey).makeCentered(),
      5.heightBox,
      title!.text.color(darkFontGrey).makeCentered(),
    ],
  )
      .box
      .white
      .rounded
      .white
      .width(width)
      .height(80)
      .padding(EdgeInsets.all(4))
      .make();
}
