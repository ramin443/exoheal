import 'package:exoheal/constants/fontconstants.dart';
import 'package:exoheal/getxcontrollers/chartcontroller.dart';
import 'package:exoheal/screens/sharables/chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../constants/color_constants.dart';
class ShowChart extends StatelessWidget {
   ShowChart({Key? key}) : super(key: key);
  List<SensorValue> _data = []; // array to store the values
   int _windowLen = 30 * 6; // window length to display - 6 seconds
   int _fs = 30; // sampling frequency (fps)
   int _bpm = 0; // beats per minute

  @override
  Widget build(BuildContext context) {
    double screenwidth=MediaQuery.of(context).size.width;
    double screenheight=MediaQuery.of(context).size.height;
    return
      GetBuilder<ChartController>(
          init: ChartController(),
          builder: (chartcontroller){
        return
      Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            chartcontroller.stopTimer();
            chartcontroller.reset();
            chartcontroller.startTimer();
            chartcontroller.toggle();
          }, icon: Icon(
            CupertinoIcons.add,
            color: Colors.redAccent,
            size: 24,
          )),
          IconButton(onPressed: (){
            chartcontroller.stopTimer();
            chartcontroller.untoggle();
          }, icon: Icon(
            CupertinoIcons.minus,
            color: Colors.redAccent,
            size: 24,
          )),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Chart Test",
        style: TextStyle(
          fontFamily: proximanovaregular
        ),),
      ),
      body: Container(
        width: screenwidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

               Stack(
                 children:[
                   Container(
                   height: screenwidth*0.384,
                      width: screenwidth*0.8666,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(6),
                          ),
                          color: Color(0xffF8F4F0),
                      boxShadow: [BoxShadow(blurRadius: 10,
                      offset: Offset(0,0),color: Colors.black.withOpacity(0.08))]
                      ),
                      child: Chart(
                          chartcontroller.data),
                    ),
                 Container(
                   height: screenwidth*0.384,
                   width: screenwidth*0.8666,
                   child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                       Container(
                         child: SvgPicture.asset("assets/images/Vector 274.svg",
                           height: screenwidth*0.384,
                         ),
                       ),
                       Container(
                         child: SvgPicture.asset("assets/images/Vector 274.svg",
                           height: screenwidth*0.384,
                         ),
                       ),
                       Container(
                         child: SvgPicture.asset("assets/images/Vector 274.svg",
                           height: screenwidth*0.384,
                         ),
                       ),
                     ],
                   ),
                 ),
                   Container(
                     height: screenwidth*0.384,
                     width: screenwidth*0.8666,
                     padding: EdgeInsets.only(bottom: screenwidth*0.016),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       crossAxisAlignment: CrossAxisAlignment.end,
                       children: [
                         Container(
                           child: Text("0 s",style: TextStyle(
                             color: Color(0xff989898),
                             fontFamily: interregular,
                             fontSize: screenwidth*0.028
                           )),
                         ),
                         Container(
                           child: Text("3.7 s",style: TextStyle(
                               color: Color(0xff989898),
                               fontFamily: interregular,
                               fontSize: screenwidth*0.028
                           )),
                         ),
                         Container(
                           child: Text("7.5 s",style: TextStyle(
                               color: Color(0xff989898),
                               fontFamily: interregular,
                               fontSize: screenwidth*0.028
                           )),
                         ),
                         Container(
                           child: Text("10.7 s",style: TextStyle(
                               color: Color(0xff989898),
                               fontFamily: interregular,
                               fontSize:screenwidth*0.028
                           )),
                         ),
                         Container(
                           child: Text("15 s",style: TextStyle(
                               color: Color(0xff989898),
                               fontFamily: interregular,
                               fontSize: screenwidth*0.028
                           )),
                         ),

                       ],
                     ),
                   )
                 ]
               ),

            Container(
              margin: EdgeInsets.only(top: screenwidth*0.024),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "Time (total: 15 s)",
                      style: TextStyle(
                          fontFamily: intermedium,
                          fontSize: screenwidth*0.0293,
                          color:exohealgreen),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: screenwidth*0.0266),
                    child: Icon(
                      CupertinoIcons.arrow_right,
                      color:exohealgreen,
                      size: screenwidth*0.0373,
                    ),
                  )
                ],
              ),
            ),
            chartcontroller.sensorygraph(context),
          ],
        ),
      ),
    );});
  }


}
