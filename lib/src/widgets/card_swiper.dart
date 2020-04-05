import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies/src/models/movie.dart';


class CardSwiper extends StatelessWidget {
  
  final List<Movie> movies;

  // Obliga a que el parámetro sea obligatorio
  CardSwiper( { @required this.movies } );

  
  @override
  Widget build(BuildContext context) {

    final _sizeScreen = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only( top: 15.0 ),
      
      child: Swiper(
        /* Configuración del Swiper
        pagination: SwiperPagination(),
        control: SwiperControl(), 
        */
        layout: SwiperLayout.STACK,
        itemWidth: _sizeScreen.width * 0.6,
        itemHeight: _sizeScreen.height * 0.5,
        itemCount: movies.length,

        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular( 10.0 ),
            child: FadeInImage(
              placeholder: AssetImage( 'assets/img/loading.gif' ), 
              image: NetworkImage( movies[index].getPosterImg() ),
              fit: BoxFit.cover,
            )
          );
        },
      ),
    );
  }
}