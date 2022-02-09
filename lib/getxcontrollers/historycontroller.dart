import 'package:exoheal/constants/color_constants.dart';
import 'package:exoheal/constants/fontconstants.dart';
import 'package:exoheal/datamodels/HistoryModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
class HistoryController extends GetxController{

  Color getcolor(String img){
    switch (img){
      case "exohealgreen":
        return exohealgreen;
        break;
      case "exohealbeige":
        return exohealbeige;
        break;
      case "exohealdarkgrey":
        return exohealdarkgrey;
        break;
      case "exoheallightgrey":
        return exoheallightgrey;
        break;
      default:
        return exoheallightgrey;
    }
  }
  Widget emptystate(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: screenwidth*0.0635),
              child: SvgPicture.asset(
                "assets/images/No task empty state.svg",
                width: screenwidth * 0.322,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
//                                top: 21,bottom: 9
                  top: screenwidth * 0.0538,
                  bottom: screenwidth * 0.0230),
              child: Text(
                "No exercise done yet",
                style: TextStyle(
                    fontFamily: intersemibold,
                    color: Colors.black,
                    fontSize: screenwidth*0.0401),
              ),
            ),
            Container(
              child: Text(
                "Connect to your ExoHeal device and start exercising",
                style: TextStyle(
                    fontFamily: intermedium,
                    color: Color(0xffA3A3A3),
                    fontSize:screenwidth*0.0304),
              ),
            ),
          ],
        ),
      ],
    );
  }
Widget allhistory(BuildContext context,List<HistoryModel> historylist){
  double screenwidth=MediaQuery.of(context).size.width;
  return     Container(
    margin: EdgeInsets.only(top: screenwidth*0.0693),
    child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        itemCount: historylist.length,
        itemBuilder: (context,index){
          return Container(
            width: screenwidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: screenwidth*0.0293),
                            height: screenwidth*0.096,width: screenwidth*0.096,
                            decoration: BoxDecoration(
                                color: getcolor(historylist[index].image.toString()),
                                shape: BoxShape.circle
                            ),
                          ),
                          Container(
                            height:screenwidth*0.086,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    historylist[index].exercisetype.toString(),
                                    style: TextStyle(
                                        fontFamily: intermedium,
                                        fontSize: screenwidth*0.032,
                                        color:darkgrey),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "Duration: "+historylist[index].duration.toString(),
                                    style: TextStyle(
                                        fontFamily: intermedium,
                                        fontSize: screenwidth*0.0293,
                                        color:exoheallightgrey),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    Container(
                      height:screenwidth*0.086,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            child: Text(
                              historylist[index].date.toString()==
                                  DateFormat.yMMMMd('en_US').format(DateTime.now())?
                              "Today":
                              historylist[index].date.toString(),
                              style: TextStyle(
                                  fontFamily: interregular,
                                  fontSize: screenwidth*0.0293,
                                  color:darkgrey),
                            ),
                          ),
                          Container(
                            child: Text(
                              historylist[index].time.toString(),
                              style: TextStyle(
                                  fontFamily: interregular,
                                  fontSize: screenwidth*0.0293,
                                  color:darkgrey),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                index==(historylist.length-1)?
                SizedBox(height: 0,):
                Container(
                  margin: EdgeInsets.only(top: screenwidth*0.04,bottom: screenwidth*0.0506),
                  width: screenwidth,
                  height: 1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Color(0xffECEBEB)
                  ),
                )
              ],
            ),
          );
        }),
  );
}
}