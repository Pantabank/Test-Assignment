import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodlite/restaurantDataModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:google_fonts/google_fonts.dart';


class RestaurantDetail extends StatelessWidget {
  final RestaurantDataModel restaurantDataModel;
  const RestaurantDetail({ Key? key, required this.restaurantDataModel }) : super(key: key);

  Future<String> loadPersonFromAssets() async {
        return await rootBundle.rootBundle.loadString('json/person.json');
  }

  Future loadPerson() async {
    String jsonString = await loadPersonFromAssets();
    final jsonResponse = json.decode(jsonString);
    RestaurantDataModel res = new RestaurantDataModel.fromJson(jsonResponse);
    print(res.address);
}

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(restaurantDataModel.name.toString(),style: GoogleFonts.kanit(),),
          backgroundColor: Color.fromRGBO(13, 75, 138, 1),
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(25.0)
                ),
                child:  TabBar(
                  indicator: BoxDecoration(
                    color: Color.fromRGBO(13, 75, 138, 1),
                    borderRadius:  BorderRadius.circular(25.0)
                  ) ,
                  labelColor: Colors.white,
                  unselectedLabelColor: Color.fromRGBO(13, 75, 138, 1),
                  tabs: const  [
                    Tab(text: 'INFORMATION'),
                    Tab(text: 'IMAGE',),
                  ],
                ),
              ),
              Expanded(
                  child: TabBarView(
                    children:  [
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          elevation: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                           children: <Widget> [
                             Container(
                               height: 200,
                               width: double.infinity,
                               child: ClipRRect(
                               borderRadius: BorderRadius.circular(20),
                               child: Image.network(restaurantDataModel.profile_image_url.toString(),fit: BoxFit.fitWidth,),
                             ),
                             ),
                             Container(
                               padding: EdgeInsets.all(10),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: <Widget> [
                                  Text(restaurantDataModel.name.toString(),maxLines: 2 ,style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 24), fontWeight: FontWeight.bold),),
                                   Row(
                                     children: <Widget> [
                                       Icon(Icons.circle, color: Color.fromRGBO(13, 75, 138, 1), size: 15,),
                                       Text(restaurantDataModel.rating.toString(),style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 24), color: Color.fromRGBO(13, 75, 138, 1)))
                                     ],
                                   ),
                                  Text('Address : ',style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 16), fontWeight: FontWeight.bold),),
                                  Text(restaurantDataModel.address.toString(),style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 16)),),
                                  Text(''),
                                  Text('Opening Hour : ',style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 16), fontWeight: FontWeight.bold),),
                                  Text(restaurantDataModel.operation_time.toString(),style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 16)),),
                                 ],
                               ),
                             )
                           ], 
                          ),
                        ),
                      ),
                      ListView(
                        padding: const EdgeInsets.all(8),
                        children: <Widget> [
                          Container(
                            height: 50,
                            color: Colors.amber[600],
                            child: Center(child: Text(restaurantDataModel.categories.toString())),
                          )
                        ],
                      )
                    ],
                  )
              )
            ],
          ),
        )
      ),
    );
  }
}