import 'package:flutter/material.dart';
import 'package:movies/src/providers/movies_provider.dart';

import 'package:movies/src/widgets/card_swiper.dart';


class HomePage extends StatelessWidget {
  
  final moviesProvider = MoviesProvider();

  @override
  Widget build(BuildContext context) {
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
          children: <Widget>[
            _swiperCards(),
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
}