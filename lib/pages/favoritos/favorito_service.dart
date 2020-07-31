import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carro_dao.dart';
import 'package:carros/pages/favoritos/favorito.dart';
import 'package:carros/pages/favoritos/favorito_dao.dart';
import 'package:carros/pages/favoritos/favoritos_bloc.dart';
import 'package:provider/provider.dart';

class FavoritoService {
  static Future<bool> favoritar(context, Carro c) async {
    Favorito f = Favorito.fromCarro(c);

    final dao = FavoritoDAO();

    final exists = await dao.exists(c.id);
    if (exists) {
      dao.delete(c.id);
      FavoritosBloc favoritosBloc =
          Provider.of<FavoritosBloc>(context, listen: false);
      favoritosBloc.fetch();
      return false;
    } else {
      dao.save(f);
      FavoritosBloc favoritosBloc =
          Provider.of<FavoritosBloc>(context, listen: false);
      favoritosBloc.fetch();
      return true;
    }
  }

  static Future<List<Carro>> getCarros() async {
    List<Carro> carros = await CarroDAO()
        .query('select * from carro c, favorito f where c.id = f.id');
    return carros;
  }

  static Future<bool> isFavorito(Carro c) async {
    final dao = FavoritoDAO();

    final exists = await dao.exists(c.id);

    return exists;
  }
}
