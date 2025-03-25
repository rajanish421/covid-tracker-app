import 'dart:convert';

import 'package:covid_tracker_app/modals/globalModals.dart';
import 'package:covid_tracker_app/searchPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:pie_chart/pie_chart.dart';
import 'APIServices.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  // Map<String , double> mapData = {
  //   "Total":GlobalModals().todayCases!.toDouble(),
  //   "Recovered":234,
  //   "Deaths":23,
  // };
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:Container(
          color: CupertinoColors.darkBackgroundGray.withOpacity(0.84),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.only(top:30),
            child: FutureBuilder(
              future: APIservices().getData(APIservices().globalUir),
              builder:(context,AsyncSnapshot snapshot) {
                if(!snapshot.hasData){
                  return Center(child: CircularProgressIndicator.adaptive());
                }else{
                  return Column(
                    children: [
                      PieChart(
                        dataMap:{
                          "Total":double.parse(snapshot.data.cases.toString()),
                            "Recovered":double.parse(snapshot.data.recovered.toString()),
                            "Deaths":double.parse(snapshot.data.deaths.toString()),
                        },
                        chartValuesOptions: ChartValuesOptions(showChartValuesInPercentage: true,showChartValuesOutside: true),
                        chartType:ChartType.ring,
                        chartRadius: 180,
                        chartLegendSpacing: 40,
                        legendOptions: LegendOptions(legendPosition:LegendPosition.left),
                        ringStrokeWidth: 40,
                        colorList: [Colors.blue,Colors.green,Colors.red,],

                      ),
                      SizedBox(height: 30,),
                      Container(
                        width: MediaQuery.of(context).size.width*0.9,
                        height:450,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              reUsable('Total cases',int.parse(snapshot.data.cases.toString())),
                              reUsable('Deaths',int.parse(snapshot.data.deaths.toString())),
                              reUsable('Recovers',int.parse(snapshot.data.recovered.toString())),
                              reUsable('Actives',int.parse(snapshot.data.active.toString())),
                              reUsable('Critical',int.parse(snapshot.data.critical.toString())),
                              reUsable('Today Deaths',int.parse(snapshot.data.todayDeaths.toString())),
                              reUsable('Today recovered',int.parse(snapshot.data.todayRecovered.toString())),
                            ],
                          ),
                        ),

                      ),
                      Spacer(),
                      MaterialButton(
                        onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder:(context)=>SearchPage()));
                        },
                        child: Text('Track Countrie'),
                        color: Colors.green,
                        minWidth: MediaQuery.of(context).size.width*0.9,
                        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      Spacer(),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

Widget reUsable(String text,int value){
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Row(
      children: [
        Text(text,style: TextStyle(fontSize: 20,color: Colors.white),),
        Spacer(),
        Text(value.toString(),style: TextStyle(fontSize: 20,color: Colors.white),),
      ],
    ),
  );
}
