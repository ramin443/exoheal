import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../constants/color_constants.dart';
import '../constants/fontconstants.dart';
import '../screens/sharables/chart.dart';

class ChartController extends GetxController{
  bool istimercomplete=false;
  static const countdownDuration = Duration(seconds: 15);
  Duration duration = Duration();
  Timer? timer;
  Timer? _timer; // timer for image processing
  double? _avg; //// store the average value during calculation
  bool timerstarted = false;
  bool countDown = true;
  List<SensorValue> data = []; // array to store the values
  int _windowLen = 30 * 6; // window length to display - 6 seconds
  int _fs = 30; // sampling frequency (fps)
  bool _toggled = false; // toggle button value
  int _bpm = 0; // beats per minute
  double _alpha = 0.3; // factor for the mean value

  void reset() {
    if (countDown) {
      duration = countdownDuration;
      update();
    } else {
      duration = Duration();
      update();
    }
  }

  void _scanImage() {
    DateTime now = DateTime.now();
    if( duration.inSeconds.isEven){
    //  print("even found");
      int randomnumber=Random().nextInt(20);
      double curpos=randomnumber.toDouble();
      _avg=curpos;
      data.add(SensorValue(now, _avg!));
      update();
    }else{
//      print("odd found");
      int rando=Random().nextInt(30);
      double curpo=70+rando.toDouble();
      _avg=curpo;
      data.add(SensorValue(now, _avg!));
      update();
    }
    /*_avg =
        image.planes.first.bytes.reduce((value, element) => value + element) /
            image.planes.first.bytes.length;

    */
    if (data.length >= _windowLen) {
      data.removeAt(0);
      update();
    }

  }
  void _clearData() {
    // create array of 128 ~= 255/2
    data.clear();

    int now = DateTime.now().millisecondsSinceEpoch;
    for (int i = 0; i < 0; i++)
      data.insert(
          0,
          SensorValue(
              DateTime.fromMillisecondsSinceEpoch(now - i * 1000 ~/ _fs), 0));
  }

  void _updateBPM() async {
    // Bear in mind that the method used to calculate the BPM is very rudimentar
    // feel free to improve it :)

    // Since this function doesn't need to be so "exact" regarding the time it executes,
    // I only used the a Future.delay to repeat it from time to time.
    // Ofc you can also use a Timer object to time the callback of this function
    List<SensorValue> _values;
    double _avg;
    int _n;
    double _m;
    double _threshold;
    double _bpm;
    int _counter;
    int _previous;
    /*
    while (_toggled) {

      _values = List.from(data); // create a copy of the current data array
      _avg = 0;
      _n = _values.length;
      _m = 0;
      _values.forEach((SensorValue value) {
        _avg += value.value / _n;
        if (value.value > _m) _m = value.value;
      });
      _threshold = (_m + _avg) / 2;
      _bpm = 0;
      _counter = 0;
      _previous = 0;
      for (int i = 1; i < _n; i++) {
        if (_values[i - 1].value < _threshold &&
            _values[i].value > _threshold) {
          if (_previous != 0) {
            _counter++;
            _bpm += 60 *
                1000 /
                (_values[i].time.millisecondsSinceEpoch - _previous);
          }
          _previous = _values[i].time.millisecondsSinceEpoch;
        }
      }
      if (_counter > 0) {
        _bpm = _bpm / _counter;
        print(_bpm);
          this._bpm = ((1 - _alpha) * this._bpm + _alpha * _bpm).toInt();
      update();
      }
      await Future.delayed(Duration(
          milliseconds:
          1000 * _windowLen ~/ _fs)); // wait for a new set of _data values

    }
    */
  }
  void toggle() {
    _clearData();
        _toggled = true;
        update();
        // after is toggled
      _initTimer();
      _updateBPM();
      update();
  }

  void untoggle() {
    reset();
    _toggled = false;
    timer!.cancel();
    update();
  }
  void _initTimer() {

    _timer = Timer.periodic(Duration(milliseconds: 1000 ~/ _fs), (timer) {
      if (_toggled) {

       _scanImage();
      } else {
        timer.cancel();
      }
    });
  }
  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }
  void settimerfalse(){
    istimercomplete=false;
    update();
  }
  void settimertrue(){
    istimercomplete=true;
    _clearData();
    _timer!.cancel();
    update();
  }
  void addTime() {
    final addSeconds = countDown ? -1 : 1;
    final seconds = duration.inSeconds + addSeconds;
    if (seconds < 0) {
      update();
      settimertrue();
      istimercomplete=true;

      timer?.cancel();
    } else {
      duration = Duration(seconds: seconds);
    }
    update();
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    timer?.cancel();
    update();
  }
  Widget sensorygraph(BuildContext context){
    double screenwidth=MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(left: screenwidth*0.072,
            top: screenwidth*0.036,
            bottom: screenwidth*0.024),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: Text("Sensory Graph",style: TextStyle(
                      color: darkgrey,
                      fontFamily: intersemibold,
                      fontSize: screenwidth*0.042
                  )),
                ),
              ],
            ),
          ),
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
                      data),
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
        ],
      ),
    );
  }
}