import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.clear),
          ),
        ),
        title: Text("Create Contact"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
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
                                    Icon(Icons.mail),
                                    SizedBox(
                                      width: 5,
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
              Container(
                margin: EdgeInsets.only(top: 20),
                width: 200,
                height: 170,
                // color: Colors.grey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundImage: NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVhJSUzaThTX-l3c_hiMwpb_MDuMvOWCBS5A&s"
                          //"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScXqYAhGh5M-wAJcf1JPwga7FoC2IYrYkVqc128s8UclTR5cWcwtmiOw6PAg2x5VbJuvA&usqp=CAU"
                          ),
                    ),
                    GestureDetector(
                        onTap: () {
                          print("hello");
                        },
                        child: Text(
                          "Add Image",
                          style: TextStyle(color: Colors.indigo),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Container(
                  height: 600,
                  width: 315,
                  //color: Colors.blue,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Icon(Icons.perm_contact_cal_rounded),
                          ),
                          Expanded(
                            flex: 10,
                            child: Container(
                              height: 50,
                              width: 200,
                              //color: Colors.brown,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Name",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: 255,
                            //color: Colors.brown,
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "Name",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.perm_contact_cal_rounded),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 50,
                            width: 255,
                            //color: Colors.brown,
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "Name",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.perm_contact_cal_rounded),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 50,
                            width: 255,
                            //color: Colors.brown,
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "Name",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.perm_contact_cal_rounded),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 50,
                            width: 255,
                            //color: Colors.brown,
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "Name",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.perm_contact_cal_rounded),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 50,
                            width: 255,
                            //color: Colors.brown,
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "Name",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.perm_contact_cal_rounded),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 50,
                            width: 255,
                            //color: Colors.brown,
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "Name",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
