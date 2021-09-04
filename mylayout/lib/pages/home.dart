import 'dart:convert';
//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:mylayout/pages/detail.dart';

import 'package:http/http.dart' as http;
import 'dart:async';

class HomePage extends StatefulWidget {
  // const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ความรู้เกี่ยวกับวัคซีน COVID-19"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20), // ให้ขอบห่างจากขอบ 20 pixels
        child: FutureBuilder( builder: (context, AsyncSnapshot snapshot) {
            //var data = json.decode(snapshot.data.toString()); // [{คอมพิวเตอร์คืออะไร...},{},{},{}]
            return ListView.builder( //คล้ายการวน loop
              itemBuilder: (BuildContext context, int index) {
                return MyBox(snapshot.data[index]['title'], snapshot.data[index]['subtitle'], snapshot.data[index]['image_url'], snapshot.data[index]['detail']);

              },
              itemCount: snapshot.data.length, );

        },
        future: getData(),
        // future: DefaultAssetBundle.of(context).loadString('assets/data.json'), 

        )
 
      ),
    );
  }

  Widget MyBox(String title, String subtitle, String image_url, String detail) {
    var v1,v2,v3,v4;
    v1 = title;
    v2 = subtitle;
    v3 = image_url;
    v4 = detail;
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(20),
      // color: Colors.blue[50],
      height: 200,
      decoration: BoxDecoration(
          // color: Colors.blue[50],
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: NetworkImage(image_url),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.40), BlendMode.darken))),

          
      child: Column(
        mainAxisAlignment: MainAxisAlignment
            .start, //.start จะเริ่มด้านบน แนว Main คือ verticel / .center / .end / .spaceEvenly
        crossAxisAlignment: CrossAxisAlignment
            .start, //การจัด alignment ในแนวนอน .start / .center / .end
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            subtitle,
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          SizedBox(height: 7),
          TextButton(onPressed: (){
              print("Next Page >>>");
              Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailPage(v1,v2,v3,v4)));
          }, child: Text("อ่านต่อ >>>"))
        ],
      ),
    );
  }


  Future getData() async {  // async คือ function ที่ต้องใช้เวลา download
    // https://raw.githubusercontent.com/Chiangkung/BasicAPI/main/data.json
    var url = Uri.https('raw.githubusercontent.com','/Chiangkung/BasicAPI/main/data.json');
    var response = await http.get(url);
    var result = json.decode(response.body);
    return result;
  }



}

