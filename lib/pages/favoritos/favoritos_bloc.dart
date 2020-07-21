import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/simple_bloc.dart';
import 'package:carros/pages/favoritos/favorito_service.dart';

class FavoritosBloc extends SimpleBloc<List<Carro>> {
  Future<List<Carro>> fetch() async {
    try {
      List<Carro> carros = await FavoritoService.getCarros();

      add(carros);
      return carros;
    } catch (e) {
      addError(e);
    }
  }
}
