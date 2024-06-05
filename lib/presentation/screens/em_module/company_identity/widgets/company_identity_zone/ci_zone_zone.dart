import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/company_identity_zone/widgets/zone_widgets_constants.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../widgets/widgets/custom_icon_button_constant.dart';

class CIZoneZone extends StatefulWidget {
  const CIZoneZone({super.key});

  @override
  State<CIZoneZone> createState() => _CIZoneZoneState();
}

class _CIZoneZoneState extends State<CIZoneZone> {
  late int currentPage;
  late int itemsPerPage;
  late List<String> items;
  TextEditingController countynameController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();
  TextEditingController mapController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = 6;
    items = List.generate(60, (index) => 'Item ${index + 1}');
  }

  @override
  Widget build(BuildContext context) {
    List<String> currentPageItems = items.sublist(
      (currentPage - 1) * itemsPerPage,
      min(currentPage * itemsPerPage, items.length),
    );
    return  Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
                landmarkController: landmarkController, title4: '',
                 );
            });
          }),
        ],),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 30,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Text(''),
                Text(
                  'Zone Number',
                  style: GoogleFonts.firaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
//SizedBox(width: MediaQuery.of(context).size.width/7.5,),
                Text('Zip Codes',textAlign: TextAlign.start,
                    style: GoogleFonts.firaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    )),

                Text('Cities',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.firaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    )),
                Text(
                  'Actions',
                  style: GoogleFonts.firaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child:
          ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: currentPageItems.length,
              itemBuilder: (context, index) {
                int serialNumber =
                    index + 1 + (currentPage - 1) * itemsPerPage;
                String formattedSerialNumber =
                serialNumber.toString().padLeft(2, '0');
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff000000).withOpacity(0.25),
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    formattedSerialNumber,
                                    style: GoogleFonts.firaSans(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: ColorManager.mediumgrey,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                                // Text(''),
                                Expanded(
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    "94022,94023,94024,94025,94027,94028,94301,94302,94303,94304,94305,94306,95039,95040,95041,95042,95043,95085,95303,94043,94",
                                    style: GoogleFonts.firaSans(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: ColorManager.mediumgrey,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    'MorganHill,Gilroy,SanMartin,Hollister,San\nJuanBautista',
                                    style: GoogleFonts.firaSans(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: ColorManager.mediumgrey,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(onPressed: (){
                                        showDialog(context: context, builder: (context){
                                          return CIZoneAddPopup(
                                            onSavePressed: (){},
                                            title1: 'Zone Number',
                                            countynameController: countynameController,
                                            title2: 'Zip Codes',
                                            zipcodeController: zipcodeController,
                                            title3: 'Cities',
                                            mapController: mapController,
                                            landmarkController: landmarkController, title4: '',
                                          );
                                        });
                                      }, icon: Icon(Icons.edit_outlined,color: ColorManager.mediumgrey,)),
                                      IconButton(onPressed: (){}, icon: Icon(Icons.delete_outline,color: ColorManager.faintOrange,)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )),
                    ),
                  ],
                );
              }),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(6.39),
                  border: Border.all(
                    color: ColorManager.grey,
                    width: 0.79,
                  ),
                ),
                child: IconButton(
                  padding: EdgeInsets.only(bottom: 1.5),
                  icon: Icon(Icons.chevron_left),
                  onPressed: () {
                    setState(() {
                      currentPage = currentPage > 1 ? currentPage - 1 : 1;
                    });
                  },
                  color: ColorManager.black,
                  iconSize: 20,
                ),
              ),
              SizedBox(width: 3),
              for (var i = 1; i <= (items.length / itemsPerPage).ceil(); i++)
                if (i == 1 ||
                    i == currentPage ||
                    i == (items.length / itemsPerPage).ceil())
                  InkWell(
                    onTap: () {
                      setState(() {
                        currentPage = i;
                      });
                    },
                    child: Container(
                      width: 20,
                      height: 20,
                      margin: EdgeInsets.only(left: 5, right: 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: currentPage == i
                              ? ColorManager.blueprime
                              : ColorManager.grey,
                          width: currentPage == i ? 2.0 : 1.0,
                        ),
                        color: currentPage == i
                            ? ColorManager.blueprime
                            : Colors.transparent,
                        // border: Border.all(
                        //   color: currentPage == i
                        //       ? Colors.blue
                        //       : Colors.transparent,
                        // ),
                      ),
                      child: Text(
                        '$i',
                        style: TextStyle(
                          color: currentPage == i ? Colors.white : Colors.grey,
                          fontWeight: FontWeightManager.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  )
                else if (i == currentPage - 1 || i == currentPage + 1)
                  Text(
                    '...',
                    style: TextStyle(
                      color: ColorManager.black,
                      fontWeight: FontWeightManager.bold,
                      fontSize: 12,
                    ),
                  ),
              Container(
                width: 20,
                height: 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: Colors.grey,
                    width: 0.79,
                  ),
                ),
                child: IconButton(
                  padding: EdgeInsets.only(bottom: 2),
                  icon: Icon(Icons.chevron_right),
                  onPressed: () {
                    setState(() {
                      currentPage =
                      currentPage < (items.length / itemsPerPage).ceil()
                          ? currentPage + 1
                          : (items.length / itemsPerPage).ceil();
                    });
                  },
                  color: ColorManager.black,
                  iconSize: 20,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
