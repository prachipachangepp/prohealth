import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/provider/hr_onboarding_provider.dart';
import 'package:prohealth/presentation/widgets/widgets/profile_bar/widget/pagination_widget.dart';
import 'package:provider/provider.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/const_string.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../app/resources/theme_manager.dart';
import '../../../../../../app/resources/value_manager.dart';
import '../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../app/services/api/managers/hr_module_manager/see_all/see_all_manager.dart';
import '../../../../../data/api_data/hr_module_data/see_all_data/see_all_data.dart';

class OnboardingGeneral extends StatelessWidget {

  final void Function(int,int, String,String,int) selectButton;
  final VoidCallback goBackButtion;

  const OnboardingGeneral({Key? key, required this.selectButton,  required this.goBackButtion}) : super(key: key);

  // final StreamController<List<SeeAllData>> generalController = StreamController<List<SeeAllData>>();
  // List<SeeAllData> allData = [];
  // String _selectedValue = 'Sort';

  // @override
  // void initState() {
  //   super.initState();
  //   getEmployeeSeeAll(context).then((data) {
  //     final filteredData = data.where((item) =>
  //     item.status == 'Partial' ||
  //         item.status == 'Enrolled' ||
  //         item.status == 'Completed').toList();
  //
  //     allData = filteredData;
  //
  //     generalController.add(allData);
  //   }).catchError((error) {
  //     print('Error fetching data: $error');
  //   });
  // }
  // String _trimAddress(String address) {
  //   const int maxLength = 15;
  //   if (address.length > maxLength) {
  //     return '${address.substring(0, maxLength)}...';
  //   }
  //   return address;
  // }
  //
  // OverlayEntry? _overlayEntryAddress;
  // void _showOverlayAddress(BuildContext context, Offset position, String address) {
  //   _overlayEntryAddress = OverlayEntry(
  //     builder: (context) => Positioned(
  //       left: 300,
  //       top: position.dy + 15, // Adjust to position below the text
  //       child: Material(
  //         color: Colors.transparent,
  //         child: Container(
  //           width: 250,
  //           padding: EdgeInsets.all(8.0),
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(8.0),
  //             boxShadow: [
  //               BoxShadow(color: Colors.black26, blurRadius: 4, spreadRadius: 2),
  //             ],
  //           ),
  //           child: Text(
  //             address, // Display the actual address here
  //             style: ThemeManagerAddressPB.customTextStyle(context),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  //   Overlay.of(context)?.insert(_overlayEntryAddress!);
  // }
  //
  // // void _showOverlayAddress(BuildContext context, Offset position) {
  // //   _overlayEntryAddress = OverlayEntry(
  // //     builder: (context) => Positioned(
  // //       left:300,
  // //       top: position.dy + 15, // Adjust to position below the text
  // //       child: Material(
  // //         color: Colors.transparent,
  // //         child: Container(
  // //           width: 250,
  // //           padding: EdgeInsets.all(8.0),
  // //           decoration: BoxDecoration(
  // //             color: Colors.white,
  // //             borderRadius: BorderRadius.circular(8.0),
  // //             boxShadow: [
  // //               BoxShadow(color: Colors.black26, blurRadius: 4, spreadRadius: 2),
  // //             ],
  // //           ),
  // //           child: Text(
  // //             "new",
  // //             style: ThemeManagerAddressPB.customTextStyle(context),
  // //           ),
  // //         ),
  // //       ),
  // //     ),
  // //   );
  // //   Overlay.of(context)?.insert(_overlayEntryAddress!);
  // // }
  // void _removeOverlayAddress() {
  //   _overlayEntryAddress?.remove();
  //   _overlayEntryAddress = null;
  // }



  @override
  Widget build(BuildContext context) {
    final onboarProvider = Provider.of<HrOnboardingProvider>(context,listen:false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onboarProvider.getStreamData(context);
    });
    final Map<String, String> displayTextMap = {
      'Sort': 'Sort',
      'Enrolled': 'Opened',
      'Partial': 'Partial',
      'Completed': 'Completed',
    };
    Color getStatusColor(String? status) {
      switch (status) {
        case 'Opened':
        case 'Enrolled':
          return ColorManager.bluebottom;
        case 'Partial':
          return const Color(0xffCA8A04);
        case 'Completed':
          return ColorManager.greenF;
        default:
          return  ColorManager.greenF;
      }

    }
    String _trimAddress(String address) {
      const int maxLength = 15;
      if (address.length > maxLength) {
        return '${address.substring(0, maxLength)}...';
      }
      return address;
    }
    OverlayEntry? _overlayEntryAddress;
    void _showOverlayAddress(BuildContext context, Offset position, String address) {
      _overlayEntryAddress = OverlayEntry(
        builder: (context) => Positioned(
          left: 300,
          top: position.dy + 15, // Adjust to position below the text
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 250,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 4, spreadRadius: 2),
                ],
              ),
              child: Text(
                address, // Display the actual address here
                style: ThemeManagerAddressPB.customTextStyle(context),
              ),
            ),
          ),
        ),
      );
      Overlay.of(context)?.insert(_overlayEntryAddress!);
    }
    void _removeOverlayAddress() {
      _overlayEntryAddress?.remove();
      _overlayEntryAddress = null;
    }
    final int itemsPerPage = 10;

    return Consumer<HrOnboardingProvider>(
      builder: (context,onboardingProviderState,child) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0,right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DropdownButton2<String>(
                    value: onboardingProviderState.selectedValue,
                    onChanged: (String? newValue) {
                      onboardingProviderState.sortData(newValue);
                      // setState(() {
                      //   onboardingProviderState.selectedValue = newValue!;
                      //   onboardingProviderState.filterData(); // Call filter method on dropdown selection.
                      // });
                    },
                    style: TransparentButtonTextConst.customTextStyle(context),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xff50B5E5),
                      ),
                    ),
                    // iconSize: 20,
                    underline: const SizedBox(),
                    buttonStyleData: ButtonStyleData(
                      height: 31,
                      width: 130,
                      padding: const EdgeInsets.symmetric(horizontal: 8),  // Internal padding.
                      elevation: 2,  // Shadow depth.
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: const Color(0xff50B5E5), width: 1.2),
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff000000).withOpacity(0.25),
                            blurRadius: 2,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      overlayColor: WidgetStateProperty.all(Colors.grey.withOpacity(0.1)),  // Background color when pressed.
                    ),
                    items: displayTextMap.keys.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(displayTextMap[value]!),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<List<SeeAllData>>(
                stream: onboardingProviderState.generalController.stream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(color: ColorManager.blueprime),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        AppStringHRNoData.noOnboardingData,
                        style: AllNoDataAvailable.customTextStyle(context),
                      ),
                    );
                  }
                  // Paginate the data.
                  int currentPage = onboardingProviderState.currentPage;
                  int totalItems = snapshot.data!.length;
                  int totalPages = (totalItems / itemsPerPage).ceil();

                  // Paginate data
                  List<SeeAllData> paginatedData = snapshot.data!
                      .skip((currentPage - 1) * itemsPerPage)
                      .take(itemsPerPage)
                      .toList();


                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: paginatedData.length,
                          itemBuilder: (context, index) {
                            SeeAllData general = paginatedData[index];
                            String fullName = '${general.firstName?.capitalizeFirst ?? ''} ${general.lastName?.capitalizeFirst ?? ''}';
                            String displayStatus = general.status == 'Enrolled' ? 'Opened' : general.status ?? '--';
                            // WidgetsBinding.instance.addPostFrameCallback((_) {
                            //   onboardingProviderState.trimAddress(general.finalAddress!);
                            // });

                            return Column(
                              children: [
                                //buildEmployeeCard(containerWidth, general, fullName),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                                  child: Material(
                                    color: ColorManager.white,
                                    elevation: 4,
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      //width: containerWidth,
                                      //height: AppSize.s181,
                                      decoration: BoxDecoration(
                                        color: ColorManager.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              ///status
                                              Container(
                                                  width: AppSize.s88,
                                                  height: AppSize.s20,
                                                  decoration: BoxDecoration(
                                                    color: getStatusColor(displayStatus),
                                                    borderRadius: BorderRadius.only(
                                                        topRight: Radius.circular(20)),),
                                                  child: Center(
                                                    child: Text(
                                                        displayStatus,
                                                        textAlign: TextAlign.center,
                                                        style: CustomTextStylesCommon.commonStyle(
                                                            color: ColorManager.white,
                                                            fontSize: FontSize.s13,
                                                            fontWeight: FontWeight.w700)),
                                                  )),
                                            ],
                                          ),
                                          SizedBox(height: AppSize.s5),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                MediaQuery.of(context).size.width /
                                                    60),
                                            child: InkWell(
                                              onTap: () => selectButton(
                                                  1,
                                                  general.empId!,
                                                  fullName,
                                                  general.imgurl!,
                                                  general.deptId!), // Corrected reference
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  ///profile pic and name
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      CircleAvatar(
                                                          radius: 30,
                                                          backgroundColor: Colors.white,
                                                          child:
                                                          ClipOval(
                                                            child: general.imgurl == 'imgurl' || general.imgurl == null
                                                                ? CircleAvatar(
                                                              radius: 30,
                                                              backgroundColor: ColorManager.faintGrey,
                                                              child: Image.asset("images/profilepic.png",width: double.infinity,
                                                                height: double.infinity,),
                                                            )
                                                                : Image.network(
                                                              general.imgurl!,
                                                              width: double.infinity,
                                                              height: double.infinity,
                                                              loadingBuilder: (context, child, loadingProgress) {
                                                                if (loadingProgress == null) {
                                                                  return child;
                                                                } else {
                                                                  return Center(
                                                                    child: CircularProgressIndicator(
                                                                        value: loadingProgress.expectedTotalBytes != null
                                                                            ? loadingProgress.cumulativeBytesLoaded /
                                                                            (loadingProgress.expectedTotalBytes ?? 1)
                                                                            : null),
                                                                  );
                                                                }
                                                              },
                                                              errorBuilder: (context, error, stackTrace) {
                                                                return CircleAvatar(
                                                                    radius: 30,
                                                                    child: Image.asset("images/profilepic.png",width: double.infinity,
                                                                  height: double.infinity,));
                                                              },
                                                              fit: BoxFit.cover,
                                                            ),
                                                          )
                                                      ),

                                                      ///profile image
                                                      SizedBox(height: MediaQuery.of(context).size.height / 60),
                                                      ///name of the Person
                                                      Container(
                                                        height: AppSize.s40,
                                                        width: MediaQuery.of(context).size.width/18,
                                                        child: Align(
                                                          alignment: Alignment.center,
                                                          child: Text(
                                                            '${general.firstName?.capitalizeFirst ?? ''} ${general.lastName?.capitalizeFirst ?? ''}',
                                                            textAlign: TextAlign.center,
                                                            style: CustomTextStylesCommon.commonStyle(
                                                              color: ColorManager.black,
                                                              fontSize: FontSize.s14,
                                                              fontWeight: FontWeight.w700,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(width: MediaQuery.of(context).size.width/ 35),
                                                  /// qus
                                                  Expanded(
                                                    child: Container(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          InfoText('Social Security No. :'),
                                                          InfoText('Drivers License No. :'),
                                                          InfoText('Clinician Type :'),
                                                          InfoText('Phone Number :'),
                                                          InfoText('Address :'),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  ///ans
                                                  Expanded(
                                                    child: Container(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          InfoData(general.ssnnbr ?? '--',),
                                                          InfoData(general.driverLicenseNum ?? '--'),
                                                          InfoData(general.employeeType ?? '--'),
                                                          InfoData(general.primaryPhoneNbr ?? '--'),
                                                          // MouseRegion(
                                                          //   onEnter: (event) =>
                                                          //       onboardingProviderState.showOverlayAddress(
                                                          //       context, event.position, general.finalAddress ?? '--'),
                                                          //   onExit: (_) => onboardingProviderState.removeOverlayAddress(),
                                                          //   child: InfoData(onboardingProviderState.trimmedAddress),
                                                          // ),

                                                          MouseRegion(
                                                              onEnter: (event) => _showOverlayAddress(
                                                                  context, event.position,general.finalAddress ?? '--'),
                                                              onExit: (_) => _removeOverlayAddress(),
                                                              child: InfoData(_trimAddress(general.finalAddress ?? '--'),)),

                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 30,),

                                                  ///qus
                                                  Expanded(
                                                    child: Container(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          InfoText('Date of Birth :'),
                                                          InfoText('Speciality :'),
                                                          InfoText('Employment :'),
                                                          InfoText('Service :'),
                                                          InfoText('Race :'),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  ///ans
                                                  Expanded(
                                                    child: Container(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          InfoData(general.dateOfBirth ?? '--'),
                                                          InfoData(general.expertise ?? '--'),
                                                          InfoData(general.employment ?? '--'),
                                                          InfoData(general.service ?? '--'),
                                                          InfoData(general.race ?? '--'),
                                                        ],
                                                      ),
                                                    ),
                                                  ),

                                                  SizedBox(width: 10,),

                                                  ///qus
                                                  Expanded(
                                                    child: Container(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          InfoText('Personal Email :'),
                                                          InfoText('City :'),
                                                          InfoText('Zone :'),
                                                          SizedBox(width: 12,height: 25,),
                                                          SizedBox(width: 12 ,height: 25,)
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  ///ans
                                                  Expanded(
                                                    child: Container(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          InfoData(general.personalEmail ?? '--'),
                                                          InfoData(general.city ?? '--'),
                                                          InfoData(general.zone ?? '--'),
                                                          SizedBox(width: 10,height: 25,),
                                                          SizedBox(width: 10 ,height: 25,)
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 40,),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,)
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(height: AppSize.s10),
                      PaginationControlsWidget(
                        currentPage: currentPage,
                        items: snapshot.data!,
                        itemsPerPage: itemsPerPage,
                        onPreviousPagePressed: () {
                          if (currentPage > 1) {
                            onboardingProviderState.setCurrentPage(currentPage - 1);
                          }
                        },
                        onPageNumberPressed: (pageNumber) {
                          onboardingProviderState.setCurrentPage(pageNumber);
                        },
                        onNextPagePressed: () {
                          if (currentPage < totalPages) {
                            onboardingProviderState.setCurrentPage(currentPage + 1);
                          }
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      }
    );
  }
}
///
// class _OnboardingGeneralState extends State<OnboardingGeneral> {
//   final StreamController<List<SeeAllData>> generalController =
//   StreamController<List<SeeAllData>>();
//   @override
//   void initState() {
//     super.initState();
//     getEmployeeSeeAll(context, ).then((data) {
//       final filteredData = data.where((item) =>
//       item.status == 'Partial' || item.status == 'Enrolled' || item.status == 'Completed').toList();
//       generalController.add(filteredData);
//     }).catchError((error) {});
//   }
//   int currentPage = 1;
//   final int itemsPerPage = 10;
//   final int totalPages = 5;
//
//   List<SeeAllData> allData = [];
//   String _selectedValue = 'Sort';
//
//   void onPageNumberPressed(int pageNumber) {
//     setState(() {
//       currentPage = pageNumber;
//     });
//   }
//   String _trimAddress(String address) {
//     const int maxLength = 15;
//     if (address.length > maxLength) {
//       return '${address.substring(0, maxLength)}...';
//     }
//     return address;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double containerWidth = MediaQuery.of(context).size.width * 0.9;
//     return Column(
//       children: [
//         buildDropdownButton(context),
//         Expanded(
//           child: StreamBuilder<List<SeeAllData>>(
//             stream: generalController.stream,
//             builder: (context, snapshot) {
//               print('1111111');
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(
//                   child: CircularProgressIndicator(
//                     color: ColorManager.blueprime,
//                   ),
//                 );
//               }
//               if (snapshot.data!.isEmpty) {
//                 return Center(
//                   child: Text(
//                     AppStringHRNoData.noOnboardingData,
//                     style: AllNoDataAvailable.customTextStyle(context),
//                   ),
//                 );
//               }
//               if (snapshot.hasData) {
//                 int totalItems = snapshot.data!.length;
//                 int totalPages = (totalItems / itemsPerPage).ceil();
//                 List<SeeAllData> paginatedData = snapshot.data!.skip((currentPage - 1) * itemsPerPage).take(itemsPerPage).toList();
//                 return Column(
//                   children: [
//                     Expanded(
//                       child: ListView.builder(
//                           scrollDirection: Axis.vertical,
//                           itemCount: paginatedData.length,
//                           itemBuilder: (context, index) {
//                             int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
//                             String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
//                             SeeAllData general = paginatedData[index];
//                             String fullName =
//                                 '${general.firstName?.capitalizeFirst ?? ''} ${general.lastName?.capitalizeFirst ?? ''}';
//
//                             return Column(
//                               children: [
//                                 Material(
//                                   color: ColorManager.white,
//                                   elevation: 4,
//                                   borderRadius: BorderRadius.circular(20),
//                                   child: Container(
//                                     width: containerWidth,
//                                     //height: AppSize.s181,
//                                     decoration: BoxDecoration(
//                                       color: ColorManager.white,
//                                       borderRadius: BorderRadius.circular(20),
//                                     ),
//                                     child: Column(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           mainAxisAlignment: MainAxisAlignment.end,
//                                           crossAxisAlignment: CrossAxisAlignment.end,
//                                           children: [
//                                             ///status
//                                             Container(
//                                                 width: AppSize.s88,
//                                                 height: AppSize.s20,
//                                                 decoration: BoxDecoration(
//                                                   color: general.status == 'Opened'
//                                                       ? const Color(0xff51B5E6)
//                                                       : general.status == 'Partial'
//                                                       ? const Color(0xffCA8A04)
//                                                       : const Color(0xffB4DB4C),
//                                                   borderRadius: BorderRadius.only(
//                                                       topRight:
//                                                       Radius.circular(20)),),
//                                                 child: Center(
//                                                   child: Text(
//                                                       general.status.toString(),
//                                                       textAlign: TextAlign.center,
//                                                       style: CustomTextStylesCommon.commonStyle(
//                                                           color: ColorManager.white,
//                                                           fontSize: FontSize.s13,
//                                                           fontWeight: FontWeight.w700)),
//                                                 )),
//                                           ],
//                                         ),
//                                         SizedBox(height: AppSize.s5),
//                                         Padding(
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal:
//                                               MediaQuery.of(context).size.width /
//                                                   60),
//                                           child: InkWell(
//                                             onTap: () => widget.selectButton(1,snapshot.data![index].empId!,fullName), // Corrected reference
//                                             child: Row(
//                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                               children: [
//                                                 ///profile pic and name
//                                                 Column(
//                                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                                   children: [
//                                                     CircleAvatar(
//                                                       radius: MediaQuery.of(context).size.width / 50,
//                                                       backgroundColor: Colors.white,
//                                                       child:
//                                                       ClipOval(
//                                                         child: CachedNetworkImage(
//                                                           imageUrl: general.imgurl!,
//                                                           placeholder: (context, url) => CircularProgressIndicator(),
//                                                           errorWidget: (context, url, error) =>
//                                                               CircleAvatar(child: Image.asset("images/profilepic.png"),),
//                                                           width: double.infinity,
//                                                           height: double.infinity,
//                                                           fit: BoxFit.cover,
//                                                         ),
//                                                       ),
//                                                     ),
//
//                                                     ///profile image
//                                                     SizedBox(height: MediaQuery.of(context).size.height / 40),
//                                                     ///name of the Person
//                                                     Container(
//                                                       height: AppSize.s40,
//                                                       width: MediaQuery.of(context).size.width/18,
//                                                       child: Align(
//                                                         alignment: Alignment.center,
//                                                         child: Text(
//                                                           '${general.firstName?.capitalizeFirst ?? ''} ${general.lastName?.capitalizeFirst ?? ''}',
//                                                           textAlign: TextAlign.center,
//                                                           style: CustomTextStylesCommon.commonStyle(
//                                                             color: ColorManager.black,
//                                                             fontSize: FontSize.s14,
//                                                             fontWeight: FontWeight.w700,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 SizedBox(width: MediaQuery.of(context).size.width/ 35),
//                                                 /// qus
//                                                 Expanded(
//                                                   child: Container(
//                                                     child: Column(
//                                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                                       children: [
//                                                         InfoText('Social Security No. :'),
//                                                         InfoText('Drivers License No. :'),
//                                                         InfoText('Clinician Type :'),
//                                                         InfoText('Phone Number :'),
//                                                         InfoText('Address :'),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 ///ans
//                                                 Expanded(
//                                                   child: Container(
//                                                     child: Column(
//                                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                                       children: [
//                                                         InfoData(general.ssnnbr ?? '--',),
//                                                         InfoData(general.driverLicenseNum ?? '--'),
//                                                         InfoData(general.employeeType ?? '--'),
//                                                         InfoData(general.primaryPhoneNbr ?? '--'),
//                                                         InfoData(_trimAddress(general.finalAddress ?? '--'),),
//
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 SizedBox(width: 30,),
//
//                                                 ///qus
//                                                 Expanded(
//                                                   child: Container(
//                                                     child: Column(
//                                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                                       children: [
//                                                         InfoText('Date of Birth :'),
//                                                         InfoText('Speciality :'),
//                                                         InfoText('Employment :'),
//                                                         InfoText('Service :'),
//                                                         InfoText('Race :'),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 ///ans
//                                                 Expanded(
//                                                   child: Container(
//                                                     child: Column(
//                                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                                       children: [
//                                                         InfoData(general.dateOfBirth ?? '--'),
//                                                         InfoData(general.expertise ?? '--'),
//                                                         InfoData(general.employment ?? '--'),
//                                                         InfoData(general.service ?? '--'),
//                                                         InfoData(general.race ?? '--'),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//
//                                                 SizedBox(width: 10,),
//
//                                                 ///qus
//                                                 Expanded(
//                                                   child: Container(
//                                                     child: Column(
//                                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                                       children: [
//                                                         InfoText('Personal Email :'),
//                                                         InfoText('City :'),
//                                                         InfoText('Zone :'),
//                                                         SizedBox(width: 12,height: 25,),
//                                                         SizedBox(width: 12 ,height: 25,)
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 ///ans
//                                                 Expanded(
//                                                   child: Container(
//                                                     child: Column(
//                                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                                       children: [
//                                                         InfoData(general.personalEmail ?? '--'),
//                                                         InfoData(general.city ?? '--'),
//                                                         InfoData(general.zone ?? '--'),
//                                                         SizedBox(width: 10,height: 25,),
//                                                         SizedBox(width: 10 ,height: 25,)
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 SizedBox(width: 40,),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: AppSize.s10,
//                                 )
//                               ],
//                             );
//                           }),
//                     ),
//                     SizedBox(height: AppSize.s10),
//                     PaginationControlsWidget(
//                       currentPage: currentPage,
//                       items: snapshot.data!,
//                       itemsPerPage: itemsPerPage,
//                       onPreviousPagePressed: () {
//                         setState(() {
//                           currentPage = currentPage > 1 ? currentPage - 1 : 1;
//                         });
//                       },
//                       onPageNumberPressed: (pageNumber) {
//                         setState(() {
//                           currentPage = pageNumber;
//                         });
//                       },
//                       onNextPagePressed: () {
//                         setState(() {
//                           currentPage = currentPage < totalPages ? currentPage + 1 : totalPages;
//                         });
//                       },
//                     ),
//                     SizedBox(height: AppSize.s5),
//                   ],
//                 );
//               }
//               return Offstage();
//             },
//           ),
//         )
//       ],
//     );
//   }
//   Widget buildDropdownButton(BuildContext context) {
//     final Map<String, String> displayTextMap = {
//       'Sort': 'Sort',
//       'Enrolled': 'Enrolled',
//       'Partial': 'Partial',
//       'Completed': 'Completed',
//     };
//
//     return Column(
//       children: [
//         DropdownButton2<String>(
//           value: _selectedValue,
//           onChanged: (String? newValue) {
//             setState(() {
//               _selectedValue = newValue!;
//               filterData();
//             });
//           },
//           style: TransparentButtonTextConst.customTextStyle(context),
//           iconStyleData: const IconStyleData(
//             icon: Icon(
//               Icons.arrow_drop_down,
//               color: Color(0xff50B5E5),
//             ),
//           ),
//           // iconSize: 20,
//           underline: const SizedBox(),
//           buttonStyleData: ButtonStyleData(
//             height: 31,
//             width: 130,
//             padding: const EdgeInsets.symmetric(horizontal: 8),  // Internal padding.
//             elevation: 2,  // Shadow depth.
//             decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border.all(color: const Color(0xff50B5E5), width: 1.2),
//               borderRadius: BorderRadius.circular(12.0),
//               boxShadow: [
//                 BoxShadow(
//                   color: const Color(0xff000000).withOpacity(0.25),
//                   blurRadius: 2,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             overlayColor: WidgetStateProperty.all(Colors.grey.withOpacity(0.1)),  // Background color when pressed.
//           ),
//           /// buttonPadding: const EdgeInsets.symmetric(horizontal: 8),
//           // dropdownMaxHeight: 200,
//           // dropdownDecoration: BoxDecoration(
//           //   borderRadius: BorderRadius.circular(12),
//           //   color: Colors.white,
//           // ),
//           // itemPadding: const EdgeInsets.symmetric(horizontal: 8), // Updated padding
//           selectedItemBuilder: (context) => displayTextMap.keys.map((String value) {
//             return Align(
//               alignment: Alignment.center,
//               child: Text(displayTextMap[value]!),
//             );
//           }).toList(),
//           items: displayTextMap.keys.map((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(displayTextMap[value]!),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
//
//
//   void filterData() {
//     String selectedStatus = _selectedValue.trim().toLowerCase();
//
//     if (selectedStatus == 'sort') {
//       generalController.add(allData);
//     } else {
//       List<SeeAllData> filteredData = allData.where((data) {
//         String dataStatus = data.status!.trim().toLowerCase();
//         bool matches = dataStatus == selectedStatus;
//         print("Checking ${data.status}: $matches");
//         return matches;
//       }).toList();
//       generalController.add(filteredData);
//     }
//   }
//
// }

class InfoText extends StatelessWidget {
  final String text;

  const InfoText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(text, style: TextStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeight.w600,
            color: ColorManager.black),),
        const SizedBox(height: AppSize.s10),
      ],
    );
  }
}

class InfoData extends StatelessWidget {
  final String text;

  const InfoData(
      this.text,
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(text,style: TextStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeight.w400,
            color: ColorManager.mediumgrey),),
        const SizedBox(height: AppSize.s10),
      ],
    );
  }
}
