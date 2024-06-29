import 'package:flutter/material.dart';
import 'package:untitled2/MyNoteApp/database/licensePlateDB.dart';
import 'package:untitled2/MyNoteApp/model/licensePlate.dart';

class ListLicensePlate extends StatelessWidget {
  const ListLicensePlate({super.key});

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)?.settings.arguments as String;
    int Province_ID = int.parse(data);

    return MainPage(Province_ID: Province_ID);
  }
}

class MainPage extends StatefulWidget {
  final int Province_ID;
  const MainPage({required this.Province_ID});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Map<String, dynamic>> licensePlates = [];

  @override
  void initState() {
    super.initState();
    _refreshItems();
  }

  Future<void> _refreshItems() async {
    final listLicensePlateList =
        await LicensePlateDB.getLicensePlates(widget.Province_ID);
    setState(() {
      licensePlates = listLicensePlateList;
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
              title: const Text('List License Plate',
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
            ...licensePlates.map(
              (license) => Card(
                color: Colors.grey,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Name License Plate: ${license['name']}',
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              addOrUpdateName(
                                  license['LicensePlate_ID'], license['name']);
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
                                    title:
                                        const Text('Delete License Plate !!!'),
                                    content: const Text(
                                        "Do you want to delete License Plate ?"),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          _deleteCity(
                                              license['LicensePlate_ID']);
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
    await LicensePlateDB.insertLicensePlate(LicensePlate(
      Province_ID: id,
      name: nameController.text,
    ));

    _refreshItems();
  }

  Future<void> _deleteCity(int id) async {
    await LicensePlateDB.deleteLicensePlate(id);
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
    await LicensePlateDB.updateLicensePlate(LicensePlate(
      name: nameController.text,
      licensePlate_ID: id,
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
                    id == null ? 'Add License Plate' : 'Update License Plate',
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
                      for (int i = 0; i < licensePlates.length; i++) {
                        if (licensePlates[i]['name'] ==
                            nameController.text.trim()) {
                          nameController.text = '';
                        }
                      }
                      if (id == null) {
                        if (nameController.text != '') {
                          _addCity(widget.Province_ID);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                              'Add name License Plate successfully !!!',
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
                              'Add name License Plate unsuccessfully !!!',
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
                              'Update name License Plate successfully !!!',
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
                              'Update name License Plate unsuccessfully !!!',
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
                      child: Text(id == null
                          ? 'Add License Plate'
                          : 'Update License Plate'),
                    ),
                  ),
                ],
              ),
            ));
  }
}
