import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';

class ViewBatchesPopup extends StatefulWidget {
  const ViewBatchesPopup({super.key});

  @override
  State<ViewBatchesPopup> createState() => _ViewBatchesPopupState();
}

class _ViewBatchesPopupState extends State<ViewBatchesPopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s850,
        height: AppSize.s600,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Batches",style: GoogleFonts.firaSans(
                    fontSize: FontSize.s16,
                    fontWeight: FontWeightManager.bold,
                    color: ColorManager.mediumgrey,
                    decoration: TextDecoration.none,
                  ),),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p3,
                horizontal: AppPadding.p20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                            'Sr No',
                            style: GoogleFonts.firaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                            ),
                          ),
//SizedBox(width: MediaQuery.of(context).size.width/7.5,),
                          Text('Start Time',textAlign: TextAlign.start,
                              style: GoogleFonts.firaSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                              )),
                          Text('End Time',textAlign: TextAlign.start,
                              style: GoogleFonts.firaSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                              )),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text('Actions',
                                textAlign: TextAlign.start,
                                style: GoogleFonts.firaSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height/1.5,
                    child:
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: 15,
                        itemBuilder: (context, index) {
                          // int serialNumber =
                          //     index + 1 + (currentPage - 1) * itemsPerPage;
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
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            "0",
                                            // formattedSerialNumber,
                                            style: GoogleFonts.firaSans(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff686464),
                                              decoration: TextDecoration.none,
                                            ),
                                          ),
                                          // Text(''),
                                          Text(
                                            "1:00 PM",textAlign:TextAlign.center,
                                            style: GoogleFonts.firaSans(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff686464),
                                              decoration: TextDecoration.none,
                                            ),
                                          ),
                                          Text(
                                            "4:00 PM",textAlign:TextAlign.center,
                                            style: GoogleFonts.firaSans(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff686464),
                                              decoration: TextDecoration.none,
                                            ),
                                          ),
                                          //  Text(''),
                                          Row(
                                            children: [
                                              IconButton(onPressed: (){
                                              }, icon: Icon(Icons.edit_outlined)),
                                              IconButton(onPressed: (){}, icon: Icon(Icons.delete_outline,color: ColorManager.red,)),
                                            ],
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          );
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
