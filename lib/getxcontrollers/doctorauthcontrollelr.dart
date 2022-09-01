import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/fontconstants.dart';

class DoctorAuthController extends GetxController{
  TextEditingController logindoctoridcontroller=TextEditingController();
  TextEditingController loginhospitalnamecontroller=TextEditingController();
  TextEditingController loginpasswordcontroller=TextEditingController();


  Widget doctorloginfields(BuildContext context){
    double screenwidth=MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: screenwidth*0.0833),
      width: screenwidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          indivfield(context: context, fieldname:  "Doctor's id",hinttext: "robfox@gmail.com",
          textEditingController: logindoctoridcontroller,),
          indivfield(context: context, fieldname:  "Hospital/ Research centre",hinttext: "Walter Reed Hospital, etc.",
            textEditingController: loginhospitalnamecontroller,),
          indivfield(context: context, fieldname:  "Enter password",hinttext: "at least 8 characters",
            textEditingController: loginpasswordcontroller,),        ],
      ),
    );
  }
  Widget indivfield({BuildContext? context,String? fieldname,
  String? hinttext, TextEditingController? textEditingController}){
    double screenwidth=MediaQuery.of(context!).size.width;
    return Container(
      margin: EdgeInsets.only(bottom: screenwidth*0.0413),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
                left: screenwidth*0.021,bottom: screenwidth*0.024,
                ),
            child: Text(fieldname!,style: TextStyle(
                fontFamily: intermedium,
                color: Color(0xff656565),
                fontSize: screenwidth*0.032
            ),),
          ),
          Container(
            padding: EdgeInsets.only(
              //         horizontal: 24
              left: screenwidth*0.04,
              //     right: screenwidth*0.04

            ),
            //      height: 46,
            height: screenwidth*0.096,
            width: screenwidth,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xffECECEC),
                width: 1,
              ),
              color: Colors.white.withOpacity(0.85),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Center(
              child: TextFormField(
                controller: logindoctoridcontroller,
                cursorColor: Colors.black87,
                style: TextStyle(
                    fontFamily: interregular,
                    color: Colors.black87,
                    //       fontSize: 13.5
                    fontSize: screenwidth*0.0328
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  suffixIcon: Icon(FeatherIcons.user,
                    color: Color(0xff404d4d),
                    //                 size: 18,
                    size: screenwidth*0.0437,
                  ),
                  border: InputBorder.none,
                  hintText: hinttext,
                  hintStyle: TextStyle(
                      fontFamily: interregular,
                      color: Color(0xffB5B5B5)
                  ),

                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}