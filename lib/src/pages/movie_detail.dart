import 'package:flutter/material.dart';

import 'package:movies/src/providers/movies_provider.dart';

import 'package:movies/src/models/actor.dart';
import 'package:movies/src/models/movie.dart';


class MovieDetailPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context).settings.arguments;


    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _createAppBar(movie),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox( height: 20.0 ),
                _posterTitle(context, movie),
                
                SizedBox(height: 30.0),
                Container(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text('Descripción', style: Theme.of(context).textTheme.subtitle)
                ),
                _description(movie),

                SizedBox(height: 20.0),
                Container(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text('Actores', style: Theme.of(context).textTheme.subtitle)
                ),
                
                SizedBox(height: 20.0),
                _createCasting(movie)
              ]
            )
          ),

        ],
      )
    );
  }


  Widget _createAppBar(Movie movie) {

    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.black87,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Container( child: Text( movie.title, style: TextStyle(color: Colors.white, fontSize: 16.0) )),

        background: FadeInImage(
          placeholder: AssetImage('assets/img/loading.gif'), 
          image: NetworkImage(movie.getBackdropImg()),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }


  Widget _posterTitle( BuildContext context, Movie movie ) {

    return Container(
      padding: EdgeInsets.symmetric( horizontal: 20.0 ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              image: NetworkImage( movie.getPosterImg() ),
              height: 150.0,
            ),
          ),

          SizedBox(width: 20.0),

          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text( movie.title, style: Theme.of(context).textTheme.title, overflow: TextOverflow.ellipsis ),
                Text( movie.originalTitle, style: Theme.of(context).textTheme.subhead, overflow: TextOverflow.ellipsis ),
                SizedBox( height: 10.0 ),
                Row(
                  children: <Widget>[
                    Icon( Icons.star_border ),
                    Text( movie.voteAverage.toString(), style: Theme.of(context).textTheme.subhead ),
                  ],
                )
              ],
            )
          )
        ],
      ),
    );
  }


  Widget _description( Movie movie ) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Text(
        movie.overview,
        // textAlign: TextAlign.justify,
      ),
    );
  }


  Widget _createCasting( Movie movie ) {

    final moviesProvider = new MoviesProvider();

    return FutureBuilder(
      future: moviesProvider.getCast( movie.id.toString() ),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        
        if (snapshot.hasData)
          return _createActorsPageView( snapshot.data );
        else
          return Center(child: CircularProgressIndicator());

      },
    );
  }


  Widget _createActorsPageView( List<Actor> actors ) {

    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1
        ),

        pageSnapping: false,
        itemCount: actors.length,
        itemBuilder: (context, index) => _actorCard( context, actors[index] )
      ),
    );
  }


  Widget _actorCard(BuildContext context, Actor actor) {
    
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage('asset/img/no-image.jpg'), 
              image: NetworkImage( actor.getProfileImg() ),
              height: 150.0,
              fit: BoxFit.cover
            ),
          ),
          SizedBox(height: 5.0),
          Text( 
            actor.name,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
           )
        ],
      ),
    );
  }

}