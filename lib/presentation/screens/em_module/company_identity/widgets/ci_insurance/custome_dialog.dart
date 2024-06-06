import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/widgets/widgets/constant_textfield/const_textfield.dart';

class CustomPopup extends StatelessWidget {
   final TextEditingController controller;
   final VoidCallback onPressed;
   const CustomPopup({Key? key,required this.controller, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        child: Container(
          width: 400.0,
          height: 200.0,
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
                      'Vendor Name',
                      style: TextStyle(
                        fontSize: 15.0,
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
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54, width: 1),
                            borderRadius: BorderRadius.circular(15)),
                        focusedBorder:OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54, width: 1),
                            borderRadius: BorderRadius.circular(15)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54, width: 1),
                            borderRadius: BorderRadius.circular(15)),),
                    ),

                  ],
                ),

                Spacer(),
               // SizedBox(height: 10.0),
                Center(child: CustomIconButton(text: "Save", onPressed: (){}))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
