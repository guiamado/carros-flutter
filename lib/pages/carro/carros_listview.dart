import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carro_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class CarrosListView extends StatelessWidget {
  List<Carro> carros;

  CarrosListView(this.carros);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: carros != null ? carros.length : 0,
        itemBuilder: (context, index) {
          Carro c = carros[index];
          return InkWell(
            onTap: () {
              _onClickCarro(context, c);
            },
            onLongPress: () {
              _onLongClickCarro(context, c);
            },
            child: Card(
              color: Colors.grey[100],
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: CachedNetworkImage(
                        imageUrl: c.urlFoto ??
                            'https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/esportivos/Ferrari_FF.png',
                        width: 250,
                      ),
                    ),
                    Text(
                      c.nome,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    Text(
                      'Descrição...',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: const Text('DETALHES'),
                          onPressed: () => _onClickCarro(context, c),
                        ),
                        FlatButton(
                          child: const Text('SHARE'),
                          onPressed: () => _onClickShare(context, c),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _onClickCarro(context, Carro c) {
    push(context, CarroPage(c));
  }

  void _onLongClickCarro(BuildContext context, Carro c) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  c.nome,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Text('Detalhes'),
                leading: Icon(
                  Icons.directions_car,
                  color: Colors.blue,
                ),
                onTap: () {
                  pop(context);
                  _onClickCarro(context, c);
                },
              ),
              ListTile(
                title: Text('Share'),
                leading: Icon(
                  Icons.share,
                  color: Colors.blue,
                ),
                onTap: () {
                  pop(context);
                  _onClickShare(context, c);
                },
              ),
            ],
          );
        });
  }

  void _onClickShare(BuildContext context, Carro c) {
    print('share ${c.nome}');
    Share.share(c.urlFoto);
  }
}
