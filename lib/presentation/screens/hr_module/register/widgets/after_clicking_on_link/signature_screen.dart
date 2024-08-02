import 'dart:ui';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/progress_form_manager/offer_letter_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/bottom_row.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/after_clicking_on_link/declination_form_screen.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/after_clicking_on_link/offer_letter_description_screen.dart';
import 'package:signature/signature.dart';
import 'dart:typed_data';

import '../../../manage/widgets/top_row.dart';
import 'form_nine_screen.dart';

typedef ImageCallback = void Function(Uint8List? image);
class SignaturePage extends StatefulWidget {
  final Function(Uint8List?) onSignatureSelected;
  final int employeeId;
  SignaturePage({required this.onSignatureSelected, required this.employeeId});

  @override
  _SignaturePageState createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {
  bool _isDrawing = true;
  List<Offset?> _points = [];
  Uint8List? _selectedImageBytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: TopRowConstant(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                width: 1200,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Signature',
                          style: GoogleFonts.firaSans(
                            fontSize: 18,
                            color: Color(0xFF50B5E5),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 6),
                      Text(
                        'Upload Signature',
                        style: GoogleFonts.firaSans(
                          fontSize: 16,
                          color: Color(0xFF50B5E5),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 40),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Color(0xFFE6F7FF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Signature is needed to sign the declination form and few other forms',
                          style: GoogleFonts.firaSans(
                            color: Color(0xFF686464),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextButton.icon(
                                icon: Icon(Icons.edit, color: Color(0xFF50B5E5), size: 24),
                                label: Text(
                                  'Draw',
                                  style: GoogleFonts.firaSans(
                                      color: Color(0xFF50B5E5),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isDrawing = true;
                                    _selectedImageBytes = null;
                                  });
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 2),
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                              Container(
                                height: 2,
                                width: 85,
                                color: _isDrawing ? Color(0xFF50B5E5) : Colors.transparent,
                              ),
                            ],
                          ),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextButton.icon(
                                icon: Icon(Icons.file_upload_outlined, color: Colors.grey, size: 24),
                                label: Text(
                                  'Upload',
                                  style: GoogleFonts.firaSans(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700
                                  ),
                                ),
                                onPressed: _pickFile,
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 2),
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                              Container(
                                height: 2,
                                color: !_isDrawing ? Color(0xFF50B5E5) : Colors.transparent,
                              ),
                            ],
                          ),
                          Expanded(child: Container()),
                        ],
                      ),
                      Divider(color: Colors.grey[300]),
                      SizedBox(height: MediaQuery.of(context).size.height / 30),
                      Center(
                        child: Text(
                          _isDrawing
                              ? 'Sign your name using mouse or touchpad'
                              : 'Uploaded signature',
                          style: GoogleFonts.firaSans(
                            color: Color(0xff68646480),
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 30),
                      Center(
                        child: Container(
                          height: 389,
                          width: 947,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: ClipRect(
                            child: _selectedImageBytes != null && !_isDrawing
                                ? Image.memory(
                              _selectedImageBytes!,
                              fit: BoxFit.contain,
                            )
                                : GestureDetector(
                              onPanUpdate: (details) {
                                setState(() {
                                  RenderBox renderBox = context.findRenderObject() as RenderBox;
                                  Offset localPosition = renderBox.globalToLocal(details.globalPosition);
                                  print("Drawing at: $localPosition"); // Debugging
                                  _points.add(localPosition);
                                });
                              },
                              onPanEnd: (details) {
                                _points.add(null);
                              },
                              child: CustomPaint(
                                painter: SignaturePainter(points: _points),
                                size: Size.infinite,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 15),
                      Padding(
                        padding: EdgeInsets.only(left: 110.0),
                        child: Row(
                          children: [
                            ElevatedButton(
                              child: Text(
                                'Cancel',
                                style: GoogleFonts.firaSans(
                                  color: Color(0xFF50B5E5),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  _isDrawing = true;
                                  _points.clear();
                                  _selectedImageBytes = null;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Color(0xff50B5E5),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: BorderSide(color: Color(0xff50B5E5), width: 1.5)),
                              ),
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width / 5),
                            Row(
                              children: [
                                ElevatedButton(
                                  child: Text(
                                    'Reset',
                                    style: GoogleFonts.firaSans(
                                      color: Color(0xFF50B5E5),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _points.clear();
                                      _selectedImageBytes = null;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Color(0xff50B5E5),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: BorderSide(color: Color(0xff50B5E5), width: 1.5)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width / 80),
                            ElevatedButton(
                              child: Text(
                                'Save',
                                style: GoogleFonts.firaSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                              onPressed: () {
                                _saveSignature();
                                _showSaveConfirmationDialog();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff50B5E5),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 6),
            BottomBarRow()
          ],
        ),
      ),
    );
  }
  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single.bytes != null) {
      setState(() {
        _selectedImageBytes = result.files.single.bytes!;
        _isDrawing = false;
      });
    }
  }

  Future<void> _saveSignature() async {
    if (_isDrawing) {
      // Convert drawing to image bytes
      _selectedImageBytes = await convertPointsToImage();
    }
    // Perform further actions with _selectedImageBytes
    widget.onSignatureSelected(_selectedImageBytes);
  }

  Future<Uint8List?> convertPointsToImage() async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder, Rect.fromPoints(Offset(0, 0), Offset(400, 400))); // Adjust size as needed
    final paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < _points.length - 1; i++) {
      if (_points[i] != null && _points[i + 1] != null) {
        canvas.drawLine(_points[i]!, _points[i + 1]!, paint);
      }
    }

    final picture = recorder.endRecording();
    final img = await picture.toImage(400, 400); // Adjust size as needed
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }
  void _showSaveConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Container(
              width: 551,
              height: 532,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset('images/sign_saving.svg'),
                  SizedBox(height: MediaQuery.of(context).size.height / 20),
                  Text(
                    'Successfully saved!',
                    style: GoogleFonts.firaSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: Color(0xff686464)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 25),
                  Container(
                    width: 120,
                    height: 90,
                    child: ClipRect(
                      child: _selectedImageBytes != null
                          ? Image.memory(
                        _selectedImageBytes!,
                        fit: BoxFit.contain,
                      )
                          : CustomPaint(
                        painter: PopupSignaturePainter(
                          points: _points,
                          originalSize: Size(947, 389),
                          targetSize: Size(120, 90),
                        ),
                        size: Size(120, 90),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 25),
                  ElevatedButton(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Continue',
                          style: GoogleFonts.firaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width / 140),
                        Icon(
                          Icons.arrow_right_alt_outlined,
                          size: 24,
                        ),
                      ],
                    ),
                    onPressed: () async{
                      print("Signature ${_selectedImageBytes}");
                     await uploadSignature(context,widget.employeeId,_selectedImageBytes);
                     Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OfferLetterDescriptionScreen(
                            signatureBytes: _selectedImageBytes,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff50B5E5),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
///
  // void _pickFile() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.image,
  //   );
  //
  //   if (result != null && result.files.single.bytes != null) {
  //     setState(() {
  //       _selectedImageBytes = result.files.single.bytes;
  //       _isDrawing = false;
  //       _points.clear();
  //     });
  //   }
  // }
  //
  //
  // void _saveSignature() {
  //   if (_selectedImageBytes != null) {
  //     widget.onSignatureSelected(_selectedImageBytes);
  //   } else if (_points.isNotEmpty) {
  //     _convertPointsToImage().then((imageBytes) {
  //       widget.onSignatureSelected(imageBytes);
  //     });
  //   } else {
  //     widget.onSignatureSelected(null);
  //   }
  // }
  //
  // Future<Uint8List> _convertPointsToImage() async {
  //   /// Convert the points to an image
  //   final recorder = PictureRecorder();
  //   final canvas = Canvas(recorder, Rect.fromPoints(Offset(0, 0), Offset(947, 389)));
  //   final painter = SignaturePainter(points: _points);
  //   painter.paint(canvas, Size(947, 389));
  //   final picture = recorder.endRecording();
  //   final img = await picture.toImage(947.toInt(), 389.toInt());
  //   final byteData = await img.toByteData(format: ImageByteFormat.png);
  //   return byteData!.buffer.asUint8List();
  // }

  ///

class SignaturePainter extends CustomPainter {
  final List<Offset?> points;

  SignaturePainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


class PopupSignaturePainter extends CustomPainter {
  final List<Offset?> points;
  final Size originalSize;
  final Size targetSize;

  PopupSignaturePainter({
    required this.points,
    required this.originalSize,
    required this.targetSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;

    double scaleX = targetSize.width / originalSize.width;
    double scaleY = targetSize.height / originalSize.height;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(
          Offset(points[i]!.dx * scaleX, points[i]!.dy * scaleY),
          Offset(points[i + 1]!.dx * scaleX, points[i + 1]!.dy * scaleY),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(PopupSignaturePainter oldDelegate) => true;
}