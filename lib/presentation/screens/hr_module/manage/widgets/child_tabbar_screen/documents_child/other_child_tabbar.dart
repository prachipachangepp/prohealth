import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/hr_resources/string_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/documents_child/widgets/other_popup.dart';
import 'package:prohealth/presentation/widgets/widgets/custom_icon_button_constant.dart';

import '../../../../../../../../app/resources/theme_manager.dart';
class OtherChildTabbar extends StatefulWidget {
  const OtherChildTabbar({super.key});

  @override
  State<OtherChildTabbar> createState() => _OtherChildTabbarState();
}

class _OtherChildTabbarState extends State<OtherChildTabbar> {
  TextEditingController otherEditIdController = TextEditingController();
  TextEditingController otherEditNameController = TextEditingController();
  TextEditingController otherAddIdController = TextEditingController();
  TextEditingController otherAddNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              // width: 100,
              margin: EdgeInsets.only(right: 60),
              child: CustomIconButtonConst(
                  text: AppStringHr.addNew,
                  icon: Icons.add,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return OtherEditAddPopup(
                              idController: otherAddIdController,
                              nameController: otherAddNameController,
                              labelName: 'Add');
                        });
                  }),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: MediaQuery.of(context).size.height/1,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.only(top: 5,bottom:5, left: 10,right: 100),
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    decoration: BoxDecoration(
                      color:Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.25),
                          //spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    height: 65,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                                width: 62,
                                height: 45,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(width: 2,color: ColorManager.faintGrey),
                                ),
                                child: Image.asset('images/Vector.png') ),
                            SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('ID: 248d1eb1-9020-4d8d-8168-43a3ef90a261',
                                    style:AknowledgementStyleConst.customTextStyle(context)),
                                SizedBox(height: 5,),
                                Text('NanDOC',
                                    style:TextStyle(
                                      fontFamily: 'FiraSans',
                                      fontSize: 10,
                                      color: Color(0xFF686464),
                                      fontWeight: FontWeight.w700,
                                    )),
                              ],
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {
                              },
                              icon: Icon(Icons.refresh_outlined,color: Color(0xff1696C8),),
                              iconSize: 20,),
                            IconButton(
                              onPressed: () {
                              },
                              icon: Icon(Icons.print_outlined,color: Color(0xff1696C8),),
                              iconSize: 20,),
                            IconButton(
                              onPressed: () {
                              },
                              icon: Icon(Icons.save_alt_outlined,color: Color(0xff1696C8),),
                              iconSize: 20,),
                            IconButton(
                              onPressed: () {
                                showDialog(context: context, builder: (BuildContext context){
                                  return OtherEditAddPopup(idController: otherEditIdController, nameController: otherEditNameController, labelName: 'Edit Others');
                                });
                              },
                              icon: Icon(Icons.edit_outlined,color: Color(0xff1696C8),),
                              iconSize: 20,),
                            IconButton(
                              onPressed: () {
                              },
                              icon: Icon(Icons.delete_outline,color: Color(0xffFF0000),),
                              iconSize: 20,),
                          ],)
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
