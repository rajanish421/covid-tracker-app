import 'dart:convert';

import 'package:covid_tracker_app/APIServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'DetailsPage.dart';
import 'modals/countryModal.dart';
import 'modals/globalModals.dart';
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
TextEditingController _controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(

        appBar: AppBar(
            backgroundColor:CupertinoColors.darkBackgroundGray.withOpacity(0.84) ,
        ),
        body: SafeArea(
          child: Container(
            color: CupertinoColors.darkBackgroundGray.withOpacity(0.84),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextField(
                    controller: _controller,
                    style: TextStyle(color: Colors.white),
                    maxLines: 1,
                    onChanged:(value) {
                      setState(() {
                        _controller.text = value;
                      });

                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(width: 1),
                      ),
                      hintText: 'Search with countries name',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                      suffixIcon: Icon(Icons.search,color:Colors.white.withOpacity(0.5) ,),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Expanded(
                    child: FutureBuilder(
                        future: APIservices().getCountryData(APIservices().CountriesUir),
                        builder: (context,AsyncSnapshot snapshot){
                          if(!snapshot.hasData){
                            return Center(child: CircularProgressIndicator.adaptive(),);
                          }else{
                            print(APIservices().listData.toString());
                            return ListView.builder(

                              itemCount:snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final data = snapshot.data[index];
                                String name = snapshot.data[index].country.toString();
                                if(name.toLowerCase().contains(_controller.text.toLowerCase()))
                                  {
                                    return ListTile(
                                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailsPage(
                                          cases: data.cases.toString()??'',
                                          critical: data.critical.toString()??'',
                                          Deaths: data.deaths.toString()??'',
                                          imageUrl:snapshot.data[index].countryInfo.flag.toString() ,
                                          recovered: data.recovered.toString()??'',
                                          todayRecovered: data.todayRecovered.toString()??'',
                                          name: name,
                                        ),));
                                      },
                                      title: Text(snapshot.data[index].country.toString(),style: TextStyle(color: Colors.white)),
                                      leading: SizedBox(height:80,width:75,child: Image.network(snapshot.data[index].countryInfo.flag.toString())),
                                      subtitle: Text('Cases: ${snapshot.data[index].cases.toString()}',style: TextStyle(color: Colors.white),),
                                    );
                                  }else if(_controller.text.isEmpty){
                                  return ListTile(
                                    onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailsPage(
                                        cases: data.cases.toString()??'',
                                        critical: data.critical.toString()??'',
                                        Deaths: data.deaths.toString()??'',
                                        imageUrl:snapshot.data[index].countryInfo.flag.toString() ,
                                        recovered: data.recovered.toString()??'',
                                        todayRecovered: data.todayRecovered.toString()??'',
                                        name: name,
                                      ),));
                                    },
                                    title: Text(snapshot.data[index].country.toString(),style: TextStyle(color: Colors.white)),
                                    leading: SizedBox(height:80,width:75,child: Image.network(snapshot.data[index].countryInfo.flag.toString())),
                                    subtitle: Text('Cases: ${snapshot.data[index].cases.toString()}',style: TextStyle(color: Colors.white),),
                                  );
                                }else{
                                  return Container();
                                }

                              },
                            );
                          }
                        },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
