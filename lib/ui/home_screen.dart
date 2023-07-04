// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cleanup/ui/photo_upload.dart';
import 'package:cleanup/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool status = false;
  bool task = false;
  List<Apidata> postList = [];

  Future<List<Apidata>> getPostApi() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        postList.add(Apidata.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: Container(
              height: 100,
              decoration: BoxDecoration(color: Colors.black),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Row(
                    children: [
                      Text(
                        'Tasks',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.exit_to_app,
                            color: Colors.white,
                            size: 30,
                          ))
                    ],
                  ),
                ),
              ),
            )),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Expanded(
                    child: FutureBuilder(
                  future: getPostApi(),
                  builder: (context, AsyncSnapshot<List<Apidata>> snapshot) {
                    return ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Card(
                              elevation: 7,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              shadowColor: Colors.black,
                              child: Container(
                                margin: EdgeInsets.all(10),
                                height: 130,
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Expanded(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Text(
                                            snapshot.data![index].title
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 6),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.location_on),
                                          Expanded(
                                              child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Text(
                                                      'Bhadson Road, outside Thapar University, Patiala ')))
                                        ],
                                      ),
                                    ),
                                    Spacer(
                                      flex: 2,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PhotoUploadScreen()));
                                                },
                                                child: Container(
                                                  //margin: EdgeInsets.all(10),
                                                  height: 50,

                                                  decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  child: Center(
                                                      child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.camera_alt,
                                                        color: Colors.white,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                6, 0, 0, 0),
                                                        child: Text(
                                                          'Upload Image',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                                )),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    task = !task;
                                                  });
                                                },
                                                child: Container(
                                                  //margin: EdgeInsets.all(10),
                                                  height: 50,

                                                  decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  child: Center(
                                                      child: task
                                                          ? Icon(
                                                              Icons.done,
                                                              color:
                                                                  Colors.white,
                                                            )
                                                          : Text(
                                                              'Mark As Completed',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            )),
                                                )),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                ))
              ],
            )),
      ),
    ));
  }
}
