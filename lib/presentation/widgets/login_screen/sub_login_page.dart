import 'package:flutter/material.dart';
import 'package:prohealth/presentation/widgets/login_screen/child_container_constant_login.dart';

class SubLoginScreen extends StatelessWidget {
  const SubLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Container(
          height: 1067.0,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/login_screen_no_blur.png'),
                fit: BoxFit.fill),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 58.0, vertical: 58),
            child: Container(
              height: MediaQuery.of(context).size.height/5,
              width: MediaQuery.of(context).size.width/5,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff000000).withOpacity(0.045),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(1, 4),
                  ),
                ],
                color: const Color(0xffFFFFFF).withOpacity(0.5),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36.0,vertical: 26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ///head text
                    Text('Select a Module',
                      textAlign: TextAlign.center,
                             style: TextStyle(
                               fontFamily: 'FiraSans',
                               fontSize: 16,
                               fontWeight: FontWeight.w700,color: Color(0xff565656),
                             ),
                           ),
                    Text(
                             'Administration',
                      textAlign: TextAlign.center,
                             style: TextStyle(
                               fontFamily: 'FiraSans',
                               color: Color(0xff565656),
                               fontSize: 16.0,
                               fontWeight: FontWeight.w700
                             ),
                           ),
                    Row(
                      children: [
                        ResponsiveContainer('Referral Resource Manager',Icons.manage_search),
                       SizedBox(width: MediaQuery.of(context).size.width/40,),
                        ResponsiveContainer('Establishment Manager',Icons.add_home_outlined),
                       SizedBox(width: MediaQuery.of(context).size.width/40,),
                        ResponsiveContainer('Human Resource Manager',Icons.manage_search),
                      ],
                    ),
                    Text(
                      'Business',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'FiraSans',
                          color: Color(0xff565656),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                    Row(
                      children: [
                        ResponsiveContainer('Business Intelligence & Reports',Icons.manage_search),
                        SizedBox(width: MediaQuery.of(context).size.width/40,),
                        ResponsiveContainer('Finance',Icons.manage_search),
                        SizedBox(width: MediaQuery.of(context).size.width/40,),
                        ResponsiveContainer('Other',Icons.manage_search),
                      ],
                    ),
                    Text(
                      'Patient Related',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'FiraSans',
                          color: Color(0xff565656),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                    Row(
                      children: [
                        ResponsiveContainer('Intake & Scheduler',Icons.manage_search),
                        SizedBox(width: MediaQuery.of(context).size.width/40,),
                        ResponsiveContainer('Rehab',Icons.manage_search),
                        SizedBox(width: MediaQuery.of(context).size.width/40,),
                        ResponsiveContainer('Home Care',Icons.manage_search),
                        SizedBox(width: MediaQuery.of(context).size.width/40,),
                        ResponsiveContainer('Home Health EMR',Icons.manage_search),
                      ],
                    ),
                    ResponsiveContainer('Hospice EMR',Icons.manage_search),
                  ],
                ),
              )
            ),
          ),
        ),
      ),
    );
  }
}