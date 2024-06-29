import 'package:flutter/material.dart';
import 'package:untitled2/MyNoteApp/database/cityDB.dart';
import 'package:untitled2/MyNoteApp/database/licensePlateDB.dart';
import 'package:untitled2/MyNoteApp/database/scenicSpotDB.dart';
import 'package:untitled2/MyNoteApp/database/specialtyDB.dart';
import 'package:untitled2/MyNoteApp/database/universityDB.dart';
import 'package:untitled2/MyNoteApp/screen/listCity.dart';
import 'package:untitled2/MyNoteApp/screen/listLicensePlate.dart';
import 'package:untitled2/MyNoteApp/screen/listScenicSpot.dart';
import 'package:untitled2/MyNoteApp/screen/listSpeciality.dart';
import 'package:untitled2/MyNoteApp/screen/listUniversity.dart';

import '../animation/transitions.dart';
import '../database/provinceDB.dart';
import '../model/province.dart';

class ShowDetailProvince extends StatelessWidget {
  const ShowDetailProvince({super.key});

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)?.settings.arguments as String;
    int Province_ID = int.parse(data);

    return MainPage(Province_ID: Province_ID);
  }
}

class MainPage extends StatefulWidget {
  final int Province_ID;

  MainPage({super.key, required this.Province_ID});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Map<String, dynamic>> provinces = [];
  List<Map<String, dynamic>> province = [];
  List<Map<String, dynamic>> cites = [];
  List<Map<String, dynamic>> licensePlates = [];
  List<Map<String, dynamic>> scenicSpots = [];
  List<Map<String, dynamic>> specialites = [];
  List<Map<String, dynamic>> universities = [];

  @override
  void initState() {
    super.initState();
    _refreshItems();
  }

  Future<void> _refreshItems() async {
    final provincesList = await ProvinceDB.getProvinces();
    final provinceList = await ProvinceDB.getProvince(widget.Province_ID);
    final cityList = await CityDB.getCities(widget.Province_ID);
    final licensePlateList =
        await LicensePlateDB.getLicensePlates(widget.Province_ID);
    final scenicSpotList =
        await ScenicSpotDB.getScenicSpots(widget.Province_ID);
    final specialiteList = await SpecialtyDB.getSpecialties(widget.Province_ID);
    final universityList =
        await UniversityDB.getUniversities(widget.Province_ID);
    setState(() {
      provinces = provincesList;
      province = provinceList;
      cites = cityList;
      licensePlates = licensePlateList;
      scenicSpots = scenicSpotList;
      specialites = specialiteList;
      universities = universityList;
    });
  }

  bool showProvince = false;
  bool showCity = false;
  bool showLicensePlate = false;
  bool showScenicSpot = false;
  bool showSpecialty = false;
  bool showUniversity = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
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
              title: const Text('Information of Province',
                  style: TextStyle(color: Colors.black, fontSize: 20)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (showProvince == false) {
                          showProvince = true;
                        } else {
                          showProvince = false;
                        }
                      });
                    },
                    icon: Icon(
                      showProvince == true
                          ? Icons.arrow_drop_down
                          : Icons.arrow_right,
                      size: 40,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      updateName();
                    },
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ),
            ),
            ...province.map(
              (province) => showProvince
                  ? Column(
                      children: [
                        Card(
                          color: Colors.grey,
                          child: ListTile(
                            title: Text(
                                'ID Province: ${province['Province_ID']}',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20)),
                          ),
                        ),
                        Card(
                          color: Colors.grey,
                          child: ListTile(
                            title: Text('Name City: ${province['name']}',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20)),
                          ),
                        )
                      ],
                    )
                  : const SizedBox(),
            ),
            ListTile(
              title: const Text('List City',
                  style: TextStyle(color: Colors.black, fontSize: 20)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (showCity == false) {
                          showCity = true;
                        } else {
                          showCity = false;
                        }
                      });
                    },
                    icon: Icon(
                      showCity == true
                          ? Icons.arrow_drop_down
                          : Icons.arrow_right,
                      size: 40,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final result2 = await Navigator.push(
                        context,
                        createSlideTransitions(
                          newPage: const ListCity(),
                          settings: RouteSettings(
                              arguments: '${province[0]['Province_ID']}'),
                        ),
                      );
                      if (result2 == true) {
                        _refreshItems();
                      }
                    },
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ),
            ),
            ...cites.map(
              (city) => showCity
                  ? Card(
                      color: Colors.grey,
                      child: Column(
                        children: [
                          ListTile(
                            title: Text('Name City: ${city['name']}',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20)),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
            ),
            ListTile(
              title: const Text('List License Plates',
                  style: TextStyle(color: Colors.black, fontSize: 20)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (showLicensePlate == false) {
                          showLicensePlate = true;
                        } else {
                          showLicensePlate = false;
                        }
                      });
                    },
                    icon: Icon(
                      showLicensePlate == true
                          ? Icons.arrow_drop_down
                          : Icons.arrow_right,
                      size: 40,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final result1 = await Navigator.push(
                        context,
                        createSlideTransitions(
                          newPage: const ListLicensePlate(),
                          settings: RouteSettings(
                              arguments: '${province[0]['Province_ID']}'),
                        ),
                      );

                      if (result1 == true) {
                        _refreshItems();
                        print('1');
                      }
                    },
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ),
            ),
            ...licensePlates.map(
              (licensePlate) => showLicensePlate
                  ? Card(
                      color: Colors.grey,
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                                'Name License Plate: ${licensePlate['name']}',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20)),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
            ),
            ListTile(
              title: const Text('List Scenic Spots',
                  style: TextStyle(color: Colors.black, fontSize: 20)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (showScenicSpot == false) {
                          showScenicSpot = true;
                        } else {
                          showScenicSpot = false;
                        }
                      });
                    },
                    icon: Icon(
                      showScenicSpot == true
                          ? Icons.arrow_drop_down
                          : Icons.arrow_right,
                      size: 40,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        createSlideTransitions(
                          newPage: const ListScenicSpot(),
                          settings: RouteSettings(
                              arguments: '${province[0]['Province_ID']}'),
                        ),
                      );
                      if (result == true) {
                        _refreshItems();
                      }
                    },
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ),
            ),
            ...scenicSpots.map(
              (scenicSpot) => showScenicSpot
                  ? Card(
                      color: Colors.grey,
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                                'Name Scenic Spot: ${scenicSpot['name']}',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20)),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
            ),
            ListTile(
              title: const Text('List Speciality',
                  style: TextStyle(color: Colors.black, fontSize: 20)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (showSpecialty == false) {
                          showSpecialty = true;
                        } else {
                          showSpecialty = false;
                        }
                      });
                    },
                    icon: Icon(
                      showSpecialty == true
                          ? Icons.arrow_drop_down
                          : Icons.arrow_right,
                      size: 40,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        createSlideTransitions(
                          newPage: const ListSpeciality(),
                          settings: RouteSettings(
                              arguments: '${province[0]['Province_ID']}'),
                        ),
                      );
                      if (result == true) {
                        _refreshItems();
                      }
                    },
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ),
            ),
            ...specialites.map(
              (specialty) => showSpecialty
                  ? Card(
                      color: Colors.grey,
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                                'Name Scenic Spot: ${specialty['name']}',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20)),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
            ),
            ListTile(
              title: const Text('List Univeristy',
                  style: TextStyle(color: Colors.black, fontSize: 20)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (showUniversity == false) {
                          showUniversity = true;
                        } else {
                          showUniversity = false;
                        }
                      });
                    },
                    icon: Icon(
                      showUniversity == true
                          ? Icons.arrow_drop_down
                          : Icons.arrow_right,
                      size: 40,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        createSlideTransitions(
                          newPage: const ListUniversity(),
                          settings: RouteSettings(
                              arguments: '${province[0]['Province_ID']}'),
                        ),
                      );
                      if (result == true) {
                        _refreshItems();
                      }
                    },
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ),
            ),
            ...universities.map(
              (university) => showUniversity
                  ? Card(
                      color: Colors.grey,
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                                'Name Scenic Spot: ${university['name']}',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20)),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateProvince(int id) async {
    await ProvinceDB.updateProvince(Pronvince(
      Province_ID: id,
      name: nameController.text,
    ));

    _refreshItems();
  }

  final TextEditingController nameController = TextEditingController();
  void updateName() {
    nameController.text = province[0]['name'];
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
                    'Name Province:',
                    style: TextStyle(fontSize: 25),
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
                      for (int i = 0; i < provinces.length; i++) {
                        if (provinces[i]['name'] ==
                            nameController.text.trim()) {
                          nameController.text = '';
                          break;
                        }
                      }
                      if (nameController.text == '') {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'Update name province unsuccessfully !!!',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                        ));
                      } else {
                        if (nameController.text.trim() != province[0]['name']) {
                          _updateProvince(province[0]['Province_ID']);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                              'Update name province successfully !!!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 2),
                          ));
                        }
                      }
                      if (!mounted) return;
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Update Name Province'),
                    ),
                  ),
                ],
              ),
            ));
  }
}
