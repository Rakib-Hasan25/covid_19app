import 'dart:convert';

import 'package:covid19app/Models/WorldStatesModel.dart';
import 'package:covid19app/Services/Utilities/states_services.dart';
import 'package:covid19app/view/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:http/http.dart'as http;

import '../Services/Utilities/app_url.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen> with TickerProviderStateMixin  {
  Future<WorldStatesModel>fetchWorldStatesRecords()async{
    final response=await http.get(Uri.parse('https://disease.sh/v3/covid-19/all'));
    var data = jsonDecode(response.body.toString());


    if(response.statusCode==200){
      // print("rakib");
      return WorldStatesModel.fromJson(data);
    }
    else{
      // print("rakib");
      return WorldStatesModel.fromJson(data);
    }
  }
  late final AnimationController _controller = AnimationController(vsync: this,
      duration: const Duration(seconds: 3)
  )..repeat();
  //kono ekta animation ke controll korar jonno amra eta use kori ,


  void dispose(){
    super.dispose();
    _controller.dispose();
  }


  final colorList=<Color>[
    const Color(0xff1aa260),
    const Color(0xff4285F4),
    const Color(0xffde5246),

  ];
  @override
  Widget build(BuildContext context) {
    // StatesServices statesServices= StatesServices();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.01,

              ),
              FutureBuilder(
                  future: fetchWorldStatesRecords(),
                  builder: (context, AsyncSnapshot<WorldStatesModel>snapshot){
                    if(!snapshot.hasData){
                      return Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                            size: 50.0,
                            controller: _controller,
                          )

                      );

                    }
                   else{
                      return
                         Column(
                            children: [
                              PieChart(
                                dataMap: {
                                  "Total": double.parse(snapshot.data!.cases!.toString()),
                                  "Recovered":double.parse(snapshot.data!.recovered.toString()),
                                  "Deaths":double.parse(snapshot.data!.deaths.toString())
                                },
                                chartValuesOptions: const ChartValuesOptions(
                                  showChartValuesInPercentage: true,
                                ),
                                // chartRadius: MediaQuery.of(context).size.width/3.2,
                                legendOptions: const LegendOptions(
                                  legendPosition: LegendPosition.left,
                                ),
                                animationDuration: const Duration(milliseconds: 1200),
                                chartType: ChartType.ring,
                                colorList: colorList,

                              ),

                              SizedBox(height: 20,),
                              Padding(
                                padding:  EdgeInsets.symmetric(horizontal:  MediaQuery.of(context).size.height*0.01),
                                child: Card(
                                  child: Column(
                                    children: [
                                      ReUsableRow(title: "total", value: snapshot.data!.cases!.toString()),
                                      ReUsableRow(title: "Recovered", value: snapshot.data!.recovered.toString()),
                                      ReUsableRow(title: "Total Deaths", value: snapshot.data!.deaths.toString()),
                                      ReUsableRow(title: "Active", value: snapshot.data!.active.toString()),
                                      ReUsableRow(title: "Critical", value: snapshot.data!.critical.toString()),
                                      ReUsableRow(title: "Today Recovered", value: snapshot.data!.todayRecovered.toString()),
                                      // ReUsableRow(title: "Death", value: snapshot.data!.todayDeaths.toString()),

                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20,),
                              GestureDetector(
                                onTap:(){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => CountriesListScreen()));


                                 },
                                child: Container(
                                    height: 50,
                                    decoration:  BoxDecoration(
                                      color:  Color(0xff1aa260),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text("Track Countries"),
                                    )
                                ),
                              )

                            ],
                      );

                    }
              }
              ),




            ],
          ),
        ),
      ),
    );
  }
}
class ReUsableRow extends StatelessWidget {
  String title,value;
   ReUsableRow({Key? key ,required this.title,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:10 ,right: 10,bottom:10 ,top:10 ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(height: 5),
          Divider(),
        ],
      ),
    );
  }
}


