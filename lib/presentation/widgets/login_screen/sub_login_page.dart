import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/home_screen.dart';
import 'package:prohealth/presentation/widgets/login_screen/widgets/child_container_constant_login.dart';

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
                        ResponsiveContainer('Referral Resource Manager',AssetImage("images/r_r_m.png"),),
                       SizedBox(width: MediaQuery.of(context).size.width/40,),
                        ResponsiveContainer('Establishment Manager',AssetImage("images/e_m.png"),),
                       SizedBox(width: MediaQuery.of(context).size.width/40,),
                        InkWell(
                            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                            },
                            child: ResponsiveContainer('Human Resource Manager',AssetImage("images/h_r_m.png"),)),
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
                        ResponsiveContainer('Business Intelligence & Reports',AssetImage("images/b_i_r.png"),),
                        SizedBox(width: MediaQuery.of(context).size.width/40,),
                        ResponsiveContainer('Finance',AssetImage("images/finance.png"),),
                        SizedBox(width: MediaQuery.of(context).size.width/40,),
                        ResponsiveContainer('Other',AssetImage("images/other.png"),),
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
                        ResponsiveContainer('Intake & Scheduler',AssetImage("images/i_s.png"),),
                        SizedBox(width: MediaQuery.of(context).size.width/40,),
                        ResponsiveContainer('Rehab',AssetImage("images/rehab.png"),),
                        SizedBox(width: MediaQuery.of(context).size.width/40,),
                        ResponsiveContainer('Home Care',AssetImage("images/h_c.png"),),
                        SizedBox(width: MediaQuery.of(context).size.width/40,),
                        ResponsiveContainer('Home Health EMR',AssetImage("images/h_h_emr.png"),),
                      ],
                    ),
                    ResponsiveContainer('Hospice EMR',AssetImage("images/h_emr.png"),),
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