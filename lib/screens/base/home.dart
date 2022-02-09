import 'package:exoheal/constants/color_constants.dart';
import 'package:exoheal/constants/fontconstants.dart';
import 'package:exoheal/getxcontrollers/homecontroller.dart';
import 'package:exoheal/screens/sharables/widgets/history_home.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return GetBuilder<HomeController>(
      initState: (v){
        homeController.setmessageboxfalse();
      },
        init: HomeController(),
        builder: (homecontroller) {
          return Scaffold(
            key: _key,
            drawer: homecontroller.drawer(context),
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
           /*     IconButton(
                    onPressed: () {
                      homecontroller.getblob();
                      //homecontroller.listendevices();
                      //   homecontroller.tryazure();
                      // homecontroller.scanbluetoothdevices();
                    },
                    icon: Icon(
                      CupertinoIcons.ellipsis_vertical,
                      size: 20,
                      color: Color(0xff575757),
                    ))*/
              ],
              leading: IconButton(
                  onPressed: () {
                    _key.currentState!.openDrawer();
                  },
                  icon: Icon(
                    FeatherIcons.menu,
                    size: 20,
                    color: Color(0xff575757),
                  )),
              centerTitle: true,
              title: Container(
                child: Text(
                  "ExoHeal",
                  style: TextStyle(
                      fontFamily: proximanovaregular,
                      fontSize: 18,
                      color: Color(0xff404040)),
                ),
              ),
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                width: screenwidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    homecontroller.loading?homecontroller.connectingcolumn(context):
                    homecontroller.notconnectedcircle(context),
                   homecontroller.showmessagebox?homecontroller.messagebox(context):
                       SizedBox(height: 0,),
                    Container(
                      width: screenwidth,
                      margin: EdgeInsets.only(top: screenwidth * 0.0186),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: screenwidth * 0.074),
                            child: Text(
                              "Make sure you have bluetooth\n"
                              "on your device turned on",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: intermedium,
                                  color: Color(0xffA8A8A8),
                                  fontSize: screenwidth * 0.0293),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: screenwidth * 0.048,
                          horizontal: screenwidth * 0.0666),
                      child: SvgPicture.asset(
                        "assets/images/separation.svg",
                        width: screenwidth,
                      ),
                    ),

                    homecontroller.history_home(
                        context, homecontroller.staticlist)
                  ],
                ),
              ),
            ),
          );
        });
  }
}
