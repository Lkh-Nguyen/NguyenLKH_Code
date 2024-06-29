import 'package:flutter/material.dart';
import 'package:untitled2/MyNoteApp/animation/transitions.dart';
import 'package:untitled2/MyNoteApp/database/userDB.dart';
import 'package:untitled2/MyNoteApp/model/user.dart';
import 'package:untitled2/MyNoteApp/screen/showListProvince.dart';

class FormLoginRegister extends StatefulWidget {
  const FormLoginRegister({super.key});

  @override
  State<FormLoginRegister> createState() => _FormLoginRegisterState();
}

class _FormLoginRegisterState extends State<FormLoginRegister> {
  num statusForm = 1;
  bool showPassword = true;
  bool showConfirmPassword = true;
  final _formKeyLogin = GlobalKey<FormState>();
  final _formKeyRegister = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode passwordConfirmNode = FocusNode();
  String _gender = 'Male';

  //xử lý database
  //khai báo list
  late List<Map<String, dynamic>> _users = [];

  @override
  void initState() {
    super.initState();
    _refreshItems(); // Load data when the app starts
  }

  Future<void> _refreshItems() async {
    final data = await UserDB.getUsers();
    setState(() {
      _users = data;
    });
  }

  //addStudent
  Future<void> _addCustomer() async {
    await UserDB.insertUser(User(
      email: emailController.text,
      password: passwordController.text,
      gender: _gender,
    ));
    _refreshItems();
  }

  Future<Map<String, dynamic>?> _getUserAndPrint(String email) async {
    final List<Map<String, dynamic>> user = await UserDB.getUser(email);
    if (user.isNotEmpty) {
      return user[0];
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: statusForm == 1
            ? const Text('Form Login')
            : const Text('Form Register'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0, right: 10, left: 10),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                border: Border.all(color: Colors.grey, width: 3.0)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _formKeyRegister.currentState?.reset();
                                if (statusForm == 2) {
                                  statusForm = 1;
                                  emailController.clear();
                                  passwordController.clear();
                                  passwordConfirmController.clear();
                                  _gender = 'Male';
                                }
                              });
                            },
                            child: Text(
                              'Sign In',
                              style: (statusForm == 1)
                                  ? const TextStyle(
                                      fontSize: 20,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold)
                                  : const TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _formKeyLogin.currentState?.reset();
                                if (statusForm == 1) {
                                  statusForm = 2;
                                  emailController.clear();
                                  passwordController.clear();

                                  _gender = 'Male';
                                }
                              });
                            },
                            child: Text(
                              'Sign Up',
                              style: (statusForm == 2)
                                  ? const TextStyle(
                                      fontSize: 20,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold)
                                  : const TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                (statusForm == 1) ? LoginForm() : RegisterForm(),
                // Add more widgets here depending on the value of statusForm
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget LoginForm() {
    return (Form(
      key: _formKeyLogin,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                focusNode: emailFocusNode,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autocorrect: true,
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Email'),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please, enter your email';
                  } else {
                    Pattern pattern =
                        r'^([a-zA-Z0-9_.+-])+@([a-zA-Z0-9-]+\.)+[a-zA-Z0-9]{2,4}$';
                    RegExp regex = RegExp(pattern as String);
                    if (!regex.hasMatch(value)) {
                      return 'Please enter the correct email format';
                    } else {
                      return null;
                    }
                  }
                },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(passwordFocusNode);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                focusNode: passwordFocusNode,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                obscureText: showPassword,
                controller: passwordController,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: const Text('Password'),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          if (showPassword) {
                            showPassword = false;
                          } else {
                            showPassword = true;
                          }
                        });
                      },
                      icon: showPassword
                          ? const Icon(
                              Icons.remove_red_eye_rounded,
                              color: Colors.grey,
                            )
                          : const Icon(
                              Icons.remove_red_eye,
                              color: Colors.black,
                            ),
                    )),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please, enter your password';
                  } else {
                    if (value.length < 8) {
                      return 'Password must be more than 8 characters';
                    } else {
                      return null;
                    }
                  }
                },
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus(); // Dismiss the keyboard
                  if (_formKeyLogin.currentState!.validate()) {
                    final checkUser =
                        await _getUserAndPrint(emailController.text);
                    if (checkUser != null) {
                      if (checkUser['password'] == passwordController.text) {
                        Navigator.push(
                            context,
                            createSlideTransitions(
                              newPage: const ShowListProvince(),
                              settings: const RouteSettings(),
                            ));
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'Login successfully !!!',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 2),
                        ));
                        emailController.text = '';
                        passwordController.text = '';
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'Email or password is wrong !!!',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                        ));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                          'Email is not existed !!!',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 2),
                      ));
                    }
                  } else {}
                },
                child: const Text('Login')),
          ],
        ),
      ),
    ));
  }

  Widget RegisterForm() {
    return (Form(
      key: _formKeyRegister,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                focusNode: emailFocusNode,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autocorrect: true,
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Email'),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please, enter your email';
                  } else {
                    Pattern pattern =
                        r'^([a-zA-Z0-9_.+-])+@([a-zA-Z0-9-]+\.)+[a-zA-Z0-9]{2,4}$';
                    RegExp regex = RegExp(pattern as String);
                    if (!regex.hasMatch(value)) {
                      return 'Please enter the correct email format';
                    } else {
                      return null;
                    }
                  }
                },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(passwordFocusNode);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                focusNode: passwordFocusNode,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                obscureText: showPassword,
                controller: passwordController,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: const Text('Password'),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          if (showPassword) {
                            showPassword = false;
                          } else {
                            showPassword = true;
                          }
                        });
                      },
                      icon: showPassword
                          ? const Icon(
                              Icons.remove_red_eye_rounded,
                              color: Colors.grey,
                            )
                          : const Icon(
                              Icons.remove_red_eye,
                              color: Colors.black,
                            ),
                    )),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please, enter your password';
                  } else {
                    if (value.length < 8) {
                      return 'Password must be more than 8 characters';
                    } else {
                      return null;
                    }
                  }
                },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(passwordConfirmNode);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                focusNode: passwordConfirmNode,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                obscureText: showConfirmPassword,
                controller: passwordConfirmController,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: const Text('Confirm Password'),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          if (showConfirmPassword) {
                            showConfirmPassword = false;
                          } else {
                            showConfirmPassword = true;
                          }
                        });
                      },
                      icon: showConfirmPassword
                          ? const Icon(
                              Icons.remove_red_eye_rounded,
                              color: Colors.grey,
                            )
                          : const Icon(
                              Icons.remove_red_eye,
                              color: Colors.black,
                            ),
                    )),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please, confirm your password';
                  } else {
                    if (value.length < 8) {
                      return 'Password must be more than 8 characters';
                    } else {
                      if (value != passwordController.text) {
                        return 'Password confirm not the same password';
                      } else {
                        return null;
                      }
                    }
                  }
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                      title: const Text('Male'),
                      value: 'Male',
                      groupValue: _gender,
                      onChanged: (value) {
                        setState(() {
                          _gender = 'Male';
                        });
                      }),
                ),
                Expanded(
                  child: RadioListTile(
                      title: Text('Female'),
                      value: 'Female',
                      groupValue: _gender,
                      onChanged: (value) {
                        setState(() {
                          _gender = 'Female';
                        });
                      }),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  if (_formKeyRegister.currentState!.validate()) {
                    //add vào
                    final checkUser =
                        await _getUserAndPrint(emailController.text);
                    print('$checkUser');
                    if (checkUser == null) {
                      _addCustomer();
                      //xóa hết form về lại ban đầu
                      emailController.text = '';
                      passwordController.text = '';
                      passwordConfirmController.text = '';
                      _gender = 'Male';
                      //quay về trang login
                      statusForm = 1;
                      //thông báo ra register thành công
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                          'Register customer success !!!',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 4),
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                          'Email is not existed !!!',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 4),
                      ));
                    }
                  }
                },
                child: Text('Register')),
          ],
        ),
      ),
    ));
  }
}
