import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {

  final List<Pelicula> peliculas;

  CardSwiper({
    @required this.peliculas
  });

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;
    final _itemHeight = _screenSize.height * 0.5;
    final _itemWidth = _screenSize.height * 0.5 * 0.65;

    return Container(
      // padding: EdgeInsets.only(top: 5.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _itemWidth,
        itemHeight: _itemHeight,
        itemBuilder: (BuildContext context,int index){
          return _tarjeta(context, peliculas[index]);
        },
        itemCount: peliculas.length,
        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula) {

    pelicula.uniqueID = '${pelicula.id}-swiper';

    final tarjeta = Hero(
            tag: pelicula.uniqueID,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'), 
                image: NetworkImage(pelicula.getPosterImage()),
                fit: BoxFit.cover,
              )
            ),
          );

    return GestureDetector(
      child: tarjeta,
      onTap: () {
        Navigator.pushNamed(
          context,
          'detalle',
          arguments: pelicula);
      },
    );
  }
}