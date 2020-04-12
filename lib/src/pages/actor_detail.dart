import 'package:flutter/material.dart';

import 'package:movies/src/models/actor.dart';
import 'package:movies/src/models/movie.dart';
import 'package:movies/src/models/person.dart';
import 'package:movies/src/providers/actors_provider.dart';
import 'package:movies/src/providers/people_provider.dart';


class ActorDetails extends StatelessWidget {
  
  final peopleProvider = new PeopleProvider();
  String biography = "";

  @override
  Widget build(BuildContext context) {

    final Actor actor = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text( actor.name ),
      ),
      body: ListView(
        children: <Widget>[
          _createInfo(context, actor),
          SizedBox(height: 20.0),
          _createMovieList(context, actor),
        ],
      ),
    );
  }


  Widget _createInfo(BuildContext context, Actor actor) {

    return FutureBuilder(
      future: peopleProvider.getPeople( actor ),
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        if (snapshot.hasData)
          return _createInfoActor(context, snapshot.data);
        else
          return Container();
      },
    );
  }


  Widget _createInfoActor(BuildContext context, People person) {
    
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric( horizontal: 20.0 ),
          margin: EdgeInsets.only(top: 20.0),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image(
                  image: NetworkImage( person.getProfileImg() ),
                  height: 200.0,
                ),
              ),
              
              SizedBox(width: 15.0),
              
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text( person.name, style: Theme.of(context).textTheme.title, overflow: TextOverflow.ellipsis ),
                  Text( person.knownForDepartment, style: Theme.of(context).textTheme.subhead, overflow: TextOverflow.ellipsis ),
                  
                  SizedBox(height: 20.0),
                  Text( person.birthday, style: Theme.of(context).textTheme.subhead, overflow: TextOverflow.ellipsis ),
                  // Text( person.placeOfBirth, style: Theme.of(context).textTheme.subhead, overflow: TextOverflow.ellipsis, textAlign: TextAlign.right ),
                  SizedBox(height: 10.0),

                  Row(
                    children: <Widget>[
                      Icon( Icons.star_border ),
                      Text( person.popularity.toString(), style: Theme.of(context).textTheme.subhead ),
                    ],
                  )
                ],
              )
            ],
          ),
        
        ),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Text(
            person.biography,
            // textAlign: TextAlign.justify,
          ),
        ),
      ],
    );

  }


  Widget _createMovieList(BuildContext context, Actor actor) {
    final actorsProvider = new ActorsProvider();

    return FutureBuilder(
      future: actorsProvider.getMovies( actor ),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        
        if (snapshot.hasData)

          return _createMoviesPageView( snapshot.data );
        else
          return Center(child: CircularProgressIndicator());

      },
    );
  }


  Widget _createMoviesPageView(List<Movie> movies) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1
        ),

        pageSnapping: false,
        itemCount: movies.length,
        itemBuilder: (context, index) => _movieCard( context, movies[index] )
      ),
    );
  }


  Widget _movieCard(BuildContext context, Movie movie) {
    final movieCard = Container(
      child: Column(
        children: <Widget>[
          /*Hero(
            tag: '${movie.id}-cardSwiper',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'), 
                image: NetworkImage( movie.getPosterImg() ),
                height: 150.0,
                fit: BoxFit.cover
              ),
            ),
          ), */
          
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.jpg'), 
              image: NetworkImage( movie.getPosterImg() ),
              height: 150.0,
              fit: BoxFit.cover
            ),
          ),

          SizedBox(height: 5.0),
          Text( 
            movie.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
           )
        ],
      ),
    );


    return GestureDetector(
      child: movieCard,
      onTap: () {
        
        Navigator.pushNamed(context, 'movieDetails', arguments: movie);
      },
    );
  }
}