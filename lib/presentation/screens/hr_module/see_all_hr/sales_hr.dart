import 'dart:async';
import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/hr_module/see_all_hr/widgets/edit_pop_up.dart';
import '../../../../app/resources/color.dart';
import '../../../../app/resources/const_string.dart';
import '../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../app/resources/font_manager.dart';
import '../../../../app/resources/theme_manager.dart';
import '../../../../app/resources/value_manager.dart';
import '../../../../app/services/api/managers/hr_module_manager/see_all/see_all_manager.dart';
import '../../../../data/api_data/hr_module_data/see_all_data/see_all_data.dart';

class SalesHrScreen extends StatefulWidget {
  const SalesHrScreen({super.key});

  @override
  State<SalesHrScreen> createState() => _SalesHrScreenState();
}

class _SalesHrScreenState extends State<SalesHrScreen> {
  final StreamController<List<SeeAllData>> seeAllController = StreamController<List<SeeAllData>>();
  late int currentPage;
  late int itemsPerPage;
  late List<String> items;
  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = 20;
    items = List.generate(20, (index) => 'Item ${index + 1}');
    getEmployeeSeeAll(context, 1).then((data){seeAllController.add(data);
    }).catchError((error){});
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 60,
        ),
        Container(
          height: 30,
          decoration: BoxDecoration(
            color: ColorManager.fmediumgrey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 80.0),
                  child: Text(
                    AppStringEM.srno,
                    style: AllHRTableHeading.customTextStyle(context),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    AppStringEM.type,
                    style: AllHRTableHeading.customTextStyle(context),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  AppStringEM.name,
                  style: AllHRTableHeading.customTextStyle(context),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    AppStringEM.location,
                    style: AllHRTableHeading.customTextStyle(context),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Text(
                    AppStringEM.specialization,
                    style: AllHRTableHeading.customTextStyle(context),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Text(
                    AppStringEM.edit,
                    style: AllHRTableHeading.customTextStyle(context),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 60,
        ),
        Expanded(
          child: StreamBuilder<List<SeeAllData>>(
            stream: seeAllController.stream,
            builder: (context, snapshot) {
              print('1111111');
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
              if (snapshot.hasData) {
                int totalItems = snapshot.data!.length;
                // int totalPages = (totalItems / itemsPerPage).ceil();
                List<SeeAllData> currentPageItems =
                snapshot.data!.sublist(
                  (currentPage - 1) * itemsPerPage,
                  (currentPage * itemsPerPage) > totalItems
                      ? totalItems
                      : (currentPage * itemsPerPage),
                );
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: currentPageItems.length,
                  itemBuilder: (context, index) {
                    int serialNumber =
                        index + 1 + (currentPage - 1) * itemsPerPage;
                    String formattedSerialNumber =
                    serialNumber.toString().padLeft(2, '0');
                    return Container(
                      margin: EdgeInsets.all(5),
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
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.only(left: 40.0),
                              child: Text(
                                formattedSerialNumber,
                                textAlign: TextAlign.center,
                                style: AllHRTableData.customTextStyle(context),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              snapshot.data![index].type.toString(),
                              //"RN",
                              textAlign: TextAlign.center,
                              style: AllHRTableData.customTextStyle(context),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              snapshot.data![index].firstName.toString(),
                              //'Dhillon Amarpreet',
                              textAlign: TextAlign.center,
                              style: AllHRTableData.customTextStyle(context),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              snapshot.data![index].position.toString(),
                              //'ProHealth Walnut Creek-EI Dorado Sacramento',
                              textAlign: TextAlign.center,
                              style: AllHRTableData.customTextStyle(context),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              snapshot.data![index].expertise.toString(),
                              //  'Infection control',
                              textAlign: TextAlign.center,
                              style: AllHRTableData.customTextStyle(context),
                            ),
                          ),
                          Expanded(
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
                    );
                  },
                );
              }
              return Offstage();
            },
          ),
        )
      ],
    );
  }
}
