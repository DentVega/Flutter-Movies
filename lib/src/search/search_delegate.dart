import 'package:flutter/material.dart';
import 'package:movies_app/src/models/pelicula_model.dart';
import 'package:movies_app/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {
  final peliculas = [
    'Spiderman',
    'Capitan America',
    'Batman',
    'Iron-Man',
    'Iron-Man 2',
    'Iron-Man 3',
    'Shazam!',
    'Superman'
  ];
  final peliculasRecientres = ['Spiderman', 'Capitan America'];
  String seleccion = '';
  final peliculasProvider = new PeliculasProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro appBar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            print('CLICK!!');
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del appBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        print('Leading Icons Press');
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Es el builder que crea los resultados que mostraremos
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe
    if (query.isEmpty) {
      return Container();
    } else {
      return FutureBuilder(
          future: peliculasProvider.buscarPelicula(query),
          builder:
              (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
            if (snapshot.hasData) {
              final peliculas = snapshot.data;
              return ListView(
                children: peliculas.map((pelicula) {
                  return ListTile(
                    leading: FadeInImage(
                      image: NetworkImage(pelicula.getPosterImg()),
                      placeholder: AssetImage('assets/img/no-image.jpg'),
                      width: 50.0,
                      fit: BoxFit.contain,
                    ),
                    title: Text(pelicula.title),
                    subtitle: Text(pelicula.originalTitle),
                    onTap: () {
                      close(context, null);
                      pelicula.uniqueId = '';
                      Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                    },
                  );
                }).toList()
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          });
    }
  }

//  @override
//  Widget buildSuggestions(BuildContext context) {
//    // Son las sugerencias que aparecen cuando la persona escribe
//    final listaSugerida = (query.isEmpty)
//        ? peliculasRecientres
//        : peliculas
//            .where((p) => p.toLowerCase().startsWith(query.toLowerCase()))
//            .toList();
//
//    return ListView.builder(
//        itemCount: listaSugerida.length,
//        itemBuilder: (context, index) {
//          return ListTile(
//            leading: Icon(Icons.movie),
//            title: Text(listaSugerida[index]),
//            onTap: () {
//              seleccion = listaSugerida[index];
//              showResults(context);
//            },
//          );
//        });
//  }
}
