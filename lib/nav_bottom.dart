import 'package:flutter/material.dart';

class NavBottom extends StatefulWidget {
  @override
  NavToNewPageBottomNavState createState() {
    return new NavToNewPageBottomNavState();
  }
}

class NavToNewPageBottomNavState extends State<NavBottom> {
  int id=0;
  @override
  Widget build(BuildContext context) {

    final tabpages=<Widget>[
      Center(child: Icon(Icons.home,size: 60.0,color: Colors.red,),),
      Center(child: Icon(Icons.map,size: 60.0,color: Colors.red,),),
      Center(child: Icon(Icons.mic,size: 60.0,color: Colors.red,),),
      Center(child: Icon(Icons.radio,size: 60.0,color: Colors.red,),),
      Center(child: Icon(Icons.music_video,size: 60.0,color: Colors.red,),),
    ];

    final bnbi=<BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.star,),title: Text("Inicio")),
      BottomNavigationBarItem(icon: Icon(Icons.fiber_new,),title: Text("Lo nuevo")),
      BottomNavigationBarItem(icon: Icon(Icons.visibility,),title: Text("Más visto")),
      BottomNavigationBarItem(icon: Icon(Icons.favorite,),title: Text("Recomendado")),
      BottomNavigationBarItem(icon: Icon(Icons.bookmark,),title: Text("Publicaciones")),
    ];
    final bnb=BottomNavigationBar(
      items: bnbi,
      currentIndex:id ,
      type: BottomNavigationBarType.fixed,
      onTap: (int value){
        setState(() {
          id=value;
        });
      },
    );
    final header=UserAccountsDrawerHeader(
      accountName: Text("Get more out of Gaana"),
      accountEmail: Text("Login or Register"),
      currentAccountPicture: CircleAvatar(
        child: FlutterLogo(size: 30.0,),
      ),
    );




    return Scaffold(


      body: tabpages[id],
      bottomNavigationBar: bnb,
    );
  }
}