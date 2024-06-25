import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import '../../../../app/services/api/managers/establishment_manager/all_from_hr_manager.dart';
import '../../../../data/api_data/establishment_data/all_from_hr/all_from_hr_data.dart';
import 'all_hr_screens/hr_administrative.dart';
import 'all_hr_screens/hr_clinical.dart';
import 'all_hr_screens/hr_sales.dart';

class HrScreen extends StatefulWidget {
  // final int deptId;
  // const HrScreen({required this.deptId})
  @override
  _HrScreenState createState() => _HrScreenState();
}

class _HrScreenState extends State<HrScreen> {
  final PageController _hrPageController = PageController();
  int _selectedIndex = 0;

  void _selectButton(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _hrPageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return HrWidget(
      hrPageController: _hrPageController,
      selectedIndex: _selectedIndex,
      selectButton: _selectButton,
    );
  }
}


class HrWidget extends StatefulWidget {
  final PageController hrPageController;
  final int selectedIndex;
  final Function(int) selectButton;

  HrWidget({
    required this.hrPageController,
    required this.selectedIndex,
    required this.selectButton,
  });

  @override
  State<HrWidget> createState() => _HrWidgetState();
}

class _HrWidgetState extends State<HrWidget> {
  @override
  void initState() {
    super.initState();
    companyHRHeadApi(context, deptId);
  }

  var deptId = 0;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppPadding.p24),
            child: FutureBuilder<List<HRHeadBar>>(
              future: companyHRHeadApi(context, deptId),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                return Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: AppSize.s30,
                    width: MediaQuery.of(context).size.width / 2.99,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: ColorManager.blueprime,
                      boxShadow: [
                        BoxShadow(
                        color: ColorManager.black.withOpacity(0.25),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                  ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:  [
                        Expanded(
                            child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                // return
                                //   Center(
                                //   child: CircularProgressIndicator(
                                //     color: Colors.blue, // Change according to your theme
                                //   ),
                                // );
                              }
                              if(snapshot.hasData){
                                return InkWell(
                                  onTap: (){
                                    widget.selectButton(
                                        snapshot.data![index].deptId);
                                    companyHRHeadApi(
                                        context, snapshot.data![index].deptId);
                                    deptId = snapshot.data![index].deptId;
                                  },
                                  child: Container(
                                    height: 30,
                                    width: MediaQuery.of(context).size.width / 9,
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: widget.selectedIndex == snapshot.data![index].deptId
                                          ? Colors.white
                                          : null,
                                    ),
                                    child: Text(
                                      snapshot.data![index].deptName,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.firaSans(
                                        fontSize: 12,
                                        fontWeight: widget.selectedIndex == snapshot.data![index].deptId
                                            ? FontWeightManager.bold
                                            :FontWeightManager.semiBold,
                                        color: widget.selectedIndex == snapshot.data![index].deptId
                                            ? ColorManager.mediumgrey
                                            : ColorManager.white,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            }))
                      ]
                    ),
                  ),
                );
    } else{
    return SizedBox(height: 1,width: 1,);
    }
              },
            ),
          ),
          Expanded(
            flex: 10,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 60),
              child: PageView(
                controller: widget.hrPageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Container(),
                  HrClinicalScreen(deptId: deptId,),
                  HrSalesScreen(deptId: deptId,),
                  HrAdministrativeScreen(deptId: deptId,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
