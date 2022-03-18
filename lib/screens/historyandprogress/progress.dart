import 'package:exoheal/constants/fontconstants.dart';
import 'package:exoheal/getxcontrollers/progresscontroller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ProgressPage extends StatelessWidget {
   ProgressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenwidth=MediaQuery.of(context).size.width;
    return GetBuilder<ProgressController>(
        init: ProgressController(),
        builder: (progresscontroller){
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
//                  profilecontroller.putprofiledatablob();
                  },
                  icon: Icon(
                    CupertinoIcons.arrow_left,
                    size: 20,
                    color: Color(0xff575757),
                  )),
              centerTitle: true,
              title: Container(
                child: Text(
                  "Progress",
                  style: TextStyle(
                      fontFamily: intermedium,
                      fontSize: 16,
                      color: Color(0xff404040)),
                ),
              ),
            ),
            backgroundColor: Colors.white,
            body:
            FirebaseAuth.instance.currentUser!.email!=testuseremail?
            progresscontroller.progressemptystate(context):
            Container(
              width: screenwidth,
              padding: EdgeInsets.symmetric(horizontal: screenwidth*0.0693),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  progresscontroller.weeklybarchart(context),
                ],
              ),
            ),
          );});
  }
}
