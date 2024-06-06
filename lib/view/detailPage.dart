import 'dart:io';

import 'package:contact_dairy/model/contact.dart';
import 'package:contact_dairy/provider/contact_provider.dart';
import 'package:contact_dairy/provider/stepper_provder.dart';
import 'package:contact_dairy/provider/themeprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_extend/share_extend.dart';
import 'package:url_launcher/url_launcher.dart';

import '../provider/image_provider.dart';

class detailPage extends StatelessWidget {
  const detailPage({super.key});

  @override
  Widget build(BuildContext context) {
    Contact detail = ModalRoute.of(context)!.settings.arguments as Contact;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      final steppers =
                          Provider.of<StepperProvider>(context, listen: false);
                      steppers.namecontroller =
                          TextEditingController(text: detail.name);
                      steppers.contactcontroller =
                          TextEditingController(text: detail.contact);
                      steppers.emailcontroller =
                          TextEditingController(text: detail.email);
                      return AlertDialog(
                        title: Text(
                          "Update",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        content: Consumer<StepperProvider>(
                            builder: (context, provides, _) {
                          return Container(
                            height: 600,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Consumer<StepperProvider>(
                                  builder: (context, step, _) {
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 70),
                                      child: CircleAvatar(
                                        radius: 40,
                                        backgroundImage:
                                            step.pickImagePath != null
                                                ? FileImage(step.pickImagePath!)
                                                : null,
                                      ),
                                    );
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 75),
                                  child: TextButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text(
                                                  "Pick Image",
                                                ),
                                                content: Text(
                                                    "Choose Image from gallary or camera "),
                                                actions: [
                                                  // Consumer<imageProvider>(
                                                  //     builder: (context,
                                                  //         imagespro, _) {
                                                  //   return FloatingActionButton(
                                                  //     mini: true,
                                                  //     elevation: 3,
                                                  //     onPressed: () {
                                                  //       Provider.of<imageProvider>(
                                                  //               context,
                                                  //               listen: false)
                                                  //           .pickIm();
                                                  //       Navigator.of(context)
                                                  //           .pop();
                                                  //     },
                                                  //     child: Icon(Icons.camera),
                                                  //   );
                                                  // }),
                                                  Consumer<StepperProvider>(
                                                      builder: (context,
                                                          imagespro, _) {
                                                    return FloatingActionButton(
                                                      mini: true,
                                                      elevation: 3,
                                                      onPressed: () {
                                                        Provider.of<StepperProvider>(
                                                                context,
                                                                listen: false)
                                                            .pickImage();
                                                        print(imagespro
                                                            .pickImagePath);
                                                      },
                                                      child: Icon(Icons
                                                          .browse_gallery_outlined),
                                                    );
                                                  }),
                                                  Consumer<StepperProvider>(
                                                      builder: (context,
                                                          imagespro, _) {
                                                    return FloatingActionButton(
                                                      mini: true,
                                                      elevation: 3,
                                                      onPressed: () {
                                                        Provider.of<StepperProvider>(
                                                                context,
                                                                listen: false)
                                                            .pickImage();
                                                        print(imagespro
                                                            .pickImagePath);
                                                      },
                                                      child: Icon(
                                                          Icons.browse_gallery),
                                                    );
                                                  }),
                                                ],
                                              );
                                            });
                                      },
                                      child: Text("Edit")),
                                ),
                                Text("Name"),
                                SizedBox(
                                  height: 8,
                                ),
                                TextField(
                                  controller: provides.namecontroller,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(6),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Contact"),
                                SizedBox(
                                  height: 8,
                                ),
                                TextField(
                                  controller: provides.contactcontroller,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(6),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Email"),
                                SizedBox(
                                  height: 8,
                                ),
                                TextField(
                                  controller: provides.emailcontroller,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(6),
                                    hintText: "${detail.email}",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 65),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        final provides =
                                            Provider.of<StepperProvider>(
                                                context,
                                                listen: false);
                                        detail.name =
                                            provides.namecontroller.text;
                                        detail.contact =
                                            provides.contactcontroller.text;
                                        detail.email =
                                            provides.emailcontroller.text;
                                        detail.ima = provides.pickImagePath;
                                        Provider.of<Contctprovider>(context,
                                                listen: false)
                                            .updated(detail);
                                        Navigator.of(context).pop('/');
                                      },
                                      child: Text("Update")),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 65),
                                  child: OutlinedButton(
                                      onPressed: () {}, child: Text("Cancle")),
                                )
                              ],
                            ),
                          );
                        }),
                      );
                    });
              },
              icon: Icon(Icons.edit_outlined)),
          IconButton(
            onPressed: () {
              Provider.of<Themeprovider>(context, listen: false)
                  .favouriteadd(detail);
            },
            icon: (Provider.of<Themeprovider>(context).fav.isfav)
                ? Icon(
                    Icons.star_border_purple500_sharp,
                    color: Colors.orange,
                  )
                : Icon(
                    Icons.star_border_purple500_sharp,
                  ),
          ),
          IconButton(
              onPressed: () {
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(100, 50, 0, 0),
                  items: [
                    PopupMenuItem(
                      value: 'share',
                      child: Text('Share'),
                    ),
                    PopupMenuItem(
                      value: 'set_ringtone',
                      child: Text('Set ringtone'),
                    ),
                    PopupMenuItem(
                      value: 'add_to_home_screen',
                      child: Text('Add to home screen'),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        Navigator.of(context).pushNamed('Favoutite');
                      },
                      value: 'favourites',
                      child: Text('favourites'),
                    ),
                    PopupMenuItem(
                        value: 'delete',
                        child: TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Delete Contact?"),
                                    content: Text(
                                        "This contact will be removed from all your suncyed devices."),
                                    actions: [
                                      TextButton(
                                          onPressed: () {},
                                          child: Text("Cancle")),
                                      TextButton(
                                          onPressed: () {
                                            Provider.of<Contctprovider>(context,
                                                    listen: false)
                                                .removeconatctfun(detail);

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                width: 150,
                                                content:
                                                    Text("Deleted Contact"),
                                                backgroundColor: Colors.black,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                              ),
                                            );
                                            Navigator.of(context)
                                                .pushNamedAndRemoveUntil(
                                                    '/', (route) => false);
                                          },
                                          child: Text("Delete")),
                                    ],
                                  );
                                });
                          },
                          child: Text(
                            "Delete",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        )),
                    PopupMenuItem(
                      value: 'help_feedback',
                      child: Text('Help & feedback'),
                    ),
                  ],
                ).then((value) {
                  if (value != null) {
                    print('Selected: $value');
                  }
                });
              },
              icon: Icon(Icons.more_vert)),
          SizedBox(width: 17),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 17, left: 105),
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: FileImage(File(detail.ima!.path)),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 20, bottom: 17, left: 105),
                  //   child: Consumer<imageProvider>(
                  //     builder: (context, step, _) {
                  //       return CircleAvatar(
                  //         radius: 70,
                  //         backgroundImage: step.pickImagePath != null
                  //             ? FileImage(File(step.pickImagePath!))
                  //             : null,
                  //       );
                  //     },
                  //   ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  detail.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                      mini: true,
                      onPressed: () async {
                        await launchUrl(Uri.parse("tel:${detail.contact}"));
                      },
                      child: Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.green,
                    ),
                    FloatingActionButton(
                      onPressed: () async {
                        await launchUrl(Uri.parse("sms:${detail.contact}"));
                      },
                      mini: true,
                      child: Icon(
                        Icons.message_outlined,
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.blue,
                    ),
                    FloatingActionButton(
                      onPressed: () async {
                        await launchUrl(Uri.parse(
                            "mailto:${detail.contact}?subject=Dummy&body=This is dummy message"));
                      },
                      mini: true,
                      child: Icon(
                        Icons.mail_outline_outlined,
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.orange,
                    ),
                    FloatingActionButton(
                      onPressed: () async {
                        await ShareExtend.share(
                            "Name:${detail.name}\n contact:${detail.contact}",
                            "Text");
                      },
                      mini: true,
                      child: Icon(
                        Icons.share,
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.blueGrey,
                    )
                  ],
                ),
              ),
              Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 140,
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Contact info",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 27),
                          child: Row(
                            children: [
                              Icon(
                                Icons.call_outlined,
                                size: 27.6,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(detail.contact),
                                  Text(
                                    "Phone",
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 30,
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.video_call_outlined,
                                          size: 28,
                                        )),
                                    IconButton(
                                        onPressed: () async {
                                          await launchUrl(Uri.parse(
                                              "sms:${detail.contact}"));
                                        },
                                        icon: Icon(
                                          Icons.message_outlined,
                                        )),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Container(
                  height: 110,
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Connected apps",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.whatshot,
                                    size: 27.6,
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    "WhatsApp",
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  size: 20,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                  left: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Contact settings",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            children: [
                              Icon(Icons.receipt),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Reminders",
                                style: Theme.of(context).textTheme.titleMedium,
                              )
                            ],
                          )),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            children: [
                              Icon(Icons.block_rounded),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Block numbers",
                                style: Theme.of(context).textTheme.titleMedium,
                              )
                            ],
                          )),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            children: [
                              Icon(Icons.route_rounded),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Route to voicemail",
                                style: Theme.of(context).textTheme.titleMedium,
                              )
                            ],
                          )),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            children: [
                              Icon(Icons.link),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "View linked contacts",
                                style: Theme.of(context).textTheme.titleMedium,
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 105),
                child: Text("Added jun 10,2024"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
