import 'package:flutter/material.dart';
import 'package:untitled2/MyNoteApp/model/city.dart';

import '../database/cityDB.dart';

class ListCity extends StatelessWidget {
  const ListCity({super.key});

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)?.settings.arguments as String;
    int Province_ID = int.parse(data);

    return MainPage(Province_ID: Province_ID);
  }
}

class MainPage extends StatefulWidget {
  final int Province_ID;
  const MainPage({super.key, required this.Province_ID});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Map<String, dynamic>> cites = [];

  @override
  void initState() {
    super.initState();
    _refreshItems();
  }

  Future<void> _refreshItems() async {
    final cityList = await CityDB.getCities(widget.Province_ID);
    setState(() {
      cites = cityList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        title: const Text('Information Province',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: const Text('List City',
                  style: TextStyle(color: Colors.black, fontSize: 25)),
              trailing: IconButton(
                icon: const Icon(
                  Icons.add,
                  size: 35,
                ),
                onPressed: () {
                  addOrUpdateName(null, null);
                },
              ),
            ),
            ...cites.map(
              (city) => Card(
                color: Colors.grey,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Name City: ${city['name']}',
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              addOrUpdateName(city['City_ID'], city['name']);
                            },
                            icon: const Icon(Icons.edit, color: Colors.black),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.black,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Delete city !!!'),
                                    content: const Text(
                                        "Do you want to delete city ?"),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          _deleteCity(city['City_ID']);
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Delete'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addCity(int id) async {
    await CityDB.insertCity(City(
      Province_ID: id,
      name: nameController.text,
    ));

    _refreshItems();
  }

  Future<void> _deleteCity(int id) async {
    await CityDB.deleteCity(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        'Delete name city successfully !!!',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 2),
    ));
    _refreshItems();
  }

  Future<void> _updateCity(int id) async {
    await CityDB.updateCity(City(
      name: nameController.text,
      city_ID: id,
      Province_ID: widget.Province_ID,
    ));
    _refreshItems();
  }

  final TextEditingController nameController = TextEditingController();
  void addOrUpdateName(int? id, String? name) {
    if (id == null) {
      nameController.text = '';
    } else {
      nameController.text = name!;
    }
    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                // this will prevent the soft keyboard from covering the text fields
                bottom: MediaQuery.of(context).viewInsets.bottom + 120,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    id == null ? 'Add City' : 'Update City',
                    style: const TextStyle(fontSize: 25),
                  ),
                  TextField(
                    decoration: const InputDecoration(),
                    controller: nameController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      for (int i = 0; i < cites.length; i++) {
                        if (cites[i]['name'] == nameController.text.trim()) {
                          nameController.text = '';
                        }
                      }
                      if (id == null) {
                        if (nameController.text != '') {
                          _addCity(widget.Province_ID);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                              'Add name city successfully !!!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 2),
                          ));
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                              'Add name city unsuccessfully !!!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 2),
                          ));
                        }
                      } else {
                        if (nameController.text != '') {
                          _updateCity(id);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                              'Update name city successfully !!!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 2),
                          ));
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                              'Update name city unsuccessfully !!!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 2),
                          ));
                        }
                      }
                      nameController.text = '';
                      if (!mounted) return;
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(id == null ? 'Add City' : 'Update City'),
                    ),
                  ),
                ],
              ),
            ));
  }
}
