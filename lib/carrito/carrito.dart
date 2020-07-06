import 'dart:convert';

import 'package:cabofind/carrito/cart_bloc.dart';
import 'package:cabofind/utilidades/classes.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

//void main() => runApp(Carrito(post: fetchPost()));

class Carrito extends StatefulWidget {
  Carrito({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Carrito> {
  Future<Post> fetchPost() async {
    final response =
        await http.get('https://jsonplaceholder.typicode.com/posts/1');

    if (response.statusCode == 200) {
      // Si la llamada al servidor fue exitosa, analiza el JSON
      return Post.fromJson(json.decode(response.body));
    } else {
      // Si la llamada no fue exitosa, lanza un error.
      throw Exception('Failed to load post');
    }
  }

  List<Post> _dishes = List<Post>();

  List<Post> _cartList = List<Post>();

  @override
  void initState() {
    super.initState();
    // _populateDishes();
  }

  @override
  Widget build(BuildContext context) {
    Widget cuerpa = FutureBuilder<Post>(
      future: fetchPost(),
      builder: (context, snapshot) {
        var item = snapshot.data.id;
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return Center(
                  child: Text(
                "Error :(",
                style: TextStyle(color: Color(0xff01969a), fontSize: 25.0),
                textAlign: TextAlign.center,
              ));
            } else {
              //print();
              return Card(
                elevation: 4.0,
                child: ListTile(
                  title: Text(snapshot.data.title),
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
              );
            }
        }
      },
    );
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
                  if (_cartList.length > 0)
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: CircleAvatar(
                        radius: 8.0,
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        child: Text(
                          _cartList.length.toString(),
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
                if (_cartList.isNotEmpty)
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Carts(_cartList),
                    ),
                  );
              },
            ),
          )
        ],
      ),
      body: cuerpa,
    );
  }
/*
  ListView _buildListView() {
    return ListView.builder(
      itemCount: _dishes.length,
      itemBuilder: (context, index) {
        var item = _dishes[index];
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 2.0,
          ),
          child: Card(
            elevation: 4.0,
            child: ListTile(
              leading: Icon(
                item.icon,
                color: item.color,
              ),
              title: Text(item.name),
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
  }


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
      _dishes = list;
    });
  }

*/
}
