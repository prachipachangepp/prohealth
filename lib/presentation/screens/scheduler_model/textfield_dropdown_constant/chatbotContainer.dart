// import 'package:flutter/material.dart';
// import 'package:prohealth/app/resources/color.dart';
//
// import '../../../../app/resources/common_resources/common_theme_const.dart';
// import '../../../../app/resources/establishment_resources/establish_theme_manager.dart';
// import '../../../../app/resources/value_manager.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
//
// class ChatBotContainer extends StatefulWidget {
//   final VoidCallback onClose;
//
//   const ChatBotContainer({super.key, required this.onClose});
//
//   @override
//   State<ChatBotContainer> createState() => _ChatBotContainerState();
// }
//
// class _ChatBotContainerState extends State<ChatBotContainer> {
//
//   TextEditingController _textController = TextEditingController();
//
//   void _sendMessage() {
//     if (_textController.text.isNotEmpty) {
//       print("Message sent: ${_textController.text}");
//       _textController.clear();
//     }
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           padding: EdgeInsets.all(8),
//          // color: Colors.blue,
//          // color: Color(0xFFF7F8FA),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children:[
//               Row(
//                 children: [
//                   CircleAvatar(
//                     child:
//                     Image.asset('images/1.png',),
//                   ),
//                   SizedBox(width: AppSize.s7),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Alena',
//                         style:AllPopupHeadings.customTextStyle(context),
//                       ),
//                      // SizedBox(height: AppSize.s3),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                           color: Color(0xFF527FB9).withOpacity(0.5),
//                           width: 19,
//                           height: 19,
//                           child: Center(
//                             child: Text("ST",style: TextStyle(
//                               // fontWeight: FontWeight.w600,
//                               // fontSize: FontSize.s13,
//                               color: ColorManager.white,
//                               decoration: TextDecoration.none,
//                             ),),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   IconButton(
//                     splashColor: Colors.transparent,
//                     highlightColor: Colors.transparent,
//                     hoverColor: Colors.transparent,
//                     icon: Icon(Icons.videocam_rounded, color: ColorManager.blueBorder),
//                     onPressed: widget.onClose, // Call the close function
//                   ),
//                   IconButton(
//                     splashColor: Colors.transparent,
//                     highlightColor: Colors.transparent,
//                     hoverColor: Colors.transparent,
//                     icon: Icon(Icons.call_rounded, color: ColorManager.greenDark),
//                     onPressed: widget.onClose, // Call the close function
//                   ),
//                   IconButton(
//                     splashColor: Colors.transparent,
//                     highlightColor: Colors.transparent,
//                     hoverColor: Colors.transparent,
//                     icon: Icon(Icons.close,color: ColorManager.greylight),
//                     onPressed: widget.onClose, // Call the close function
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         Expanded(
//           child: Center(
//             child: Text(
//               "Here is the chatbot UI.",
//               style:DocumentTypeDataStyle.customTextStyle(context),
//             ),
//           ),
//         ),
//        // Divider(),
//         // Input Field & Send Button
//         Container (
//
//           padding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
//           color: Color(0xFFF7F8FA),
//           child: Row(
//             children: [
//               // Text Field with Smiley, Pin, and Send Button
//               Expanded(
//                 child: TextField(
// style: DocumentTypeDataStyle.customTextStyle(context),
//                   controller: _textController,
//                   cursorColor: Colors.black,
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.white,
//                     prefixIcon: Icon(Icons.insert_emoticon_outlined,color: ColorManager.greylight), // Smiley icon at the start
//                     suffixIcon: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           splashColor: Colors.transparent,
//                           highlightColor: Colors.transparent,
//                           hoverColor: Colors.transparent,
//                           onPressed: () {
//                             print("Pin icon clicked");
//                           },
//                           icon: Icon(Icons.attach_file_outlined,color: ColorManager.greylight),
//                         ),
//                         IconButton(
//                           splashColor: Colors.transparent,
//                           highlightColor: Colors.transparent,
//                           hoverColor: Colors.transparent,
//                           onPressed: () {
//                             print("Pin icon clicked");
//                           },
//                           icon: Icon(Icons.arrow_drop_down_sharp,color: ColorManager.greylight),
//                         ),
//                         IconButton(
//                           splashColor: Colors.transparent,
//                           highlightColor: Colors.transparent,
//                           hoverColor: Colors.transparent,
//                           onPressed: _sendMessage,
//                           icon: Icon(Icons.send,color: ColorManager.greylight),
//                         ),
//                       ],
//                     ),
//                     hintText: "Type a message...",
//                     hintStyle: DocumentTypeDataStyle.customTextStyle(context),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.white,),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.white, ),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(width: 8),
//               // Mic Icon Button inside a green circular container
//               GestureDetector(
//                 onTap: () {
//                   print("Mic button clicked");
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.green,
//                   ),
//                   padding: EdgeInsets.all(8),
//                   child: Icon(
//                     Icons.mic_none_outlined,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';


import '../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../app/resources/value_manager.dart';
//import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatBotContainer extends StatefulWidget {
  final VoidCallback onClose;

  const ChatBotContainer({super.key, required this.onClose});

  @override
  State<ChatBotContainer> createState() => _ChatBotContainerState();
}

class _ChatBotContainerState extends State<ChatBotContainer> {

  //TextEditingController _textController = TextEditingController();

  // void _sendMessage() {
  //   if (_textController.text.isNotEmpty) {
  //     print("Message sent: ${_textController.text}");
  //     _textController.clear();
  //   }
  // }

// Simulate chat messages locally using a list
  final List<String> _messages = []; // Message storage
  final TextEditingController _textController = TextEditingController();

  void _sendMessage() {
    if (_textController.text.isNotEmpty) {
      setState(() {
        _messages.add(_textController.text); // Save message locally
      });
      _textController.clear(); // Clear text field
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          // color: Colors.blue,
          // color: Color(0xFFF7F8FA),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              Row(
                children: [
                  CircleAvatar(
                    child:
                    Image.asset('images/1.png',),
                  ),
                  SizedBox(width: AppSize.s7),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Alena',
                        style:AllPopupHeadings.customTextStyle(context),
                      ),
                      // SizedBox(height: AppSize.s3),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Color(0xFF527FB9).withOpacity(0.5),
                          width: 19,
                          height: 19,
                          child: Center(
                            child: Text("ST",style: TextStyle(
                              // fontWeight: FontWeight.w600,
                              // fontSize: FontSize.s13,
                              color: ColorManager.white,
                              decoration: TextDecoration.none,
                            ),),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    icon: Icon(Icons.videocam_rounded, color: ColorManager.blueBorder),
                    onPressed: widget.onClose, // Call the close function
                  ),
                  IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    icon: Icon(Icons.call_rounded, color: ColorManager.greenDark),
                    onPressed: widget.onClose, // Call the close function
                  ),
                  IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    icon: Icon(Icons.close,color: ColorManager.greylight),
                    onPressed: widget.onClose, // Call the close function
                  ),
                ],
              ),
            ],
          ),
        ),



        Expanded(
          child: ListView.builder(
            reverse: true, // Show the latest messages at the bottom
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              return Container(
                alignment: Alignment.centerRight, // Align the message to the right
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueAccent, // Change the message bubble color
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    _messages[_messages.length - 1 - index],
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              );
            },
          ),
        ),

        // Expanded(
        //   child: ListView.builder(
        //     reverse: true, // Show the latest messages at the bottom
        //     itemCount: _messages.length,
        //     itemBuilder: (context, index) {
        //       return ListTile(
        //         title: Text(
        //           _messages[_messages.length - 1 - index],
        //           style: TextStyle(fontSize: 16),
        //         ),
        //       );
        //     },
        //   ),
        // ),


        // Divider(),
        // Input Field & Send Button
        Container (

          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
          color: Color(0xFFF7F8FA),
          child: Row(
            children: [
              // Text Field with Smiley, Pin, and Send Button
              Expanded(
                child: TextField(
                  style: DocumentTypeDataStyle.customTextStyle(context),
                  controller: _textController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.insert_emoticon_outlined,color: ColorManager.greylight), // Smiley icon at the start
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          onPressed: () {
                            print("Pin icon clicked");
                          },
                          icon: Icon(Icons.attach_file_outlined,color: ColorManager.greylight),
                        ),
                        IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          onPressed: () {
                            print("Pin icon clicked");
                          },
                          icon: Icon(Icons.arrow_drop_down_sharp,color: ColorManager.greylight),
                        ),
                        IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          onPressed: _sendMessage,
                          icon: Icon(Icons.send,color: ColorManager.greylight),
                        ),
                      ],
                    ),
                    hintText: "Type a message...",
                    hintStyle: DocumentTypeDataStyle.customTextStyle(context),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white,),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              // Mic Icon Button inside a green circular container
              GestureDetector(
                onTap: () {
                  print("Mic button clicked");
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.mic_none_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
