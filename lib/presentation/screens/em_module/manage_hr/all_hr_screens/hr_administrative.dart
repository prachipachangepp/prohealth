import 'dart:async';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/widgets/add_emp_popup_const.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/widgets/admin_emp_data.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/widgets/edit_emp_popup_const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/value_manager.dart';
import '../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/services/api/managers/establishment_manager/all_from_hr_manager.dart';
import '../../../../../data/api_data/establishment_data/all_from_hr/all_from_hr_data.dart';
import '../../../../widgets/widgets/custom_icon_button_constant.dart';
import '../../company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import '../manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';

class HrAdministrativeScreen extends StatefulWidget {
  final int deptId;
  const HrAdministrativeScreen({super.key, required this.deptId});

  @override
  State<HrAdministrativeScreen> createState() => _HrAdministrativeScreenState();
}

class _HrAdministrativeScreenState extends State<HrAdministrativeScreen> {
  TextEditingController typeController = TextEditingController();
  TextEditingController shorthandController = TextEditingController();
  AdministrativeData administrativeData = AdministrativeData();
  final StreamController<List<HRAllData>> _controller = StreamController<List<HRAllData>>();

  late int currentPage;
  late int itemsPerPage;
  late List<String> items;
  late List<Color> containerColors;
  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = 6;
    items = List.generate(20, (index) => 'Item ${index + 1}');
    administrativeData.loadEmployeeData();
    containerColors = List.generate(20, (index) => Color(0xffE8A87D));
    _loadColors();
    getAllHrDeptWise(context,widget.deptId).then((data){
      _controller.add(data);
    }).catchError((error){});
  }

  void _loadColors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      for (int i = 0; i < containerColors.length; i++) {
        int? colorValue = prefs.getInt('containerColor$i');
        if (colorValue != null) {
          containerColors[i] = Color(colorValue);
        }
      }
    });
  }
  String seletedType = "Administrative";
   String color = "#ffc107";
  void onChange(String seletedTypeEmp){
    setState(() {
      seletedType = seletedTypeEmp;
    });
  }

  void _saveColor(int index, Color color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('containerColor$index', color.value);
  }
  int docMetaId =3;
  int doceEditMetaId=3;

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomIconButtonConst(
            text: AppString.addemployeetype,
            icon: Icons.add,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomPopupWidget(
                    typeController: typeController,
                    abbreviationController: shorthandController,
                    containerColor: containerColors[1],
                    onAddPressed: () async {
                      await addEmployeeTypePost(context,docMetaId,
                          typeController.text,
                          color,shorthandController.text);
                      getAllHrDeptWise(context,widget.deptId).then((data){
                        _controller.add(data);
                      }).catchError((error){});
                      Navigator.pop(context);
                      typeController.clear();
                      shorthandController.clear();
                    },
                    onColorChanged: (Color seletedColor) {
                      setState(() {
                        containerColors[1] = seletedColor;
                        color = seletedColor.toString().substring(10,16);
                        _saveColor(1, seletedColor);
                      });
                    },
                    //   containerColor: ColorManager.sfaintOrange,
                    //   onColorChanged: (Color selectedColor) {
                    //   color = selectedColor.toString().substring(10,16);
                    // },

                    title: 'Add Administrative',
                    child: FutureBuilder<List<HRHeadBar>>(
                        future: companyHRHeadApi(context,widget.deptId),
                        builder: (context,snapshot) {
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: 350,
                                  height: 30,
                                  decoration: BoxDecoration(color: ColorManager.faintGrey,borderRadius: BorderRadius.circular(10)),
                                )
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
                            List dropDown = [];
                            int docType = 0;
                            List<DropdownMenuItem<String>> dropDownMenuItems = [];
                            for(var i in snapshot.data!){
                              dropDownMenuItems.add(
                                DropdownMenuItem<String>(
                                  child: Text(i.deptName),
                                  value: i.deptName,
                                ),
                              );
                            }
                            return CICCDropdown(
                                initialValue: dropDownMenuItems[0].value,
                                onChange: (val){
                                  for(var a in snapshot.data!){
                                    if(a.deptName == val){
                                      docType = a.deptId;
                                      docMetaId = docType;
                                    }
                                  }
                                  print(":::${docType}");
                                  print(":::<>${docMetaId}");
                                },
                                items:dropDownMenuItems
                            );
                          }else{
                            return SizedBox();
                          }
                        }
                    ),
                  );
                },
              );
            }),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 30,
          decoration: BoxDecoration(
            color: ColorManager.fmediumgrey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Text(''),
                Text(
                  AppStringEM.srno,
                  style:  AllHRTableHeading.customTextStyle(context)
                ),
//SizedBox(width: MediaQuery.of(context).size.width/7.5,),
                Padding(
                  padding: const EdgeInsets.only(left: 60),
                  child: Text(AppStringEM.employee,textAlign: TextAlign.start,
                      style:  AllHRTableHeading.customTextStyle(context)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 100),
                  child: Text(
                    AppStringEM.abbrevation,
                    style:  AllHRTableHeading.customTextStyle(context)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: Text(
                    AppStringEM.color,
                    style:  AllHRTableHeading.customTextStyle(context)
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Text(AppStringEM.action,
                      textAlign: TextAlign.start,
                      style: AllHRTableHeading.customTextStyle(context)),
                ),
              ],
            ),
          ),
        ),
        // TableHeadConstant(items: [
        //   TableHeadItem(text: AppStringEM.srno, textAlign: TextAlign.start),
        //   TableHeadItem(
        //       text: AppStringEM.employeetype, textAlign: TextAlign.start),
        //   TableHeadItem(
        //       text: AppStringEM.abbrevation, textAlign: TextAlign.start),
        //   TableHeadItem(text: AppStringEM.color, textAlign: TextAlign.start),
        //   TableHeadItem(text: AppStringEM.action, textAlign: TextAlign.center),
        // ]),
        SizedBox(
          height: 5,
        ),
        Expanded(
          child:
          StreamBuilder<List<HRAllData>>(
            stream: _controller.stream,
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
                List<HRAllData> currentPageItems =
                snapshot.data!.sublist(
                  (currentPage - 1) * itemsPerPage,
                  (currentPage * itemsPerPage) > totalItems
                      ? totalItems
                      : (currentPage * itemsPerPage),
                );
                return
          ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
                String formattedSerialNumber =
                    serialNumber.toString().padLeft(2, '0');
                return Container(
                    margin: EdgeInsets.all(
                      5,
                    ),
                    //padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/13),
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
                          flex: 2,
                          child: Text(
                            formattedSerialNumber,
                            textAlign: TextAlign.center,
                            style: AllHRTableData.customTextStyle(context)
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            snapshot.data![index].empType.toString(),
                            textAlign: TextAlign.center,
                            style: AllHRTableData.customTextStyle(context)
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                              snapshot.data![index].abbrivation.toString(),
                            textAlign: TextAlign.center,
                            style: AllHRTableData.customTextStyle(context)
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: MediaQuery.of(context).size.width / 20,
                            height: AppSize.s22,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: snapshot.data![index].color.toColorMaybeNull,
                            ),
                          ),
                        ),
                        //SizedBox(width: MediaQuery.of(context).size.width/15,),
                        Expanded(
                          flex: 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return FutureBuilder<HRGetEmpId>(
                                        future: HrGetById(context, snapshot.data![index].employeeTypesId),
                                        builder: (context, snapshot) {
                                          if(snapshot.connectionState == ConnectionState.waiting){
                                            return Center(
                                              child: CircularProgressIndicator(
                                                color: ColorManager.blueprime,
                                              ),
                                            );
                                          }
                                          var type = snapshot.data?.empType.toString();
                                          var shorthand = snapshot.data?.empType.toString();
                                          doceEditMetaId = snapshot.data!.deptId;
                                          typeController = TextEditingController(text: snapshot.data?.empType.toString());
                                          shorthandController = TextEditingController(text: snapshot.data?.abbrivation.toString());

                                          return EditPopupWidget(
                                            typeController: typeController,
                                            shorthandController: shorthandController,
                                            containerColor: containerColors[index],
                                            onSavePressed: () async{
                                              await AllFromHrPatch(context, snapshot.data!.empTypeId, doceEditMetaId,
                                                  type == typeController.text ? type.toString() : typeController.text,
                                                  shorthand == shorthandController.text ? shorthand.toString() : shorthandController.text,
                                                  color);
                                              getAllHrDeptWise(context,widget.deptId).then((data){
                                                _controller.add(data);
                                              }).catchError((error){});
                                              doceEditMetaId = 0;
                                              Navigator.pop(context);
                                              typeController.clear();
                                              shorthandController.clear();
                                              seletedType = "Administrative";
                                            },
                                            onColorChanged: (Color seletedColor) {
                                              setState(() {
                                                containerColors[index] = seletedColor;
                                                color = seletedColor.toString().substring(10,16);
                                                _saveColor(index, seletedColor);
                                              });
                                            }, title: 'Edit Administrative',
                                            child:  FutureBuilder<List<HRHeadBar>>(
                                              future: companyHRHeadApi(context,widget.deptId),
                                              builder: (context,snapshot) {
                                                if(snapshot.connectionState == ConnectionState.waiting){
                                                  return Shimmer.fromColors(
                                                      baseColor: Colors.grey[300]!,
                                                      highlightColor: Colors.grey[100]!,
                                                      child: Container(
                                                        width: 350,
                                                        height: 30,
                                                        decoration: BoxDecoration(color: ColorManager.faintGrey,borderRadius: BorderRadius.circular(10)),
                                                      )
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
                                                  List dropDown = [];
                                                  int docType = 0;
                                                  List<DropdownMenuItem<String>> dropDownMenuItems = [];
                                                  for(var i in snapshot.data!){
                                                    dropDownMenuItems.add(
                                                      DropdownMenuItem<String>(
                                                        child: Text(i.deptName),
                                                        value: i.deptName,
                                                      ),
                                                    );
                                                  }
                                                  return CICCDropdown(
                                                      initialValue: dropDownMenuItems[2].value,
                                                      onChange: (val){
                                                        for(var a in snapshot.data!){
                                                          if(a.deptName == val){
                                                            docType = a.deptId;
                                                            doceEditMetaId = docType;
                                                          }
                                                        }
                                                        print(":::${docType}");
                                                        print(":::<>${doceEditMetaId}");
                                                      },
                                                      items:dropDownMenuItems
                                                  );
                                                }else{
                                                  return SizedBox();
                                                }
                                              }
                                          ),

                                            // onColorChanged: (Color color) {
                                            //   setState(() {
                                            //     containerColors[index] =
                                            //      color; // Update color for this item
                                            //   });
                                            // },
                                          );

                                        }
                                      );
                                    },
                                  );
                                },
                                icon: Icon(Icons.edit_outlined,size: 18,),
                                color: ColorManager.blueprime,
                              ),
                              IconButton(
                                onPressed: () {
                                  showDialog(context: context,
                                      builder: (context) => DeletePopup(
                                          onCancel: (){
                                            Navigator.pop(context);
                                          }, onDelete: () async {
                                        await  allfromHrDelete(
                                            context, snapshot.data![index].employeeTypesId);
                                        getAllHrDeptWise(context,widget.deptId).then((data){
                                          _controller.add(data);
                                        }).catchError((error){});
                                        Navigator.pop(context);
                                      }));

                                },
                                icon: const Icon(
                                  size: 18,
                                  Icons.delete_outline,
                                  color: Color(0xffF6928A),
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ));
              })
          ;
  }
  return Offstage();
},
),

        ),
        SizedBox(
          height: AppSize.s10,
        ),
        // PaginationControlsWidget(
        //   currentPage: currentPage,
        //   items: items,
        //   itemsPerPage: itemsPerPage,
        //   onPreviousPagePressed: () {
        //     /// Handle previous page button press
        //     setState(() {
        //       currentPage = currentPage > 1 ? currentPage - 1 : 1;
        //     });
        //   },
        //   onPageNumberPressed: (pageNumber) {
        //     /// Handle page number tap
        //     setState(() {
        //       currentPage = pageNumber;
        //     });
        //   },
        //   onNextPagePressed: () {
        //     /// Handle next page button press
        //     setState(() {
        //       currentPage = currentPage < (items.length / itemsPerPage).ceil()
        //           ? currentPage + 1
        //           : (items.length / itemsPerPage).ceil();
        //     });
        //   },
        // ),
      ],
    );
  }
}