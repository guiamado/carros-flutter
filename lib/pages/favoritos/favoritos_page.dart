import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carros_listview.dart';
import 'package:carros/pages/favoritos/favoritos_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritosPage extends StatefulWidget {
  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage>
    with AutomaticKeepAliveClientMixin<FavoritosPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    FavoritosModel model = Provider.of<FavoritosModel>(context, listen: false);
    model.getCarros();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    FavoritosModel model = Provider.of<FavoritosModel>(context);
    List<Carro> carros = model.carros;
    if (carros.isEmpty) {
      return Center(
        child: Text(
          'Nenhum carro nos favoritos',
          style: TextStyle(fontSize: 20),
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: CarrosListView(carros),
    );
  }

  Future<void> _onRefresh() {
    FavoritosModel model = Provider.of<FavoritosModel>(context, listen: false);
    return model.getCarros();
  }
}
