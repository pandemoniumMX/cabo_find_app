import 'dart:convert';
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'package:json_store/json_store.dart';

class Preparing extends StatefulWidget {
  Preparing({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Preparing> {
  //List<Dish> _dishes = List<Dish>();

/*
Future loadStudent() async {
  String jsonString = _cartList;//await _loadAStudentAsset();
  final jsonResponse = json.decode(jsonString);
  Cart student = new Cart.fromJson(jsonResponse);
  print(student.);
}
Future<String> printDailyNewsDigest() async {
  String data =  await Cart;
final jsonResult = json.decode(data);
}*/
  String encodedData;
  Cart serverData;

  @override
  void initState() {
    super.initState();
    _populateDishes();

    // serverData = new Cart(_orden, _costos, _nota);
    // encodeData = jsonEncode(serverData);
    ///print(encodeData);

    // Map<String, dynamic> user = jsonDecode(serverData);
    //var name = user['user']['name'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Regresar'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 8.0),
            child: GestureDetector(
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Icon(
                    Icons.shopping_cart,
                    size: 36.0,
                  ),
                  //    if (_cartList.length > 0)
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: CircleAvatar(
                      radius: 8.0,
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      child: Text(
                        '1', //  _cartList.length.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () {
                /*    if (_cartList.isNotEmpty)
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Carts(_cartList),
                    ),
                  );*/
              },
            ),
          )
        ],
      ),
      body: Text('NADA'),
    );
  }

  /*ListView _buildListView() {
    return ListView.builder(
      itemCount: _cartList.length,
      itemBuilder: (context, index) {
        var item = _cartList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 2.0,
          ),
          child: Card(
            elevation: 2.0,
            child: ListTile(
              title: Text('jeje'),
              trailing: GestureDetector(
                child: (!_cartList.contains(item))
                    ? Icon(
                        Icons.add_circle,
                        color: Colors.green,
                      )
                    : Icon(
                        Icons.remove_circle,
                        color: Colors.red,
                      ),
                onTap: () {
                  setState(() {
                    if (!_cartList.contains(item))
                      _cartList.add(item);
                    else
                      _cartList.remove(item);
                  });
                },
              ),
            ),
          ),
        );
      },
    );
  }*/

  void _populateDishes() {
    var list = <Dish>[
      Dish(
        name: 'Chicken Zinger',
        icon: Icons.fastfood,
        color: Colors.amber,
      ),
      Dish(
        name: 'Chicken Zinger without chicken',
        icon: Icons.print,
        color: Colors.deepOrange,
      ),
      Dish(
        name: 'Rice',
        icon: Icons.child_care,
        color: Colors.brown,
      ),
      Dish(
        name: 'Beef burger without beef',
        icon: Icons.whatshot,
        color: Colors.green,
      ),
      Dish(
        name: 'Laptop without OS',
        icon: Icons.laptop,
        color: Colors.purple,
      ),
      Dish(
        name: 'Mac wihout macOS',
        icon: Icons.laptop_mac,
        color: Colors.blueGrey,
      ),
    ];

    setState(() {
      // _cartList = list;
    });
  }
}

class UserList {
  final List<Cart> users;
  UserList(this.users);

  UserList.fromJson(List<dynamic> usersJson)
      : users = usersJson.map((user) => Cart.fromJson(user)).toList();
}
