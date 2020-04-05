import 'package:flutter/material.dart';
import 'package:movies/src/providers/movies_provider.dart';

import 'package:movies/src/widgets/card_swiper.dart';
import 'package:movies/src/widgets/movie_horizontal.dart';


class HomePage extends StatelessWidget {
  
  final moviesProvider = MoviesProvider();

  @override
  Widget build(BuildContext context) {

    moviesProvider.getPopulars();

    return Scaffold(
      appBar: AppBar(
        title: Text('Movies App'),
        centerTitle: false,
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon( Icons.search ), 
            onPressed: () {},
          )
        ],
      ),

      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: <Widget>[
            _swiperCards(),
            SizedBox(height: 40),
            _footer(context)
          ],
        ),
      ),
    );
  }


  Widget _swiperCards() {

    return FutureBuilder(
      future: moviesProvider.getOnTheaters(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        
        if( snapshot.hasData )
          return CardSwiper( movies: snapshot.data );
        else {
          return Container(height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }


  Widget _footer(BuildContext context) {

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 15.0),
            child: Text('Populares', style: Theme.of(context).textTheme.subhead)
          ),

          SizedBox(height: 10),
          
          StreamBuilder(
            stream: moviesProvider.popularsStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if( snapshot.hasData ) 
                return MovieHorizontal(
                  movies: snapshot.data,
                  nextPage: moviesProvider.getPopulars);
              else
                return Center(child: CircularProgressIndicator());
            },
          ),

        ],
      ),
    );
  }
}