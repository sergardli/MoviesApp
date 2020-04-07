import 'package:flutter/material.dart';
import 'package:movies/src/models/movie.dart';
import 'package:movies/src/providers/movies_provider.dart';


class DataSearch extends SearchDelegate {
  
  String selection = "";
  final moviesProvider = new MoviesProvider();

  final movies = [
    'Spiderman',
    'Capt America',
    'Ironman',
    'Shazam',
    'Avengers',
    'It'
  ];


  final moviesRecent = [
    'Spiderman',
    'Capt America',
    'Ironman'
  ];


  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro appBar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        }
      ),


    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del appBar 
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),

      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.black87,
        child: Text(selection),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe
    
    if ( query.isEmpty ) 
      return Container();

    
    return FutureBuilder(
      future: moviesProvider.searchMovie( query ),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
      
        if( snapshot.hasData ) {
          final movies = snapshot.data;
          
          return ListView(
            children: movies.map( (movie) {

              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: FadeInImage( 
                    image: NetworkImage( movie.getPosterImg() ), 
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    width: 45.0,
                    fit: BoxFit.cover,
                  ),
                ),

                title: Text( movie.title ),
                subtitle: Text( movie.originalTitle ),
                onTap: () {
                  close(context, null);
                  movie.uniqueId = '';
                  Navigator.pushNamed(context, 'movieDetails', arguments: movie);
                },
              );

            }).toList(),
          );
        }
        
        else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );
  }
}