import 'package:flutter/material.dart';

class CertificateOfCompletion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: TopRowConstant,
      body: Center(
        child: Container(
          width: 400,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(child: _buildDecorativeBorder()),
                  SizedBox(width: 10),
                  Text(
                    'CERTIFICATE OF COMPLETION',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Expanded(child: _buildDecorativeBorder()),
                ],
              ),
              Text(
                'COMPLETION',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              _buildDecorativeSymbol(),
              SizedBox(height: 20),
              Text('THIS AWARD CERTIFIES THAT'),
              SizedBox(height: 10),
              _buildUnderlinedTextField('Enter Name of Recipient'),
              SizedBox(height: 20),
              Text('HAS SUCCESSFULLY COMPLETED'),
              SizedBox(height: 10),
              _buildUnderlinedTextField('Enter comments'),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: _buildUnderlinedTextField('Enter date')),
                  SizedBox(width: 20),
                  Expanded(child: _buildUnderlinedTextField('Signature')),
                ],
              ),
              SizedBox(height: 10),
              _buildUnderlinedTextField('Enter title'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDecorativeBorder() {
    return Container(
      height: 2,
      color: Colors.black,
    );
  }

  Widget _buildDecorativeSymbol() {
    return Text(
      '❧',
      style: TextStyle(fontSize: 24, color: Colors.black),
    );
  }

  Widget _buildUnderlinedTextField(String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        border: UnderlineInputBorder(),
        contentPadding: EdgeInsets.zero,
      ),
      textAlign: TextAlign.center,
    );
  }
}