import 'package:flutter/material.dart';

///prachi
class OnboardingGeneral extends StatelessWidget {
  const OnboardingGeneral({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width * 0.9;
    double containerHeight = MediaQuery.of(context).size.height * 0.2;
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 7,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: containerWidth,
                          height: containerHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                            color: Colors.white,
                            // boxShadow: [
                            //   BoxShadow(
                            //     blurRadius: 3.0,
                            //     offset: Offset(0, 3),
                            //     color: Colors.grey.withOpacity(0.5),
                            //   ),
                            //   BoxShadow(
                            //       color: Colors.white, offset: Offset(-3, 0)),
                            //   BoxShadow(
                            //       color: Colors.white, offset: Offset(3, 0)),
                            // ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                  width: 88,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color: Color(0xff52A889),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20))),
                                  child: Text(
                                    "Approved",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Padding(
                                padding: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width / 60),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 28,
                                          backgroundColor:
                                              Colors.blue, // Example color
                                          child:
                                              Image.asset('images/profile.png'),
                                        ),
                                        Text(
                                          "Anogh Joshi",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  99),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          50,
                                    ),
                                    InfoTextWidget(
                                      texts: [
                                        "Social Security no",
                                        "Type of clinician",
                                        "Personal No.",
                                        "Personal Email",
                                      ],
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          50,
                                    ),
                                    InfoTextWidget(
                                      texts: [
                                        "142-23-546",
                                        "ST",
                                        "98-345-789",
                                        "09-234-0976",
                                      ],
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          50,
                                    ),
                                    InfoTextWidget(
                                      texts: [
                                        "142-23-546",
                                        "ST",
                                        "98-345-789",
                                        "09-234-0976",
                                      ],
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          50,
                                    ),
                                    InfoTextWidget(
                                      texts: [
                                        "142-23-546",
                                        "ST",
                                        "98-345-789",
                                        "09-234-0976",
                                      ],
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          50,
                                    ),
                                    InfoTextWidget(
                                      texts: [
                                        "142-23-546",
                                        "ST",
                                        "98-345-789",
                                        "09-234-0976",
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      )
                    ],
                  );
                }))
      ],
    );
  }
}

class InfoTextWidget extends StatelessWidget {
  final List<String> texts;
  const InfoTextWidget({
    super.key,
    required this.texts,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          texts.length,
          (index) => Text(
            texts[index],
            style: TextStyle(
              color: Color(0xff686464),
              fontSize: MediaQuery.of(context).size.width / 120,
            ),
          ),
        ),
      ),
    );
  }
}
//   Expanded(
//     child: Column(
//   mainAxisAlignment: MainAxisAlignment.spaceAround,
//   crossAxisAlignment: CrossAxisAlignment.start,
//   children: [
//     Text(
//       "Social Security no",
//       style: TextStyle(
//           color: Color(0xff686464),
//           fontSize: MediaQuery.of(context).size.width / 120),
//     ),
//     Text(
//       "Type of clinician",
//       style: TextStyle(
//           color: Color(0xff686464),
//           fontSize: MediaQuery.of(context).size.width / 120),
//     ),
//     Text(
//       "Personal No.",
//       style: TextStyle(
//           color: Color(0xff686464),
//           fontSize: MediaQuery.of(context).size.width / 120),
//     ),
//     Text(
//       "Personal Email",
//       style: TextStyle(
//           color: Color(0xff686464),
//           fontSize: MediaQuery.of(context).size.width / 120),
//     ),
//   ],
// ));
