import 'dart:async';

import 'package:covid19app/view/world_State.dart';
import 'package:flutter/material.dart';
import 'dart:math'as math;
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  //TickerProviderStateMixin animation create a help kore

  late final AnimationController _controller = AnimationController(vsync: this,
  duration: const Duration(seconds: 3)
  )..repeat();
  //kono ekta animation ke controll korar jonno amra eta use kori ,


  void dispose(){
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(
      seconds: 3
    ), ()=>Navigator.push((context), MaterialPageRoute(builder: (context)=>WorldStatesScreen())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                    AnimatedBuilder(animation: _controller,
                        child: Container(
                          height: 200,
                            width: 200,
                          child: const Center(
                            child: Image(image: AssetImage('images/virus.png')),
                          ),
                        ),
                        builder: (context,Widget?child){
                          return Transform.rotate(angle: _controller.value*2.0*math.pi,
                          child: child,
                          );

                        }),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.08,
                ),
                const Align(
                    alignment: Alignment.center
                    ,child: Text("    Covid19\nTracker App",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,),)),
              ],

          )

      ),
    );
  }
}
