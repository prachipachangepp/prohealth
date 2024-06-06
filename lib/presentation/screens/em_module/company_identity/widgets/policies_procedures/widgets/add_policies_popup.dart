import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';

class AddPoliciesPopup extends StatelessWidget {
  const AddPoliciesPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        child: Container(
          width: 400.0,
          height: 480.0,
          // padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5.0,
                offset: Offset(0.0, 3.0),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 10),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.close)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name of the Document',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5,),
                    TextFormField(
                      //   controller: controller,
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder:OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54, width: 1),
                            borderRadius: BorderRadius.circular(10)),),
                    ),

                  ],
                ),
                SizedBox(height: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ID of the Document',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5,),
                    TextFormField(
                      //   controller: controller,
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder:OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54, width: 1),
                            borderRadius: BorderRadius.circular(10)),),
                    ),

                  ],
                ),
                SizedBox(height: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Type of the Document',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5,),
                    CICCDropdown(
                      initialValue: 'Policies & Procedures',
                      items: [
                        DropdownMenuItem(value: 'Policies & Procedures', child: Text('Policies & Procedures')),
                        DropdownMenuItem(value: 'HCO Number      254612', child: Text('HCO Number  254612')),
                        DropdownMenuItem(value: 'Medicare ID      MPID123', child: Text('Medicare ID  MPID123')),
                        DropdownMenuItem(value: 'NPI Number     1234567890', child: Text('NPI Number 1234567890')),
                      ],),
                  // DropdownButtonFormField(items: ["Policies & Procedures"], onChanged: (val){})

                  ],
                ),



                Spacer(),
                // SizedBox(height: 10.0),
                Center(child: CustomIconButton(text: "Submit", onPressed: (){}))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
