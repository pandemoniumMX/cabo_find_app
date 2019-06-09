import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cabofind/carousel_pro.dart';
import 'package:cabofind/main.dart';
import 'package:flutter/material.dart';


class Listado extends StatefulWidget {


  @override
_Listado createState() => new _Listado();
}

  class _Listado extends State<Listado> {
    Future<List<User>> _getUsers() async {
    var data= await http.get("http://cabofind.com.mx/app_php/get_slider.php");
    
    var jsonData = json.decode(data.body);

    List <User> users =[];
    for(var u in jsonData){
      User user = User(u["NEG_NOMBRE"], u["GAL_FOTO"]);
      users.add(user);
    }  
    print(users.length);
  
  return users;
  }
    @override
    Widget build(BuildContext context){
      return new  Container(
          child: FutureBuilder(
            future: _getUsers(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.data == null){
                return Container(                  
              child: Center(
                child: Text("Cargando...")
                )                  
                );
              }else{
                return ListView.builder(
                  
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index){
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(snapshot.data[index].picture),
                      ),
                      title: Text(snapshot.data[index].name),
                    );
                  }
                );
              }
              
            },
          ),
          

      );
    }
  }
  

class User {
  
    final String name;
    final String picture;
    User(this.name, this.picture);
  }