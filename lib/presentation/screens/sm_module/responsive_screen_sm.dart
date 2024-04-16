import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';

class ResponsiveScreenSM extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 850) {
          // Render SMDesktop screen for large screens
          return SMDesktop();
        } else {
          // Render SMTablet screen for small screens
          return SMTablet();
        }
      },
    );
  }
}

class SMDesktop extends StatelessWidget {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: 131,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0xff000000).withOpacity(0.25),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
              color: Color(0xffFFFFFF),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 20,
                        // color: Colors.grey,
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        // color: Colors.red,
                        height: 20,
                      ),
                    ),
                  ],
                ),

                /// buttons
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        // color: Colors.yellow,
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomButton(
                              height: 30,
                              width: 100,
                              onPressed: () {
                                if (_pageController.page != 0) {
                                  _pageController.animateToPage(0,
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease);
                                }
                              },
                              text: 'Button 1',
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            CustomButton(
                              height: 30,
                              width: 100,
                              onPressed: () {
                                if (_pageController.page != 1) {
                                  _pageController.animateToPage(1,
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease);
                                }
                              },
                              text: 'Button 2',
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            CustomButton(
                              height: 30,
                              width: 100,
                              onPressed: () {
                                if (_pageController.page != 2) {
                                  _pageController.animateToPage(2,
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease);
                                }
                              },
                              text: 'Button 3',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Container(color: Colors.blue),
              Container(color: Colors.green),
              Container(color: Colors.orange),
            ],
          ),
        ),
      ],
    );
  }
}

class SMTablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tablet Screen'),
      ),
      body: Center(
        child: Text(
          'Tablet Screen Content',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
