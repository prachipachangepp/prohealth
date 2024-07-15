import 'package:flutter/material.dart';

import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../clinical_hr.dart';
import 'edit_pop_up.dart';

class SeeAllContainerConstant extends StatefulWidget {
  const SeeAllContainerConstant({super.key});

  @override
  State<SeeAllContainerConstant> createState() => _SeeAllContainerConstantState();
}

class _SeeAllContainerConstantState extends State<SeeAllContainerConstant> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(
        5,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      height: AppSize.s56,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 40.0),
            child: Expanded(
              flex: 1,
              child: Text('1',
                  textAlign: TextAlign.center,
                  style: AllHRTableData.customTextStyle(context)),
            ),
          ),

          Expanded(
            flex: 1,
            child: Text(
              // snapshot.data![index].empType.toString(),
                "RN",
                textAlign: TextAlign.center,
                style: AllHRTableData.customTextStyle(context)),
          ),
          Expanded(
            flex: 2,
            child: Text(
              // snapshot.data![index].abbrivation.toString(),
                'Dhillon Amarpreet',
                textAlign: TextAlign.center,
                style: AllHRTableData.customTextStyle(context)),
          ),
          Expanded(
            flex: 3,
            child: Text(
              // snapshot.data![index].abbrivation.toString(),
                'ProHealth Walnut Creek-EI Dorado Sacramento',
                textAlign: TextAlign.center,
                style: AllHRTableData.customTextStyle(context)),
          ),
          Expanded(
            flex: 2,
            child: Text(
              // snapshot.data![index].abbrivation.toString(),
                'Infection control',
                textAlign: TextAlign.center,
                style: AllHRTableData.customTextStyle(context)),
          ), Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ///edit
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return EditPopUp();
                      },
                    );
                  },
                  icon: Icon(Icons.edit_outlined, size: 18),
                  color: Color(0xff50B5E5),
                ),

                ///delete
                IconButton(
                  onPressed: () {
                    // showDialog(context: context,
                    //     builder: (context) => DeletePopup(
                    //         onCancel: (){
                    //           Navigator.pop(context);
                    //         }, onDelete: () async {
                    //       await  allfromHrDelete(
                    //           context, snapshot.data![index].employeeTypesId!);
                    //       getAllHrDeptWise(context,widget.deptId).then((data){
                    //         _controller.add(data);
                    //       }).catchError((error){});
                    //       Navigator.pop(context);
                    //     }));
                  },
                  icon: Icon(
                    size: 18,
                    Icons.delete_outline,
                    color: Color(0xffF6928A),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );;
  }
}
