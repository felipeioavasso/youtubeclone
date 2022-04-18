import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate <String> {
  
  ///retornando uma lista de widget
  ///aqui estou retornando o botão de fechar (x) na barra de pesquisa
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = '';                     //pesquisa de videos
        },         
      ), 
    ];
  }



  // retorna o botão de voltar na barra de pesquisa.
  @override
  Widget? buildLeading(BuildContext context) {
    return 
      IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: (){
          close(context, '');
          //Navigator.pop(context);
        }, 
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    close(context, query);
    return Container();  
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List <String> lista = [];

    if ( query.isNotEmpty ){
      /* lista = [
        'android'
      ].where((texto) => texto.toLowerCase().startsWith(query.toLowerCase())).toList(); */

      lista = [];

      return ListView.builder(
        itemCount: lista.length,
        itemBuilder: (context, index){

          return ListTile(
            title: Text(lista[index]),
            onTap: (){
              close(context, lista[index]);
            },
          );
        }
      );
    }else{
      return const Center(
        child: Text('nenhum resultado para a pesquisa'),
      );
    }    
  }
}