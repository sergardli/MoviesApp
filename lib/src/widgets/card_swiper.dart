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
        itemWidth: _sizeScreen.width * 0.5,
        itemHeight: _sizeScreen.height * 0.5,
        itemCount: movies.length,

        itemBuilder: (BuildContext context, int index) {

          movies[index].uniqueId = '${movies[index].id}-cardSwiper';

          /*return Hero(
            tag: movies[index].uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular( 20.0 ),
              child: GestureDetector(
                child: FadeInImage(
                  placeholder: AssetImage( 'assets/img/loading.gif' ), 
                  image: NetworkImage( movies[index].getPosterImg() ),
                  fit: BoxFit.cover,
                ),

                onTap: () => Navigator.pushNamed(context, 'movieDetails', arguments: movies[index]),
              )
            ),
          ); */

          return ClipRRect(
            borderRadius: BorderRadius.circular( 20.0 ),
            child: GestureDetector(
              child: FadeInImage(
                placeholder: AssetImage( 'assets/img/loading.gif' ), 
                image: NetworkImage( movies[index].getPosterImg() ),
                fit: BoxFit.cover,
              ),

              onTap: () => Navigator.pushNamed(context, 'movieDetails', arguments: movies[index]),
            )
          );
        },
      ),
    );
  }
}