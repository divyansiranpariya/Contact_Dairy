import 'package:contact_dairy/provider/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/contact_provider.dart';

class Favoutite extends StatelessWidget {
  const Favoutite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourite Contacts"),
      ),
      body: Container(
        //color: Colors.red,
        child: Consumer<Themeprovider>(
          builder: (context, fav, _) {
            return ListView(
              children: [
                ...fav.allfav.map((e) {
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: ListTile(
                        title: Text(
                          e.name,
                          style: TextStyle(fontSize: 15),
                        ),
                        subtitle: Text(
                          e.contact,
                          style: TextStyle(fontSize: 13),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            Provider.of<Themeprovider>(context, listen: false)
                                .favouriteremove(e);
                          },
                          icon: (Provider.of<Themeprovider>(context).fav.isfav)
                              ? Icon(
                                  Icons.star_border_purple500_sharp,
                                  color: Colors.orange,
                                )
                              : Icon(
                                  Icons.star_border_purple500_sharp,
                                ),
                        )),
                  );
                }),
              ],
            );
          },
        ),
      ),
    );
  }
}
