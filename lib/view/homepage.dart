import 'dart:io';
import 'dart:math';

import 'package:alphabet_scroll_view/alphabet_scroll_view.dart';
import 'package:contact_dairy/provider/contact_provider.dart';
import 'package:contact_dairy/provider/stepper_provder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../provider/image_provider.dart';
import '../provider/search_provider.dart';
import '../provider/themeprovider.dart';
import '../provider/updated_provider.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchcontroller = TextEditingController();
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Provider.of<StepperProvider>(context, listen: false)
                .namecontroller
                .clear();
            Provider.of<StepperProvider>(context, listen: false)
                .contactcontroller
                .clear();
            Provider.of<StepperProvider>(context, listen: false)
                .emailcontroller
                .clear();
            Provider.of<StepperProvider>(context, listen: false).step = 0;

            Provider.of<StepperProvider>(context, listen: false).pickImagePath =
                null;

            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return Alertbox();
                });
          },
          child: Icon(Icons.add),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: 40, right: 20, left: 20, bottom: 15),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 40,
                                                  right: 20,
                                                  left: 20,
                                                  bottom: 15),
                                              height: 50,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade300,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 7),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        (Provider.of<
                                                                    SearchProvider>(
                                                                context)
                                                            .searchContacts(
                                                                searchcontroller
                                                                    .text
                                                                    .trim(),
                                                                Provider.of<Contctprovider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .allconatct));
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Icon(Icons.search),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    bottom: 12),
                                                            height: 40,
                                                            width: 165,
                                                            //   color: Colors.blue,
                                                            child: TextField(
                                                                controller:
                                                                    searchcontroller,
                                                                decoration:
                                                                    InputDecoration(
                                                                  contentPadding:
                                                                      EdgeInsets.only(
                                                                          top:
                                                                              25,
                                                                          bottom:
                                                                              3),
                                                                  hintText:
                                                                      " Search Contacts",
                                                                  hintStyle:
                                                                      TextStyle(
                                                                          fontSize:
                                                                              16),
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                )),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        IconButton(
                                                            onPressed: () {
                                                              Provider.of<Themeprovider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .changetheme();
                                                            },
                                                            icon: Icon(Icons
                                                                .more_vert)),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            right: 9,
                                                            top: 4,
                                                            bottom: 4,
                                                          ),
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                                Colors.orange,
                                                            child: Text("D"),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Consumer<SearchProvider>(
                                                  builder: (context,
                                                      searchProvider, child) {
                                                    final searchResults =
                                                        searchProvider
                                                            .searchResults;

                                                    if (searchResults.isEmpty) {
                                                      return Center(
                                                        child: Text(
                                                          'No recent searches',
                                                        ),
                                                      );
                                                    } else {
                                                      return ListView.builder(
                                                        itemCount: searchResults
                                                            .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          final contact =
                                                              searchResults[
                                                                  index];
                                                          return ListTile(
                                                            title: Text(
                                                                contact.name),
                                                            subtitle: Text(
                                                                contact
                                                                    .contact),
                                                            onTap: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pushNamed(
                                                                      'detail_page',
                                                                      arguments:
                                                                          contact);
                                                            },
                                                          );
                                                        },
                                                      );
                                                    }
                                                  },
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.search),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 12),
                                    height: 40,
                                    width: 165,
                                    //   color: Colors.blue,
                                    child: TextField(
                                        decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(top: 25, bottom: 3),
                                      hintText: " Search Contacts",
                                      hintStyle: TextStyle(fontSize: 16),
                                      border: InputBorder.none,
                                    )),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Provider.of<Themeprovider>(context,
                                              listen: false)
                                          .changetheme();
                                    },
                                    icon: Icon(Icons.more_vert)),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: 9,
                                    top: 4,
                                    bottom: 4,
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.orange,
                                    child: Text("D"),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                                child: Row(
                              children: [
                                Icon(
                                  Icons.account_circle_outlined,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text("divyanshiranpariya@.."),
                                SizedBox(
                                  width: 6,
                                ),
                                Icon(Icons.keyboard_arrow_down),
                              ],
                            )),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          IconButton(
                              onPressed: () async {
                                LocalAuthentication auth =
                                    LocalAuthentication();

                                bool isAuth = await auth.authenticate(
                                  localizedReason: 'please..',
                                  options: AuthenticationOptions(),
                                );

                                if (isAuth) {
                                  Navigator.of(context).pushNamed('HidePage');
                                }
                              },
                              icon: Icon(Icons.archive_outlined)),
                          SizedBox(
                            width: 6,
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.short_text_outlined)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: AlphabetScrollView(
                  unselectedTextStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.black),
                  selectedTextStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                  list: Provider.of<Contctprovider>(context)
                      .allconatct
                      .map((e) => AlphaModel(e.name))
                      .toList(),
                  itemExtent: 100,
                  itemBuilder: (context, i, name) {
                    return Container(
                      //color: Colors.red,
                      child: Consumer<Contctprovider>(
                        builder: (context, contactsProvider, _) {
                          return Slidable(
                            startActionPane: ActionPane(
                              motion: DrawerMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (val) {
                                    Provider.of<hide>(context, listen: false)
                                        .addcontacts(
                                            Provider.of<Contctprovider>(context)
                                                .allconatct[i]);
                                    Provider.of<Contctprovider>(context,
                                            listen: false)
                                        .removeconatctfun(
                                            Provider.of<Contctprovider>(context)
                                                .allconatct[i]);
                                  },
                                  icon: Icons.archive_outlined,
                                ),
                              ],
                            ),
                            endActionPane: ActionPane(
                              motion: DrawerMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (val) {
                                    Provider.of<Contctprovider>(context,
                                            listen: false)
                                        .removeconatctfun(
                                            Provider.of<Contctprovider>(context)
                                                .allconatct[i]);
                                  },
                                  icon: CupertinoIcons.delete,
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed('detailPage',
                                    arguments: Provider.of<Contctprovider>(
                                            context,
                                            listen: false)
                                        .allconatct[i]);
                              },
                              child: Card(
                                elevation: 3,
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 20),
                                child: ListTile(
                                  title: Row(
                                    children: [
                                      // (Provider.of<Contctprovider>(context)
                                      //         .allconatct[i]
                                      //         .ima!
                                      //         .path
                                      //         .isEmpty)
                                      //     ? Container(
                                      //         alignment: Alignment.center,
                                      //         height: 40,
                                      //         width: 40,
                                      //         decoration: BoxDecoration(
                                      //             color: getRandomColor(),
                                      //             shape: BoxShape.circle),
                                      //         child: Text(
                                      //             "${Provider.of<Contctprovider>(context).allconatct[i].name[0]}"),
                                      //       )
                                      //     :
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundImage: FileImage(File(
                                            Provider.of<Contctprovider>(context)
                                                .allconatct[i]
                                                .ima!
                                                .path)),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        name,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    onPressed: () async {
                                      await launchUrl(Uri.parse(
                                          "tel:${Provider.of<Contctprovider>(context).allconatct[i].contact}"));
                                    },
                                    icon: Icon(
                                      Icons.phone,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

class Alertbox extends StatelessWidget {
  const Alertbox({super.key});

  @override
  Widget build(BuildContext context) {
    ImagePicker imagePic = ImagePicker();
    XFile? xFile;
    String? pickImagePath;
    GlobalKey info = GlobalKey();
    return Container(
      margin: EdgeInsets.only(top: 35),
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.cancel_outlined)),
                    Text(
                      "Create contact",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
              ],
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    height: 55,
                    color: Colors.grey.shade300,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Row(
                        children: [
                          Text("Save to"),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 35,
                            width: 265,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: DropdownButton(
                                borderRadius: BorderRadius.circular(20),
                                value: "divyanshiranpariya@gmail.com",
                                items: <DropdownMenuItem>[
                                  DropdownMenuItem(
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 4,
                                            bottom: 4,
                                          ),
                                          child: CircleAvatar(
                                            radius: 18,
                                            backgroundColor: Colors.orange,
                                            child: Text("D"),
                                          ),
                                        ),
                                        Text(
                                          "divyanshiranpariya@gmail.com",
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ],
                                    ),
                                    value: "divyanshiranpariya@gmail.com",
                                  )
                                ],
                                onChanged: (val) {}),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Consumer<StepperProvider>(
                    builder: (context, steped, _) {
                      return (steped.pickImagePath == null)
                          ? Container(
                              height: 130,
                              width: 130,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  shape: BoxShape.circle),
                            )
                          : CircleAvatar(
                              radius: 60,
                              backgroundImage: FileImage(steped.pickImagePath!),
                            );
                    },
                  ),
                  TextButton(
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
                                  //     builder: (context, imagespro, _) {
                                  //   return FloatingActionButton(
                                  //     mini: true,
                                  //     elevation: 3,
                                  //     onPressed: () {
                                  //       Provider.of<imageProvider>(context,
                                  //               listen: false)
                                  //           .pickIm();
                                  //       Navigator.of(context).pop();
                                  //     },
                                  //     child: Icon(Icons.camera),
                                  //   );
                                  // }),
                                  // Consumer<imageProvider>(
                                  //     builder: (context, imagespro, _) {
                                  //   return FloatingActionButton(
                                  //     mini: true,
                                  //     elevation: 3,
                                  //     onPressed: () {
                                  //       Provider.of<imageProvider>(context,
                                  //               listen: false)
                                  //           .pickImage();
                                  //     },
                                  //     child:
                                  //         Icon(Icons.browse_gallery_outlined),
                                  //   );
                                  // }),
                                  Consumer<StepperProvider>(
                                      builder: (context, imagespro, _) {
                                    return FloatingActionButton(
                                      mini: true,
                                      elevation: 3,
                                      onPressed: () {
                                        Provider.of<StepperProvider>(context,
                                                listen: false)
                                            .pickImage();
                                        print(imagespro.pickImagePath);
                                      },
                                      child:
                                          Icon(Icons.browse_gallery_outlined),
                                    );
                                  }),
                                  Consumer<StepperProvider>(
                                      builder: (context, imagespro, _) {
                                    return FloatingActionButton(
                                      mini: true,
                                      elevation: 3,
                                      onPressed: () {
                                        Provider.of<StepperProvider>(context,
                                                listen: false)
                                            .pickImagecam();
                                        print(imagespro.pickImagePath);
                                      },
                                      child: Icon(Icons.camera),
                                    );
                                  }),
                                ],
                              );
                            });
                      },
                      child: Text("Add picture")),
                  Container(
                    child: Consumer<StepperProvider>(
                      builder: (context, stepprovide, _) {
                        return Stepper(
                            currentStep: stepprovide.step,
                            controlsBuilder: (context, _) {
                              return Row(
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        stepprovide.forwordstep(context);
                                      },
                                      child: Text((stepprovide.step == 2)
                                          ? "save"
                                          : "next")),
                                  (stepprovide.step == 0)
                                      ? Container()
                                      : OutlinedButton(
                                          onPressed: () {
                                            stepprovide.backwordstep();
                                          },
                                          child: Text("cancle"))
                                ],
                              );
                            },
                            steps: [
                              Step(
                                  title: Text("name"),
                                  content: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: TextField(
                                      controller: stepprovide.namecontroller,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(10),
                                          border: InputBorder.none,
                                          hintText: "Enter your name"),
                                    ),
                                  )),
                              Step(
                                  title: Text("Contact"),
                                  content: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: TextField(
                                      keyboardType: TextInputType.phone,
                                      controller: stepprovide.contactcontroller,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(10),
                                          border: InputBorder.none,
                                          hintText: "Enter your Contact"),
                                    ),
                                  )),
                              Step(
                                  title: Text("Email"),
                                  content: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: TextField(
                                      keyboardType: TextInputType.emailAddress,
                                      controller: stepprovide.emailcontroller,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(10),
                                          border: InputBorder.none,
                                          hintText: "Enter your Email"),
                                    ),
                                  )),
                            ]);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Color getRandomColor() {
  final random = Random();
  return Colors.primaries[random.nextInt(Colors.primaries.length)];
}
