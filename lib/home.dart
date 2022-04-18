import 'package:flutter/material.dart';
import 'package:youtube/telas/biblioteca.dart';
import 'package:youtube/telas/emAlta.dart';
import 'package:youtube/telas/inicio.dart';
import 'package:youtube/telas/inscricao.dart';

import 'customSearchDelegate.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _indicAtual = 0;
  String _resultado = '';                         //pesquisa de videos

  @override
  Widget build(BuildContext context) {


    // lista de widgets bottom navigation bar - INICIO    
    List<Widget> telas = [
      Inicio(_resultado),                         //pesquisa de videos
      const EmAlta(),
      const Inscricao(),
      const Biblioteca(),
    ];
    // lista de widgets bottom navigation bar - FIM


    // Retornando a estrutura (esqueleto) da página
    return Scaffold(

      // APPBAR
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.grey,
          opacity: 1,
        ),
        backgroundColor: Colors.white,
        title: Image.asset(
          'imagens/youtube.png',
          width: 98,
          height: 22,
        ),


        
        actions: <Widget>[

          // Botão de pesquisa - INICIO
          IconButton(
            onPressed: () async {
              String? res = await showSearch(
                context: context, 
                delegate: CustomSearchDelegate(),
              );
              setState(() {
              _resultado = res!;                  //pesquisa de videos
              });
              //print('resultado: ' + res);
            }, 
            icon: Icon(Icons.search),
          ),
          // Botão de pesquisa - FIM

        
          /* IconButton(
            onPressed: (){
              print('ação videocam');
            }, 
            icon: Icon(Icons.videocam),
          ),

          IconButton(
            onPressed: (){
              print('ação pesquisa');
            }, 
            icon: Icon(Icons.search),
          ),

          IconButton(
            onPressed: (){
              print('ação conta');
            }, 
            icon: const Icon(Icons.account_circle),
          ), */

        ],        
      ),



      // BODY
      body: Container(
        padding: const EdgeInsets.all(16),
        child: telas[_indicAtual],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indicAtual,
        onTap: (indice){
          setState(() {
            _indicAtual = indice;
          });
        },
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        
        items: const [
          BottomNavigationBarItem(
            label: 'Inicio',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Em alta',
            icon: Icon(Icons.whatshot),
          ),
          BottomNavigationBarItem(
            label: 'Inscrições',
            icon: Icon(Icons.subscriptions),
          ),
          BottomNavigationBarItem(
            label: 'Biblioteca',
            icon: Icon(Icons.folder),
          ),
        ],
      ),
    );
  }
}