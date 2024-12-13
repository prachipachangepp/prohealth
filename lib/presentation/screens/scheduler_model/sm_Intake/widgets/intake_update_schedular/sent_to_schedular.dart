import 'package:flutter/material.dart';
import 'package:prohealth/presentation/widgets/widgets/constant_textfield/const_textfield.dart';

import '../../../../../../app/resources/color.dart';

class SentToSchedularScreen extends StatelessWidget {
  const SentToSchedularScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _searchController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80.0),
      child: Column(
        children: [
          ///button
          Row(
            //crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 320,
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  textInputAction: TextInputAction.search,
                  //onSubmitted: (value) => _performSearch(),
                  decoration: InputDecoration(
                    hintText: "Search location",
                    suffixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 7),
                  ),
                ),
              ),
              Row(
                children: [
                  CustomDropdownTextField(
                    width: 150,
                    isAstric:false,
                    // Adjust headText based on depId
                    initialValue: 'Employee Type',
                    headText: "", // Default fallback if depId doesn't match any of the expected values
                    items: ['Employee 1','Employee 2','Employee 3'],
                    onChanged: (newValue) {
                      // for (var a in snapshot.data!) {
                      //   if (a.empType == newValue) {
                      //     clinicialName = a.empType!;
                      //     clinicalId = a.employeeTypesId!;
                      //     print("Dept ID'''''' ${clinicalId}");
                      //     print("';';';''''''''Dept ID ${clinicialName}");
                      //     // Do something with docType
                      //   }
                      // }
                    },
                  ),
                  SizedBox(width: 10,),
                  CustomDropdownTextField(
                    width:150,
                    isAstric:false,
                    // Adjust headText based on depId
                    initialValue: 'Clinician Type',
                    headText: "", // Default fallback if depId doesn't match any of the expected values
                    items: ['Clinical 1','Clinical 2','Clinical 3'],
                    onChanged: (newValue) {
                      // for (var a in snapshot.data!) {
                      //   if (a.empType == newValue) {
                      //     clinicialName = a.empType!;
                      //     clinicalId = a.employeeTypesId!;
                      //     print("Dept ID'''''' ${clinicalId}");
                      //     print("';';';''''''''Dept ID ${clinicialName}");
                      //     // Do something with docType
                      //   }
                      // }
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
