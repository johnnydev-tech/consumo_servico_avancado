import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'Post.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  
  String _urlBase = "https://jsonplaceholder.typicode.com";

    Future<List<Post>> _recuperarPostagens() async {

      http.Response response = await http.get(_urlBase + "/posts");
      var dadosJson = json.decode(response.body);

      List<Post> postagens = List();

      for(var post in dadosJson){
        print("post:" + post["title"]);
       Post p = Post(post["userID"], post["id"], post["title"] ,post["body"]);
       postagens.add(p);
      }
      return postagens;
    }

    _post() async{

      Post post = new Post(120, null, "Titulo", "Corpo da mensagem");

      var corpo = json.encode(
        post.toJson()
      );

      http.Response response = await http.post(
        _urlBase+"/posts",
        headers:{ "Content-type": "application/json; charset=UTF-8"},
        body: corpo
      );
      print("resposta: ${response.statusCode}");
      print("resposta: ${response.body}");

    }




    _put() async{

      Post post = new Post(120, null, "Titulo", "Corpo da mensagem");

      var corpo = json.encode(
          post.toJson()
      );


      http.Response response = await http.put(
          _urlBase+"/posts/2",
          headers:{ "Content-type": "application/json; charset=UTF-8"},
          body: corpo
      );
      print("resposta: ${response.statusCode}");
      print("resposta: ${response.body}");

    }

    _patch()async{

      Post post = new Post(120, null, "Titulo", "Corpo da mensagem alterado");

      var corpo = json.encode(
          post.toJson()
      );


      http.Response response = await http.patch(
          _urlBase+"/posts/2",
          headers:{ "Content-type": "application/json; charset=UTF-8"},
          body: corpo
      );
      print("resposta: ${response.statusCode}");
      print("resposta: ${response.body}");

    }
    _delete()async{
      http.Response response = await http.delete(
        _urlBase+"/posts/2"
      );
      print("resposta: ${response.statusCode}");
      print("resposta: ${response.body}");
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de serviço avançado",
        style: TextStyle(
          color: Colors.white,
        ),
        ),
        backgroundColor: Colors.lightBlue,
      ),

      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child:  Text("Salvar",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      ),
                    ),
                    color: Colors.lightBlue,
                    splashColor: Colors.lightGreen,
                    onPressed: _post,
                  ),

                  RaisedButton(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child:  Text("Alterar",
                        style: TextStyle(
                         color: Colors.white,
                        ),
                        ),
                    ),
                    color: Colors.lightBlue,
                    splashColor: Colors.yellowAccent,
                    onPressed: _patch,
                  ),

                  RaisedButton(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child:  Text("Deletar",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    color: Colors.lightBlue,
                    splashColor: Colors.red,
                    onPressed: _delete,
                  ),


                ],
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              height: 200.0,
              child: ListView(

                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Container(
                        width: 450.0,
                        color: Colors.black12,
                      ),
                      Container(
                        width: 450.0,
                        color: Colors.black54,
                      ),
                      Container(
                        width: 450.0,
                        color: Colors.black,
                      ),
                  

                    ],
                  )

            ),


            Expanded(
                child: FutureBuilder<List<Post>>(

                  future: _recuperarPostagens(),
                  // ignore: missing_return
                  builder: (context, snapshot){

                    switch(snapshot.connectionState){
                      case ConnectionState.none :
                      case ConnectionState.waiting :
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(Colors.lightBlue),
                          ),
                        );
                        break;
                      case ConnectionState.active :
                      case ConnectionState.done :
                        if(snapshot.hasError){
                          print("Erro ao carregar lista!");
                        }else{
                          print("Lista carregada!");
                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index){

                                List<Post> lista = snapshot.data;
                                Post post = lista[index];

                                return ListTile(
                                  title: Text(post.id.toString()),
                                  subtitle: Text(post.title),
                                  onLongPress: (){

                                  },
                                );
                              }
                          );
                        }
                        break;
                    }
                  },
                ),
            ),


          ],
        ),
      )
    );
  }
}
