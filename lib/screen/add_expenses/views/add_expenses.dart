import 'package:expenses_tracker/setting/setting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class AddExpenses extends StatefulWidget {
  const AddExpenses({super.key});

  @override
  State<AddExpenses> createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses> {
  TextEditingController expensesController = TextEditingController();
  TextEditingController catogryController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  DateTime selecteddate = DateTime.now();

  List<Map<String, dynamic>> categorylist = [
    {"icons": FaIcon(FontAwesomeIcons.burger, color: Colors.black)},
    {"icons": FaIcon(FontAwesomeIcons.shippingFast, color: Colors.black)},
    {"icons": FaIcon(FontAwesomeIcons.houseMedical, color: Colors.black)},
    {"icons": FaIcon(FontAwesomeIcons.speakap, color: Colors.black)},
    {"icons": FaIcon(FontAwesomeIcons.plane, color: Colors.black)},
    {"icons": FaIcon(FontAwesomeIcons.heartCircleBolt, color: Colors.black)},
  ];

  int? selectedIconIndex;

  @override
  void initState() {
    super.initState();
    dateController.text = DateFormat(
      "dd/MM//yyyy",
    ).format(DateTime.now()); // call the dataController
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text("flutter"),
                accountEmail: Text("flutter@gmailc.com"),
                currentAccountPictureSize: Size(60, 60),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Text("circle", style: TextStyle(color: Colors.black)),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Setting()),
                  );
                },
                leading: Icon(Icons.settings, color: Colors.black),
                title: Text("setting"),
              ),
              ListTile(
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('logout from account'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "cancel",
                              style: TextStyle(color: Colors.purple),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Setting(),
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'you logout successfuly',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            },
                            child: Text(
                              "Yes",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                leading: Icon(Icons.logout_outlined, color: Colors.black),
                title: Text("Logout"),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Add Expenses",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 16),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextFormField(
                    controller: expensesController,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(
                        FontAwesomeIcons.dollarSign,
                        size: 16,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: catogryController,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: "Category",
                  suffixIcon: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) {
                          bool isExpended = false; // by default is false
                          Color categorycolor = Colors.white;
                          return StatefulBuilder(
                            builder: (context, setState) {
                              return AlertDialog(
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.background,
                                title: Text("create a category"),
                                content: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintText: "Name",
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      TextFormField(
                                        onTap: () {
                                          setState(() {
                                            isExpended = !isExpended;
                                          });
                                        },
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          suffixIcon: Icon(
                                            CupertinoIcons.chevron_down,
                                            size: 12,
                                          ),
                                          hintText: "icon",
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(12),
                                            ),
                                          ),
                                        ),
                                      ),
                                      isExpended
                                          ? Container(
                                              width: MediaQuery.of(
                                                context,
                                              ).size.width,
                                              height: 200,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                      bottom: Radius.circular(
                                                        12,
                                                      ),
                                                    ),
                                              ),
                                              child: Expanded(
                                                child: GridView.builder(
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 3,
                                                        crossAxisSpacing: 5,
                                                        mainAxisSpacing: 5,
                                                      ),
                                                  itemBuilder: (context, int i) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          // update the index
                                                          selectedIconIndex = i;
                                                        });
                                                      },
                                                      child: Container(
                                                        width: 50,
                                                        height: 50,
                                                        decoration: BoxDecoration(
                                                          border: Border.all(
                                                            width: 2,
                                                            color:
                                                                selectedIconIndex ==
                                                                    i
                                                                ? Colors.green
                                                                : Colors.grey,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                12,
                                                              ),
                                                        ),
                                                        alignment:
                                                            Alignment.center,
                                                        child:
                                                            categorylist[i]["icons"],
                                                      ),
                                                    );
                                                  },
                                                  itemCount:
                                                      categorylist.length,
                                                ),
                                              ),
                                            )
                                          : Container(),
                                      SizedBox(height: 15),
                                      TextFormField(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (ctx2) {
                                              return AlertDialog(
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    ColorPicker(
                                                      pickerColor: Colors.blue,
                                                      onColorChanged: (value) {
                                                        setState(() {
                                                          categorycolor = value;
                                                        }); // update the color
                                                      },
                                                    ),
                                                    SizedBox(
                                                      width: double.infinity,
                                                      height: 50,
                                                      child: ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.black,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  15,
                                                                ),
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.pop(ctx2);
                                                        },
                                                        child: Text(
                                                          "Save",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: categorycolor,
                                          hintText: "Color",
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 50,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.black,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Save",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.add, color: Colors.grey),
                  ),
                  prefixIcon: Icon(FontAwesomeIcons.list, size: 18),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: dateController,
                onTap: () async {
                  DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: selecteddate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 333)),
                  );
                  if (newDate != null) {
                    setState(() {
                      dateController.text = DateFormat(
                        "dd/MM/yyyy",
                      ).format(newDate);
                      selecteddate = newDate; // assign the value
                    });
                  }
                },
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: "Date",
                  prefixIcon: Icon(FontAwesomeIcons.clock, size: 18),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
