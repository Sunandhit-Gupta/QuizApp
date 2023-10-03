import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:quizzler/Classes.dart';
import 'package:quizzler/Home.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'questionBank.dart';
import 'package:lottie/lottie.dart';
void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: loading(),
    theme: ThemeData.dark(),
  ));
}

bool wait = true ;

class loading extends StatefulWidget {
  const loading({super.key});

  @override
  State<loading> createState() => _loadingState();
}

class _loadingState extends State<loading> {

  void waitForIt()
  {

    Future.delayed(const Duration(milliseconds: 3700)).then((value){setState(() {
      wait = false;
    });});

  }
  @override
  void initState() {
    super.initState();
    waitForIt();
  }
  @override
  Widget build(BuildContext context) {
    return wait?Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100,width: 20,),
          Center(child: Text("Ready for Quiz",
          style: TextStyle(fontSize: 30,color: Colors.grey.shade300),
          ),
          ),
          Center(child: LottieBuilder.asset("asset/animation_lnatpojt.json",
          )),
        ],
      ),
    ):Home();
  }
}

