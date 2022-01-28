import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:url_launcher/url_launcher.dart';


void main()=>runApp(MyApp());
class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme:ThemeData(
        primarySwatch: Colors.blue,
      ),
        home:MyHomePage(),
        debugShowCheckedModeBanner: false,

    );
  }
}
class MyHomePage extends StatefulWidget{
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
  }
class _MyHomePageState extends State<MyHomePage> {

  List<Contact>? contacts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPhoneData();
  }
  void getPhoneData() async{
    if(await FlutterContacts.requestPermission()){
      contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);
      setState(() {

      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("contect app",style:
      TextStyle(color: Colors.blue),
      ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body:(contacts==null)? Center(child: CircularProgressIndicator()):
          ListView.builder(itemCount: contacts!.length,
              itemBuilder: (BuildContext context, int index){
            Uint8List? image=contacts![index].photo;
            String number=(contacts![index].phones.isNotEmpty)? contacts![index].phones.first.number.substring(0,2).toString():
                "------------------";

            return ListTile(
              leading: (image == null)? CircleAvatar(child: Icon(Icons.person),):
              CircleAvatar(backgroundImage:MemoryImage(image),
              ),
              title: Text(contacts![index].name.first),
              subtitle: Text(number),
              onTap: (){
                launch('tel:${number}');
              },
            );
          })
      );
  }
}