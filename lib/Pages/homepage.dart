import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodlite/Pages/restaurantDetail.dart';
import 'package:foodlite/restaurantDataModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart' as rootBundle;

class Homepage extends StatefulWidget {
  const Homepage({ Key? key }) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

/*
  Future<String> loadPersonFromAssets() async {
    return await rootBundle.rootBundle.loadString('jsonfile/restaurants_list.json');
  }

  Future loadPerson() async {
    String jsonString = await loadPersonFromAssets();
    final jsonResponse = json.decode(jsonString);
    RestaurantDataModel restaurantDataModel = new RestaurantDataModel.fromJson(jsonResponse);
    print('${restaurantDataModel.name}');
  }

  @override
  void initState(){
    super.initState();
    loadPerson();
  }*/
  
  final List<String> _dropdownValues = [
    "Restaurant",
    "Bakery",
    "Cafe",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Nearby'),
        backgroundColor: Color.fromRGBO(13, 75, 138, 1),
      ),
      body: FutureBuilder(
        future: ReadJsonData(),
        builder: (context,data){
          if(data.hasError){
            return Center(child: Text('${data.error}'));
          }else if(data.hasData){
            var items = data.data as List<RestaurantDataModel>;
            
            return ListView.builder(
              itemCount: items == null? 0: items.length,
              itemBuilder: (context,index){
                return index == 0 
                ? _search(index) 
                : Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  elevation: 2,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: ListTile(
                    title: Container(
                      height: 100,
                      width: double.infinity,
                      child: ClipRRect(
                               borderRadius: BorderRadius.circular(10),
                               child: Image.network(items[index].profile_image_url.toString(),fit: BoxFit.fitWidth,),
                             ),
                    ),
                    subtitle: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: <Widget> [
                        Row(
                          children: <Widget> [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget> [
                                Text(items[index].name.toString(),style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 16),color: Colors.black, fontWeight: FontWeight.bold)),
                                Row(
                                  children: <Widget> [
                                    Icon(Icons.calendar_month_outlined, size: 16,),
                                    Text(items[index].categories.toString(),style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 16),color: Colors.black))
                                  ],
                                )
                                
                              ],
                            ),
                            Expanded(child: Container()),
                            Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(13, 75, 138, 1),
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                  padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                  child: Text(items[index].rating.toString(), style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 16, color: Colors.white)),),
                                ),
                          ],
                        )
                      ],
                    )
                  ),
                     
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> RestaurantDetail(restaurantDataModel: items[index])));
                  },
                  )
                );
              });
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },
      )
    );
  }

  Future<List<RestaurantDataModel>>ReadJsonData() async {
    final jsondata = await rootBundle.rootBundle.loadString('jsonfile/restaurants_list.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => RestaurantDataModel.fromJson(e)).toList();
  }

  

  Widget _search(index){
  return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Text('Place Lists', style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 24), fontWeight: FontWeight.bold)),
            Container(
              child: Row(
                children: <Widget> [
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                    items: _dropdownValues
                        .map((value) => DropdownMenuItem(
                              child: Text(value),
                              value: value,
                            ))
                        .toList(),
                    onChanged: (_) {},
                    isExpanded: false,
                    value: _dropdownValues.first,
                    ),
                  ),
                Expanded(child: Container()),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.0),
                border: Border.all(
                    color: Color.fromRGBO(13, 75, 138, 100), style: BorderStyle.solid, width: 1.5),
              )
            ),
            Container(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  hintText: "Search name.",
                  fillColor: Colors.white70),
            )

          ],
        ),
      );
  }
  
}



  
