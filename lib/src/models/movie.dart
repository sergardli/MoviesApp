class Movies {

  List<Movie> items = new List();

  Movies();

  Movies.fromJsonList( List<dynamic> jsonList ) {
    
    if (jsonList == null) return;

    else {
      for (var item in jsonList) {
        final movie = Movie.fromJsonMap(item);
        
        this.items.add( movie );
      }
    }
  }

}


class Movie {
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Movie({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });


  Movie.fromJsonMap( Map<String, dynamic> json ) {

    popularity          = json['popularity'] / 1;
    video               = json['video'];
    voteCount           = json['vote_count'];
    posterPath          = json['poster_path'];
    id                  = json['id'];
    adult               = json['adult'];
    backdropPath        = json['backdrop_path'];
    originalLanguage    = json['original_language'];
    originalTitle       = json['original_title'];
    genreIds            = json['genre_ids'].cast<int>();
    title               = json['title'];
    voteAverage         = json['vote_average']  / 1;
    overview            = json['overview'];
    releaseDate         = json['release_date'];


  }


  getPosterImg() {

    if( posterPath == null )
      return 'https://lh3.googleusercontent.com/proxy/PyT8dpQT8UKgbzlIFz6VuvYLpMVHwcnV9b2GTu4t1J9v8nLsUmcdAGE6pbmwXCZLRMrx2dsLnm_j7JjYoXHejl4nTu42FqxvGw3YHDk3FcWhOn-cghhzc2y3swPmcnLsivQTbV3dTDC-7w';
    else
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
  }


  getBackdropImg() {
    
    if( backdropPath == null )
      return  'https://lh3.googleusercontent.com/proxy/PyT8dpQT8UKgbzlIFz6VuvYLpMVHwcnV9b2GTu4t1J9v8nLsUmcdAGE6pbmwXCZLRMrx2dsLnm_j7JjYoXHejl4nTu42FqxvGw3YHDk3FcWhOn-cghhzc2y3swPmcnLsivQTbV3dTDC-7w';
    else
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
  }
}
