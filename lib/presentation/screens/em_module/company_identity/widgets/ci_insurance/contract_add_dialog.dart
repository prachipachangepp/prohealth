import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';

class ContractAddDialog extends StatefulWidget {
  final TextEditingController contractNmaeController;
  final TextEditingController contractIdController;
  final VoidCallback onPressed;
  const ContractAddDialog({Key? key,required this.contractNmaeController, required this.onPressed, required this.contractIdController}) : super(key: key);

  @override
  State<ContractAddDialog> createState() => _ContractAddDialogState();
}

class _ContractAddDialogState extends State<ContractAddDialog> {
  @override
  Widget build(BuildContext context) {
    String selectedOption = '';
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
                      'Contract Name',
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
                      'Contract ID',
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
                      'Expiry Type',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5,),
                    RadioListTile(
                      title: Text('Not Applicable',style: TextStyle(fontSize: 11),),
                      value: 'Option 1',
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value!;
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text('Schedule',style: TextStyle(fontSize: 11),),
                      value: 'Option 2',
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value!;
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text('Issue Expiry',style: TextStyle(fontSize: 11),),
                      value: 'Option 3',
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value!;
                        });
                      },
                    ),

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
