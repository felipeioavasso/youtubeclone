import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:youtube/model/video.dart';


/* chaves */

final URL_BASE = 'https://www.googleapis.com/youtube/v3/';

class Api {
  // valores vindos da API do youtube
  Future <List<Video>> pesquisar (String pesquisa) async {
    http.Response response = await http.get(Uri.parse(URL_BASE +
     "search" 
    "?part=snippet"
    "&type=video"
    "&maxResults=30"
    "&order=date"
    "&key=$CHAVE_YOUTUBE_API"
    //"&key=$API_KEY"
    //"&channelId=$ID_CANAL"    // busca pelos videos
    "&q=$pesquisa"
    ) 
   
    );
    
    //Recuperando os videos da API do youtube via Json
    Map<String, dynamic> dadosJson = json.decode( response.body );

    List<Video> videos = dadosJson['items'].map<Video>(
      (map){
        //return Video.converterJson(map);
        return Video.fromJson(map);
      }
    ).toList(); //conversão para lista
    return videos;

    /* if (response.statusCode == 200){


     

      /* for ( var video in videos) {
        print('resultado: ' + video.titulo);
      } */
     /*  for ( var video in dadosJson['items']){
        print('Resultado: ' + video.toString());
      } */
      //print('resultado: ' + dadosJson['items']);

    }else{
      
    } */
    
  }
}

