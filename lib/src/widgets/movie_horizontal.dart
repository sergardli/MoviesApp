import 'package:flutter/material.dart';

import 'package:movies/src/models/movie.dart';


class MovieHorizontal extends StatelessWidget {
  
  final List<Movie> movies;

  final Function nextPage;

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.25
  );



  MovieHorizontal({ @required this.movies, @required this.nextPage });


  @override
  Widget build(BuildContext context) {
    
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener( (){
      if (_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200) {
        nextPage();
      }
    });



    return Container(
      height: _screenSize.height * 0.25,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: movies.length,
        itemBuilder: (context, i) => _movieCard(context, movies[i]),
      ),
    );
  }



  Widget _movieCard(BuildContext context, Movie movie) {
    return Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            
            child: FadeInImage(
              placeholder: AssetImage( 'assets/img/no-image.jpg' ), 
              image: NetworkImage( movie.getPosterImg() ),
              fit: BoxFit.cover,
              height: 120.0,
            ),
          ),

          SizedBox(height: 5),

          Text( 
            movie.title, 
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,  
          )
        ],
      ),
    );
  }


  List<Widget> _listMovies(BuildContext context) {

    return movies.map( (movie) {

      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              
              child: FadeInImage(
                placeholder: AssetImage( 'assets/img/no-image.jpg' ), 
                image: NetworkImage( movie.getPosterImg() ),
                fit: BoxFit.cover,
                height: 120.0,
              ),
            ),

            SizedBox(height: 5),

            Text( 
              movie.title, 
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,  
            )
          ],
        ),
      );
    }).toList();
  }
}