
import 'dart:io';

import 'package:get/get.dart';
import 'package:history_app/consts/consts.dart';
import 'package:history_app/controllers/profile_controller.dart';
import 'package:history_app/widgets_common/bg_widget.dart';
import 'package:history_app/widgets_common/custom_textfild.dart';
import 'package:history_app/widgets_common/our_button.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({super.key,this.data });

  @override
  Widget build(BuildContext context) {
    var controller =   Get.find<ProfileController>();


    return bgWidget(Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        elevation: 0,
      ),
       body: Obx(()=>
    Column(
          mainAxisSize: MainAxisSize.min,
          children: [
       
       
       // if data image url and data controller path is empty 
      data['imageUrl'] == '' &&  controller.profileImgPath.isEmpty
       ?
         Image.asset(
                    imgProfile2,
                    width: 100,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make()
                  // if data is not empty but controlleer is empty to showing this data 
                  :
                  data['imageUrl'] != '' && controller.profileImgPath.isEmpty
                  ?
                   Image.network(data['imageUrl'] ,  width: 70,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make()
                   // if both are empty to showing this 
                   :
              Image.file(File(controller.profileImgPath.value),
              width: 60,fit: BoxFit.cover,
       
              ).box.roundedFull.clip(Clip.antiAlias).make(),
       
       
       
       
                  10.heightBox,
                  ourButton(
                    color: redColor,onPress: (){
                      controller.changeImage(context);
                      
                    
                    },textColor: whiteColor,title: "Change"
                  ),
       
                  Divider(),
                  
                  20.heightBox,
                  customTextField(
                    hint: nameHint,
                  title: name,
                  isPass: false,
                  controller: controller.nameController
                  
                  ), 10.heightBox,
                  customTextField(
                    hint: passwordHint,
                  title: oldpass,
                  isPass: true, 
                  controller: controller.oldpassController),
                  10.heightBox,

                   customTextField(
                    hint: passwordHint,
                  title: newpass,
                  isPass: true, 
                  controller: controller.newpassController),
                  20.heightBox,

                controller.isloading.value? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ):   
                 SizedBox(
                      width: context.screenWidth -60,
                      child: ourButton(
                      color: redColor,onPress: ()async{
                        // controller.isloading(true);
                        // await controller.uplodProfileImage();
                        // await controller.updateProfile(
                        //   imgUrl:  controller.profileImageLink,
                        //   name: controller.nameController.text,
                        //   password: controller.newpassController.text
                        // );
                        // VxToast.show(context, msg: "Updated");




                        controller.isloading(true);
                        // if image is not updated 
                        if(controller.profileImgPath.value.isNotEmpty){
                           await controller.uplodProfileImage();

                        }else{
                          controller.profileImageLink = data['imageUrl'];
                        }
                        // if old password matches database 
                        if(data['password'] == controller.oldpassController.text){

                            await controller.changeAuthPassword(
                              email: data['email'],
                              password: controller.oldpassController.text,
                              newpassword: controller.newpassController.text
                            );


                            await controller.updateProfile(imgUrl: controller.profileImageLink,
                       name:  controller.nameController.text,
                       password: controller.newpassController.text
                       );
                       VxToast.show(context, msg: "Update");

                        }else{
                          VxToast.show(context, msg: "Wrong old password");
                          controller.isloading(false);


                        }

                      
                     

                      },textColor: whiteColor,title: "Save"
                                    ),
                    ),
       
         ],).box.white.shadowSm.padding(EdgeInsets.all(16)).margin(EdgeInsets.only(top: 50,left: 12,right: 12)).rounded.make(),
       ),
    ));
  }
}
