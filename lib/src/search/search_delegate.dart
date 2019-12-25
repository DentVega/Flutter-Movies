import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro appBar
    return [IconButton(icon: Icon(Icons.clear), onPressed: () {
      print('CLICK!!');
      query = '';
    })];
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
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe
    return Container();
  }
}
