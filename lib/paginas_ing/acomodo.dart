import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            padding: EdgeInsets.only(left: 10.0, bottom: 0.0),
            alignment: Alignment.bottomCenter,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        child: Text(
                          'No te lo puedes perder',
                          textAlign: TextAlign.center,
                          //overflow: TextOverflow.ellipsis,

                          style: TextStyle(

                              color: Color(0XFF000000),
                              fontSize:25.0,
                              fontWeight: FontWeight.bold),
                        )

                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    new RaisedButton(
                      padding: const EdgeInsets.all(8.0),
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: null,
                      child: new Text("Lo nuevo"),
                    ),
                    new RaisedButton(
                      padding: const EdgeInsets.all(8.0),
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: null,
                      child: new Text("Lo más visitado"),
                    ),
                    new RaisedButton(
                      padding: const EdgeInsets.all(8.0),
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: null,
                      child: new Text("Recomendado"),
                    ),
                    new RaisedButton(
                      padding: const EdgeInsets.all(8.0),
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: null,
                      child: new Text("Promociones"),
                    ),
                  ],
                )
              ],
            )));
  }
}