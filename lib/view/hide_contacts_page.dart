import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/contact_provider.dart';
import '../provider/updated_provider.dart';

class HidePage extends StatelessWidget {
  const HidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hide Contacts"),
      ),
      body: Container(
        //color: Colors.red,
        child: Consumer<hide>(
          builder: (context, hideen, _) {
            return ListView(
              children: [
                ...hideen.hidecontact.map((e) {
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
                      trailing: PopupMenuButton(
                        itemBuilder: (context) {
                          return <PopupMenuEntry>[
                            PopupMenuItem(
                              child: Text("Unhide"),
                              onTap: () {
                                Provider.of<hide>(context, listen: false)
                                    .removecontacts(e);
                                Provider.of<Contctprovider>(context,
                                        listen: false)
                                    .addconatctfun(e);
                              },
                            ),
                            PopupMenuItem(
                              child: Text("Delete"),
                              onTap: () {
                                Provider.of<Contctprovider>(context,
                                        listen: false)
                                    .removeconatctfun(e);
                              },
                            )
                          ];
                        },
                      ),
                    ),
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
