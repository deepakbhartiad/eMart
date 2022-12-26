import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:history_app/consts/consts.dart';
import 'package:history_app/consts/list.dart';
import 'package:history_app/controllers/auth_controller.dart';
import 'package:history_app/controllers/profile_controller.dart';
import 'package:history_app/servicess/firestore_servicess.dart';
import 'package:history_app/views/auth_screen/login_screen.dart';
import 'package:history_app/widgets_common/bg_widget.dart';

import 'components/details_cart.dart';
import 'edit_orifile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return bgWidget(Scaffold(
      body: StreamBuilder(
        stream:  FirestoreServices.getUser(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(child:
             CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor)),);
          }else{
            var data = snapshot.data!.docs[0];

            return SafeArea(
          child: Column(
        children: [
          /// edit profile button

          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.edit,
                  color: whiteColor,
                )).onTap(
                  
                  () {
                    controller.nameController.text = data['name'];
                    controller.passController.text = data['password'];     
                    Get.to(()=>EditProfileScreen(data: data));}),),

          /// user details sections
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [

                data['imageUrl'] == ''?
                Image.asset(
                  imgProfile2,
                  width: 100,
                  fit: BoxFit.cover,
                ).box.roundedFull.clip(Clip.antiAlias).make():
                Image.network(
                  data['imageUrl'],
                  width: 100,
                  fit: BoxFit.cover,
                ).box.roundedFull.clip(Clip.antiAlias).make(),
                10.widthBox,
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "${data['name']}".text.fontFamily(semibold).white.make(),
                    "${data['email']}".text.white.make(),
                  ],
                )),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(color: whiteColor)),
                    onPressed: () async {
                     await Get.put(AuthController()).signoutMethod(context);
                      Get.offAll(() => LoginScreen());
                    },
                    child: logout.text.fontFamily(semibold).white.make())
              ],
            ),
          ),
          10.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              dtailsCart(
                  count: data['cart_count'],
                  title: "your cart",
                  width: context.screenWidth / 3.4),
              dtailsCart(
                  count: data['wishlist_count'],
                  title: "your whishlist",
                  width: context.screenWidth / 3.4),
              dtailsCart(
                  count: data['order_count'],
                  title: "your order",
                  width: context.screenWidth / 3.4),
            ],
          ),
          // buttons sections

          ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: lightGrey,
                    );
                  },
                  itemCount: profileButtonsList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Image.asset(
                        profileButtonsIcons[index],
                        width: 22,
                      ),
                      title: "${profileButtonsList[index]}"
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                    );
                  })
              .box
              .white
              .rounded
              .margin(EdgeInsets.all(12))
              .padding(EdgeInsets.symmetric(horizontal: 16))
              .shadowSm
              .make()
              .box
              .color(redColor)
              .make()
        ],
      ));

          }
         
        },
     
      )
    ));
  }
}
