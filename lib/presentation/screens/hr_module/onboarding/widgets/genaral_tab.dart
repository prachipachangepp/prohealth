import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/presentation/widgets/widgets/profile_bar/widget/pagination_widget.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/const_string.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../app/resources/theme_manager.dart';
import '../../../../../../app/resources/value_manager.dart';
import '../../../../../app/services/api/managers/hr_module_manager/see_all/see_all_manager.dart';
import '../../../../../data/api_data/hr_module_data/see_all_data/see_all_data.dart';

class OnboardingGeneral extends StatefulWidget {
  final void Function(int,int) selectButton;
  const OnboardingGeneral({Key? key, required this.selectButton}) : super(key: key);

  @override
  State<OnboardingGeneral> createState() => _OnboardingGeneralState();
}

class _OnboardingGeneralState extends State<OnboardingGeneral> {
  final StreamController<List<SeeAllData>> generalController =
  StreamController<List<SeeAllData>>();
  @override
  void initState() {
    super.initState();
    getEmployeeSeeAll(context).then((data) {
      final filteredData = data.where((item) =>
      item.status == 'Partial' || item.status == 'Opened' || item.status == 'Completed').toList();
      generalController.add(filteredData);
    }).catchError((error) {});
  }
  int currentPage = 1;
  final int itemsPerPage = 10;
  final int totalPages = 5;

  void onPageNumberPressed(int pageNumber) {
    setState(() {
      currentPage = pageNumber;
    });
  }
  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width * 0.9;
    double containerHeight = MediaQuery.of(context).size.height * 0.2;
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<List<SeeAllData>>(
            stream: generalController.stream,
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
                    AppStringHRNoData.noOnboardingData,
                    style: AllNoDataAvailable.customTextStyle(context),
                  ),
                );
              }
              if (snapshot.hasData) {
                int totalItems = snapshot.data!.length;
                int totalPages = (totalItems / itemsPerPage).ceil();
                List<SeeAllData> paginatedData = snapshot.data!.skip((currentPage - 1) * itemsPerPage).take(itemsPerPage).toList();
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: paginatedData.length,
                          itemBuilder: (context, index) {
                            int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
                            String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
                            SeeAllData general = paginatedData[index];
                            return Column(
                              children: [
                                Material(
                                  color: ColorManager.white,
                                  elevation: 4,
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    width: containerWidth,
                                    height: AppSize.s181,
                                    decoration: BoxDecoration(
                                      color: ColorManager.white,
                                      borderRadius: BorderRadius.circular(20),
                                      // border: Border.all(
                                      //   width: AppSize.s1,
                                      //   color: ColorManager.white,
                                      // ),
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
                                                    color: general.status == 'Opened'
                                                        ? const Color(0xff51B5E6)
                                                        : general.status == 'Partial'
                                                        ? const Color(0xffCA8A04)
                                                        : const Color(0xffB4DB4C),
                                                    borderRadius: BorderRadius.only(
                                                        topRight:
                                                        Radius.circular(20)),),
                                                child: Center(
                                                  child: Text(
                                                      general.status.toString(),
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
                                            onTap: () => widget.selectButton(1,snapshot.data![index].empId!), // Corrected reference
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                ///profile pic and name
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    CircleAvatar(
                                                      radius: MediaQuery.of(context).size.width / 50,
                                                      backgroundColor: Colors.white,
                                                      child: general.imgurl! == 'imgurl' || general.imgurl! == null
                                                          ? Icon(
                                                        Icons.person,
                                                        color: ColorManager.bluelight,
                                                        size: AppSize.s50,
                                                      )
                                                          : ClipOval(
                                                        child: CachedNetworkImage(
                                                          imageUrl: general.imgurl!,
                                                          placeholder: (context, url) => CircularProgressIndicator(),
                                                          errorWidget: (context, url, error) => Icon(Icons.error),
                                                          width: double.infinity,
                                                          height: double.infinity,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),

                                                    ///profile image
                                                    // CircleAvatar(
                                                    //   radius: MediaQuery.of(context).size.width / 50,
                                                    //  backgroundColor: Colors.white,
                                                    //  // backgroundColor: Colors.grey,
                                                    //   child: general.imgurl! == 'imgurl' ||
                                                    //       general.imgurl! == null ?
                                                    //
                                                    //   Icon(
                                                    //     Icons.person,
                                                    //     color: ColorManager.bluelight,
                                                    //     size: AppSize.s50,
                                                    //   ) :
                                                    //   CachedNetworkImage(
                                                    //     imageUrl: general.imgurl!,
                                                    //     placeholder: (context, url) => new CircularProgressIndicator(),
                                                    //     errorWidget: (context, url, error) => new Icon(Icons.error),
                                                    //     width: AppSize.s70,
                                                    //     height: AppSize.s70,
                                                    //   ),
                                                    //
                                                    // ),
                                                    SizedBox(height: MediaQuery.of(context).size.height / 40),
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
                                                        InfoData(general.type ?? '--'),
                                                        InfoData(general.primaryPhoneNbr ?? '--'),
                                                        InfoData(general.finalAddress ?? '--'),

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
                                SizedBox(
                                  height: AppSize.s5,
                                )
                              ],
                            );
                          }),
                    ),
                    SizedBox(height: AppSize.s5),
                    PaginationControlsWidget(
                      currentPage: currentPage,
                      items: snapshot.data!,
                      itemsPerPage: itemsPerPage,
                      onPreviousPagePressed: () {
                        setState(() {
                          currentPage = currentPage > 1 ? currentPage - 1 : 1;
                        });
                      },
                      onPageNumberPressed: (pageNumber) {
                        setState(() {
                          currentPage = pageNumber;
                        });
                      },
                      onNextPagePressed: () {
                        setState(() {
                          currentPage = currentPage < totalPages ? currentPage + 1 : totalPages;
                        });
                      },
                    ),
                    SizedBox(height: AppSize.s5),
                  ],
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
