import 'package:flutter/material.dart';
import 'package:untitled2/MyNoteApp/database/provinceDB.dart';
import 'package:untitled2/MyNoteApp/screen/showDetailProvince.dart';

import '../animation/transitions.dart';
import '../model/province.dart';


class ShowListProvince extends StatefulWidget {
  const ShowListProvince({super.key});

  @override
  State<ShowListProvince> createState() => _ShowListProvinceState();
}

class _ShowListProvinceState extends State<ShowListProvince> {
  List<Map<String, dynamic>> provinces = [];
  List<Map<String, dynamic>> provincesTemp = [];

  @override
  void initState() {
    super.initState(); // Load data when the app starts
    _refreshItems();
  }

  Future<void> _refreshItems() async {
    final provinceList = await ProvinceDB.getProvinces();
    setState(() {
      provinces = provinceList;
      provincesTemp = provinces;
    });
  }

  Future<void> _deleteProvince(int id) async {
    await ProvinceDB.deleteProvince(id);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Delete province successfully !!!'),
      backgroundColor: Colors.green,
    ));
    _refreshItems();
  }

  final TextEditingController searchController = TextEditingController();
  final TextEditingController _nameProviceController = TextEditingController();

  Future<void> _addProvince() async {
    await ProvinceDB.insertProvince(Pronvince(
      name: _nameProviceController.text,
    ));
    _refreshItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Note',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.white,
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Search by name province ....',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () async {
                          var result =
                              await ProvinceDB.getProvincesOrderby(false);
                          setState(() {
                            provincesTemp = result;
                          });
                        },
                        icon: const Icon(Icons.arrow_upward),
                      ),
                      IconButton(
                        onPressed: () async {
                          var result =
                              await ProvinceDB.getProvincesOrderby(true);
                          setState(() {
                            provincesTemp = result;
                          });
                        },
                        icon: const Icon(Icons.arrow_downward),
                      ),
                    ],
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    provincesTemp = value.isEmpty
                        ? provinces
                        : provinces
                            .where((element) => element['name']
                                .toString()
                                .toLowerCase()
                                .contains(value.toString().toLowerCase()))
                            .toList();
                  });
                },
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'List Province',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: provincesTemp.length,
              itemBuilder: (context, index) => Card(
                color: Colors.black,
                margin: const EdgeInsets.all(15),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: ListTile(
                    leading: Text(
                      '${provincesTemp[index]['Province_ID']}',
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    title: Text(
                      provincesTemp[index]['name'],
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            color: Colors.white,
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                createSlideTransitions(
                                  newPage: const ShowDetailProvince(),
                                  settings: RouteSettings(
                                      arguments:
                                          '${provincesTemp[index]['Province_ID']}'),
                                ),
                              );

                              if (result == true) {
                                _refreshItems();
                                print('1');
                              }
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.white,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Delete province !!!'),
                                    content: const Text(
                                        "Do you want to delete province ?"),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          _deleteProvince(provincesTemp[index]
                                              ['Province_ID']);

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
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colors.grey,
        foregroundColor: Colors.white,
        onPressed: () {
          _showFormAddProvince();
        },
      ),
    );
  }

  void _showFormAddProvince() async {
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
            const Text(
              'Create Province',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: _nameProviceController,
              decoration: const InputDecoration(hintText: 'Name Province'),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_nameProviceController.text != '') {
                  _addProvince();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                      'Create province successfully !!!',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 2),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                      'Create province unsuccessfully !!!',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 2),
                  ));
                }

                _nameProviceController.text = '';
                if (!mounted) return;
                Navigator.of(context).pop();
              },
              child: const Text("Create Province"),
            ),
          ],
        ),
      ),
    );
  }
}
