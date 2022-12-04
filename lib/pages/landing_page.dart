import 'package:app/values/assets.dart';
import 'package:app/values/colors.dart';
import 'package:app/values/styles.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';



class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
             children: [
               Expanded(child: Container(
                   alignment: Alignment.centerLeft,
                    child: Text('Welcome to', style: AppStyles.h3)
            ),),
                Expanded(child: Container(

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,

                      children:[ Text('English',style: AppStyles.h2.copyWith(color:AppColors.blackGrey, fontWeight: FontWeight.bold)),
                     Padding(
                       padding: const EdgeInsets.only(right: 8.0),
                       child: Text('Quotes"',style: AppStyles.h4.copyWith(height: 0.5),textAlign: TextAlign.right,),
                     ),]

                  ),
                  ),
            ),

                Expanded(
                  child:Container(
                    child: FloatingActionButton(
                      onPressed: (){
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => Homepage()), (route) => false);
                      } ,
                      backgroundColor: AppColors.lightBlue,
                      shape: CircleBorder(),
                      child: Image.asset(AppAssets.arrow,height: 35,width: 35,),
                      
                      
                    ),
                  )
                )
          ],
        ))
    );
  }
}