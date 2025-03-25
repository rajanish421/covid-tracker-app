import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
class DetailsPage extends StatefulWidget {
  String? imageUrl;
  String cases;
  String recovered;
  String Deaths;
  String critical;
  String todayRecovered;
  String name;
  // DetailsPage({super.key, this.imageUrl,required this.cases,required this.recovered, required this.Deaths,});
  DetailsPage({super.key,required this.imageUrl,required this.cases,required this.critical,required this.Deaths,required this.recovered,required this.todayRecovered,required this.name});
  

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name,style: TextStyle(color: Colors.white),),
        backgroundColor:CupertinoColors.darkBackgroundGray.withOpacity(0.84) ,
        centerTitle: true,
      ),
      body: Container(
        color: CupertinoColors.darkBackgroundGray.withOpacity(0.84),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
              top: 200,
              left: 135,
              child: CircleAvatar(
                radius: 75,
                backgroundImage: NetworkImage(widget.imageUrl.toString()),
              ),
            ),
            Positioned(
              bottom: 120,
              left: 20,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: MediaQuery.of(context).size.width*0.9,
                height: 320,
                child: Column(
                  children: [
                    reUsable('Cases',int.parse(widget.cases)),
                    reUsable('Recovered',int.parse(widget.recovered)),
                    reUsable('Deaths',int.parse(widget.Deaths)),
                    reUsable('Critical',int.parse(widget.critical)),
                    reUsable('Today Recovered',int.parse(widget.todayRecovered)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
