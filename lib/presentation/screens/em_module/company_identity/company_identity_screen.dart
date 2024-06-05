import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/model/company_data_model.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/company_identrity_manager.dart';
import '../../../../../../app/services/api_sm/company_identity/add_doc_company_manager.dart';
import '../../../widgets/widgets/custom_icon_button_constant.dart';
import '../../hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../widgets/button_constant.dart';
import '../widgets/text_form_field_const.dart';


class CompanyIdentityScreen extends StatefulWidget {
  final VoidCallback? onWhitelabellingPressed;
  const CompanyIdentityScreen({super.key, this.onWhitelabellingPressed});

  @override
  State<CompanyIdentityScreen> createState() => _CompanyIdentityScreenState();
}

class _CompanyIdentityScreenState extends State<CompanyIdentityScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobNumController = TextEditingController();
  TextEditingController secNumController = TextEditingController();
  TextEditingController OptionalController = TextEditingController();

  // final PageController _pageController = PageController();
  late CompanyIdentityManager _companyManager;
  // final ButtonSelectionController myController =
  // Get.put(ButtonSelectionController());

  late int currentPage;
  late int itemsPerPage;
  late List<String> items;

  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = 5;
    items = List.generate(20, (index) => 'Item ${index + 1}');
    _companyManager = CompanyIdentityManager();
    companyAllApi(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 6),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ///whitelabbeling
            CustomButton(
              borderRadius: 12,
              text: 'Whitelabelling',
              style: CustomTextStylesCommon.commonStyle(
                  fontSize: FontSize.s12,
                  fontWeight: FontWeightManager.bold,
                  color: ColorManager.white),
              width: 120,
              height: 30,
              onPressed: () {
                if (widget.onWhitelabellingPressed != null) {
                  widget.onWhitelabellingPressed!();
                }

              },
            ),
            SizedBox(
              width: AppSize.s30,
            ),
            ///add new office
            CustomIconButtonConst(
              text: 'Add New Office',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        backgroundColor: Colors.white,
                        content: Container(
                          height: 450,
                          width: 300,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(Icons.close))
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SMTextFConst(
                                    controller: nameController,
                                    keyboardType: TextInputType.text,
                                    text: 'Name',
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  SMTextFConst(
                                    controller: addressController,
                                    keyboardType: TextInputType.streetAddress,
                                    text: 'Address',
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  SMTextFConst(
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    text: 'Email',
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  SMTextFConst(
                                    controller: mobNumController,
                                    keyboardType: TextInputType.number,
                                    text: 'Primary Phone',
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  SMTextFConst(
                                    controller: secNumController,
                                    keyboardType: TextInputType.number,
                                    text: 'Secondary Phone',
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  SMTextFConst(
                                    controller: OptionalController,
                                    keyboardType: TextInputType.number,
                                    text: 'Alternative Phone',
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              CustomElevatedButton(
                                  width: 105,
                                  height: 31,
                                  text: 'Submit',
                                  onPressed: () {
                                    addNewOffice(
                                        context,
                                        nameController.text,
                                        addressController.text,
                                        emailController.text,
                                        mobNumController.text,
                                        secNumController.text);
                                    Navigator.pop(context);
                                    companyAllApi(context);
// Navigator.push(
//     context,
//     MaterialPageRoute(
//         builder: (context) =>
//             LoginScreen()));
                                  })
                            ],
                          ),
                        ));
                  },
                );
              },
              icon: Icons.add,
            )
          ],
        ),
        SizedBox(height: 20),

        ///heading row
        Container(
          height: 30,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(''),
              Text(
                'Sr No',
                style: GoogleFonts.firaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
// SizedBox(width: MediaQuery.of(context).size.width/7.5,),
              Text('Office Name',
                  style: GoogleFonts.firaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  )),

//SizedBox(width: MediaQuery.of(context).size.width/5.5,),
              Text('Address  ',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.firaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  )),
// SizedBox(height: 1,),
//SizedBox(width: MediaQuery.of(context).size.width/150,),
              Text('Actions',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.firaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  )),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),

        ///list

        Expanded(
          child: FutureBuilder<List<CompanyModel>>(
            future: companyAllApi(context),
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: ColorManager.blueprime,
                  ),
                );
              }
              if (snapshot.hasData) {
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      int serialNumber =
                          index + 1 + (currentPage - 1) * itemsPerPage;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          Container(
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
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.menu_sharp,
                                        color: Color(0xff686464),
                                      )),
                                  Text('  '),
                                  Text(
                                    snapshot.data![index].companyId.toString(),
                                    // formattedSerialNumber,
                                    style: GoogleFonts.firaSans(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff686464),
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  Text(''),
                                  Text(
                                    snapshot.data![index].name.toString(),
                                    style: GoogleFonts.firaSans(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff686464),
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  Text(''),
                                  Text(
                                    snapshot.data![index].address.toString(),
                                    textAlign: TextAlign.end,
                                    style: GoogleFonts.firaSans(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff686464),
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  Text(''),

                                  CustomButtonTransparentSM(
                                      text: 'Manage', onPressed: () {

                                  })
                                ],
                              )),
                        ],
                      );
                    });
              }
              return Scaffold();
            },
          ),
        ),

        SizedBox(
          height: 10,
        ),
        Container(
          height: 30,
          // color: Colors.black12,
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
                    '..',
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
      ]),
    ));
  }
}
// showModalBottomSheet(
//   context: context,
//   isScrollControlled: true,
//   builder: (BuildContext context) {
//     return Stack(
//       children:[Container(
//         height: 500,
//         width: 1000,
//         decoration: BoxDecoration(
//           color: Colors.red,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(12.0),
//             topRight: Radius.circular(12.0),
//           ),
//         ),
//         //  padding: EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: Icon(Icons.close),
//                 ),
//               ],
//             ),
//             // Add your content here
//           ],
//         ),
//       ),
//     ]);
//   },
// );