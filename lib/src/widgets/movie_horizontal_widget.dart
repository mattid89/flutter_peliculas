import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  // const MovieHorizontal({Key key}) : super(key: key);

  final List<Pelicula> peliculas;
  final Function siguientePagina;

  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    final _pageController = PageController(
      initialPage: 1,
      viewportFraction: 0.3,
    );

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        siguientePagina();
      }
    });

    return Container(
      height: _screenSize.height * 0.25,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: peliculas.length,
        itemBuilder: (context, i) => _tarjeta(context, peliculas[i], _screenSize),
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula, Size size) {

    final tarjeta = Container(
      margin: EdgeInsets.only(right: 5.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage(pelicula.getPosterImage()),
              fit: BoxFit.cover,
              height: size.height * 0.20,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
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

//   List<Widget> _tarjetas(BuildContext context) {
//     return peliculas.map((pelicula) {
//       return Container(
//         margin: EdgeInsets.only(right: 5.0),
//         child: Column(
//           children: <Widget>[
//             ClipRRect(
//               borderRadius: BorderRadius.circular(10.0),
//               child: FadeInImage(
//                 placeholder: AssetImage('assets/img/no-image.jpg'),
//                 image: NetworkImage(pelicula.getPosterImage()),
//                 fit: BoxFit.cover,
//                 height: 160.0,
//               ),
//             ),
//             SizedBox(
//               height: 5.0,
//             ),
//             Text(
//               pelicula.title,
//               overflow: TextOverflow.ellipsis,
//               style: Theme.of(context).textTheme.caption,
//             ),
//           ],
//         ),
//       );
//     }).toList();
//   }
}
