import 'package:flutter/material.dart';
import 'package:youtube/api.dart';
//import 'package:flutter_youtube/flutter_youtube.dart';
//import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../model/video.dart';

class Inicio extends StatefulWidget {

  String pesquisa;              //pesquisa de videos
  Inicio (this.pesquisa);       //pesquisa de videos


  //const Inicio({ Key? key }) : super(key: key);

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {

  /* final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: '',
    flags: const YoutubePlayerFlags(
      autoPlay: true,
    ),
  ); */

  
  _listarVideos(String pesquisa){   //pesquisa de videos

    FutureBuilder<List<Video>> videos;

    Api api = Api();
    //videos = api.pesquisar('') as FutureBuilder<List<Video>>;

    return api.pesquisar( pesquisa ); //pesquisa de videos
  }
 
  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<Video>>(
      future: _listarVideos(widget.pesquisa),   //pesquisa de videos
      builder: (context, Snapshot) {
        switch(Snapshot.connectionState){
          case ConnectionState.none : 
          case ConnectionState.waiting : 
            return const Center(
              child: CircularProgressIndicator(),
            );
            break;
          case ConnectionState.active : 
          case ConnectionState.done :
            if(Snapshot.hasData){

              return ListView.separated(
                itemBuilder: (context, index){

                  List<Video>? videos = Snapshot.data;
                  Video video = videos![index];

                  return GestureDetector(
                    onTap: (){
                      
                      /* FlutterYoutube.playYoutubeVideoById(
                        apiKey: CHAVE_YOUTUBE_API, 
                        videoId: video.id
                      ); */
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(video.imagem), 
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(video.titulo),
                          subtitle: Text(video.canal),
                        ),
                      ],
                    ),
                  );
                }, 
                separatorBuilder: (context, index) => const Divider(
                  height: 2,
                  color: Colors.grey,
                ), 
                itemCount: Snapshot.data!.length
              );
              
            }else{
              return const Center(
                child: Text('Nenhum dado a ser exibido'),
              );
            }
            
            break; 
        }
      }
    );
  }
}