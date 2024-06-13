import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/company_identity_zone/ci_zone_country.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/company_identity_zone/ci_zone_zone.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/company_identity_zone/widgets/zone_widgets_constants.dart';
import '../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../widgets/widgets/custom_icon_button_constant.dart';
import '../../company_identity_screen.dart';

class CiZone extends StatefulWidget {
  const CiZone({super.key});

  @override
  State<CiZone> createState() => _CiOrgDocumentState();
}

class _CiOrgDocumentState extends State<CiZone> {
  final PageController _tabPageController = PageController();
  TextEditingController docNamecontroller = TextEditingController();
  TextEditingController docIdController = TextEditingController();
  TextEditingController countynameController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();
  TextEditingController mapController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();

  int _selectedIndex = 0;

  void _selectButton(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _tabPageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.symmetric( horizontal: MediaQuery.of(context).size.width / 50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _selectedIndex == 0 ?
              SizedBox(width: 354,):
              Container(
                height: 30,
                width: 354,
                // margin: EdgeInsets.symmetric(horizontal: 20),
                padding:
                EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Color(0xff686464).withOpacity(0.5),
                      width: 1), // Black border
                  borderRadius:
                  BorderRadius.circular(8), // Rounded corners
                ),
                child: DropdownButtonFormField<String>(
                  focusColor: Colors.transparent,
                  icon: Icon(
                    Icons.arrow_drop_down_sharp,
                    color: Color(0xff686464),
                  ),
                  decoration: InputDecoration.collapsed(hintText: ''),
                  items: <String>[
                    'Sant Clara',
                    'Option 1',
                    'Option 2',
                    'Option 3',
                    'Option 4'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {},
                  value: 'Sant Clara',
                  style: GoogleFonts.firaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff686464),
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              ///tabbar
              Padding(
                padding: const EdgeInsets.only(right: 250),
                child: Container(
                  //color: Colors.greenAccent,
                  width: MediaQuery.of(context).size.width/7,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => _selectButton(0),
                        child: Container(
                          height: 40,
                          width: 80,
                          child: Column(
                            children: [
                              Text(
                                "County",
                                style: GoogleFonts.firaSans(
                                  fontSize: 12,
                                  fontWeight: _selectedIndex == 0
                                      ? FontWeightManager.bold
                                      : FontWeightManager.regular,
                                  color: _selectedIndex == 0
                                      ? ColorManager.blueprime
                                      : ColorManager.mediumgrey,
                                ),
                              ),
                              _selectedIndex == 0 ?
                              Divider(color:ColorManager.blueprime,thickness: 2,):Offstage()
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => _selectButton(1),
                        child: Container(
                          height: 40,
                          width: 80,
                          child: Column(
                            children: [
                              Text(
                                "Zone",
                                style: GoogleFonts.firaSans(
                                  fontSize: 12,
                                  fontWeight: _selectedIndex == 1
                                      ? FontWeightManager.bold
                                      : FontWeightManager.regular,
                                  color: _selectedIndex == 1
                                      ? ColorManager.blueprime
                                      : ColorManager.mediumgrey,
                                ),
                              ),
                              _selectedIndex == 1 ?
                              Divider(color:ColorManager.blueprime,thickness: 2,):Offstage()
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ///button
              _selectedIndex == 0 ?
              CustomIconButtonConst(
                  icon: Icons.add,
                  text: AppStringEM.add, onPressed: (){
                showDialog(context: context, builder: (context){
                  return CIZoneAddPopup(
                    onSavePressed: (){},
                    title1: AppStringEM.countyName,
                    countynameController: countynameController,
                    title2: AppStringEM.zipCode,
                    zipcodeController: zipcodeController,
                    title3: AppStringEM.map,
                    mapController: mapController,
                    title4:AppStringEM.landmark,
                    landmarkController: landmarkController, );
                });
              }) :
              CustomIconButtonConst(
                  icon: Icons.add,
                  text: "Add", onPressed: (){
                showDialog(context: context, builder: (context){
                  return CIZoneAddPopup(
                    onSavePressed: (){},
                    title1: 'Zone Number',
                    countynameController: countynameController,
                    title2: 'Zip Codes',
                    zipcodeController: zipcodeController,
                    title3: 'Cities',
                    mapController: mapController,
                    landmarkController: landmarkController, title4: 'Landmark',
                  );
                });
              }),
              // Align(
              //     alignment: Alignment.bottomRight,
              //     child: Material(
              //       elevation: 3,
              //       borderRadius: BorderRadius.circular(20),
              //       child: Container(
              //         height: 30,
              //         width: 150,
              //         child: CustomIconButton(
              //             icon: CupertinoIcons.plus,
              //             text: "Add Document",
              //             onPressed: () {
              //               showDialog(
              //                   context: context,
              //                   builder: (context) {
              //                     return AddOrgDocButton(
              //                       idDocController: docIdController,
              //                       nameDocController: docNamecontroller,
              //
              //                       child: CICCDropdown(
              //                         initialValue:
              //                         'Corporate & Compliance Documents',
              //                         items: [
              //                           DropdownMenuItem(
              //                               value:
              //                               'Corporate & Compliance Documents',
              //                               child: Text(
              //                                   'Corporate & Compliance Documents')),
              //                           DropdownMenuItem(
              //                               value: 'HCO Number      254612',
              //                               child: Text('HCO Number  254612')),
              //                           DropdownMenuItem(
              //                               value: 'Medicare ID      MPID123',
              //                               child: Text('Medicare ID  MPID123')),
              //                           DropdownMenuItem(
              //                               value: 'NPI Number     1234567890',
              //                               child: Text('NPI Number 1234567890')),
              //                         ],
              //                       ),
              //                       child1: CICCDropdown(
              //                         initialValue: 'Licenses',
              //                         items: [
              //                           DropdownMenuItem(
              //                               value: 'Licenses',
              //                               child: Text('Licenses')),
              //                           DropdownMenuItem(
              //                               value: 'HCO Number      254612',
              //                               child: Text('HCO Number  254612')),
              //                           DropdownMenuItem(
              //                               value: 'Medicare ID      MPID123',
              //                               child: Text('Medicare ID  MPID123')),
              //                           DropdownMenuItem(
              //                               value: 'NPI Number     1234567890',
              //                               child: Text('NPI Number 1234567890')),
              //                         ],
              //                       ),
              //                     );
              //                   });
              //             }),
              //       ),
              //     )),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Expanded(
          child:
              Padding(
                padding: EdgeInsets.symmetric( horizontal: MediaQuery.of(context).size.width / 50),
                child: NonScrollablePageView(
                  controller: _tabPageController,
                  onPageChanged: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  children: [
                    // Page 1
                    CIZoneCountry(),
                    CIZoneZone(),
                  ],
                ),
              ),
        )
      ],
    );
  }
}
