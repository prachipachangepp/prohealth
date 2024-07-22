import 'dart:async';
import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/employee_doc_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/employee_doc/employee_doc_data.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/const_wrap_widget.dart';

import '../../../../../../../../app/resources/theme_manager.dart';
class AcknowledgementsChildBar extends StatefulWidget {
  const AcknowledgementsChildBar({super.key});

  @override
  State<AcknowledgementsChildBar> createState() => _AcknowledgementsChildBarState();
}

class _AcknowledgementsChildBarState extends State<AcknowledgementsChildBar> {
  final StreamController<List<EmployeeDocumentModal>> _controller = StreamController<List<EmployeeDocumentModal>>();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:_controller.stream,
      builder: (context,snapshot) {
        getEmployeeDoc(context, 10,1,20).then((data) {
          _controller.add(data);
        }).catchError((error) {
          // Handle error
        });
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: ColorManager.blueprime,
            ),
          );
        }
        if (snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              AppString.dataNotFound,
              style: CustomTextStylesCommon.commonStyle(
                fontWeight: FontWeightManager.medium,
                fontSize: FontSize.s12,
                color: ColorManager.mediumgrey,
              ),
            ),
          );
        }
        if(snapshot.hasData){
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child:
            Container(
              height: MediaQuery.of(context).size.height/1,
              padding: EdgeInsets.symmetric(vertical: 30),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.25),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 5),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child:WrapWidget(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                childern: List.generate(snapshot.data!.length, (index){
                  return
                    // Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // children: [ // Adding top padding
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                        child: Container(
                          width: AppSize.s500,
                          child: Row(
                            children: [
                              Container(
                                  width: 62,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(width: 2,color: ColorManager.faintGrey),
                                  ),
                                  child: Image.asset('images/Vector.png') ),
                              SizedBox(width: 10),
                              Text(snapshot.data![index].docName,
                                  style: AknowledgementStyleConst.customTextStyle(context))
                            ],
                          ),
                        ),
                      );
                }),
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [ // Adding top padding
                  //     Row(
                  //       children: [
                  //         Container(
                  //             width: 62,
                  //             height: 45,
                  //             decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(4),
                  //               border: Border.all(width: 2,color: ColorManager.faintGrey),
                  //             ),
                  //             child: Image.asset('images/Vector.png') ),
                  //         SizedBox(width: 10),
                  //         Text('On call',
                  //             style: AknowledgementStyleConst.customTextStyle(context))
                  //       ],
                  //     ),
                  //     SizedBox(height: 20),
                  //     Row(
                  //       children: [
                  //         Container(
                  //             width: 62,
                  //             height: 45,
                  //             decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(4),
                  //               border: Border.all(width: 2,color: ColorManager.faintGrey),
                  //             ),
                  //             child: Image.asset('images/Vector.png') ),
                  //         SizedBox(width: 10),
                  //         Text('Policy Concerning 3rd Party',
                  //             style:AknowledgementStyleConst.customTextStyle(context))
                  //       ],
                  //     ),
                  //   ],),

              ),
            ),
            // ),
          );
        }
        return SizedBox();
      }
    );
  }
}
