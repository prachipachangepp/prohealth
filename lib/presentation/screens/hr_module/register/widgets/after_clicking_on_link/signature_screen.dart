import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:prohealth/app/resources/const_string.dart';

import '../../../manage/widgets/top_row.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignaturePage(),
    );
  }
}

class SignaturePage extends StatefulWidget {
  @override
  _SignaturePageState createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {
  bool _isDrawing = true;
  List<Offset?> _points = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: TopRowConstant(),
      ),
      body: Padding(
        padding:  EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppString.upload_signature,
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF50B5E5),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: Color(0xFFE6F7FF),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Signature is needed to sign the declination form and few other forms',
                style: TextStyle(color: Color(0xFF50B5E5)),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      TextButton.icon(
                        icon: Icon(Icons.edit, color: Color(0xFF50B5E5), size: 24),
                        label: Text(AppString.draw,
                            style: TextStyle(
                                color: Color(0xFF50B5E5),
                                fontSize: 16)),
                        onPressed: () {
                          setState(() {
                            _isDrawing = true;
                          });
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          alignment: Alignment.center,
                        ),
                      ),
                      Container(
                        height: 2,
                        color: _isDrawing ? Color(0xFF50B5E5) : Colors.transparent,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    children: [
                      TextButton.icon(
                        icon: Icon(Icons.upload_file, color: Colors.grey, size: 24),
                        label: Text(AppString.upload,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16)),
                        onPressed: _pickFile,
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          alignment: Alignment.center,
                        ),
                      ),
                      Container(
                        height: 2,
                        color: !_isDrawing ? Color(0xFF50B5E5) : Colors.transparent,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Divider(color: Colors.grey[300]),
            SizedBox(height: 16),
            Center(
              child: Text(
                'Sign your name using mouse or touchpad',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: Container(
                height: 389,
                width: 947,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      RenderBox renderBox = context.findRenderObject() as RenderBox;
                      _points.add(renderBox.globalToLocal(details.globalPosition));
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
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Text(AppString.cancle,
                      style: TextStyle(color: Colors.grey)),
                  onPressed: () {
                    setState(() {
                      _isDrawing = false;
                      _points.clear();
                    });
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                TextButton(
                  child: Text(AppString.reset,
                      style: TextStyle(color: Color(0xFF50B5E5))),
                  onPressed: () {
                    setState(() {
                      _points.clear();
                    });
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                ElevatedButton(
                  child: Text(AppString.save),
                  onPressed: _saveSignature,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFF50B5E5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      // Handle the uploaded file
      print('File picked: ${result.files.single.name}');
    }
  }

  void _saveSignature() {
    if (_points.isNotEmpty) {
      // Here you would typically convert the points to an image
      // For now, we'll just print a message
      print('Signature saved with ${_points.length} points');
    } else {
      print('No signature to save');
    }
  }
}

class SignaturePainter extends CustomPainter {
  final List<Offset?> points;

  SignaturePainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
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
  bool shouldRepaint(SignaturePainter oldDelegate) => true;
}


