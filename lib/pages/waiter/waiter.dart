import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant/pages/waiter/foodmenu.dart';
import 'package:restaurant/pages/waiter/ordered.dart';

class Waiter extends StatefulWidget {
  const Waiter({Key? key}) : super(key: key);

  @override
  State<Waiter> createState() => _WaiterState();
}

class _WaiterState extends State<Waiter> {
  //FOOD CATEGORY UPDATER
  bool foodform = true;
  bool drinkform = false;
  bool dessrtform = false;
  bool fruitform = false;
  //DESIGN COLOR
  var green = const Color.fromARGB(193, 76, 249, 99);
  //FIREBASE DATA RECEIVERS
  var food = FirebaseFirestore.instance.collection('food');
  var drink = FirebaseFirestore.instance.collection('drink');
  var dessert = FirebaseFirestore.instance.collection('dessert');
  var fruit = FirebaseFirestore.instance.collection('fruit');
  //FOOD CATEGORY CONTROLLERS
  var foodname = TextEditingController();
  var foodprice = TextEditingController();

//PAGE UPDATER
  var pageNum = 0;
  selected(int index) {
    setState(() {
      pageNum = index;
    });
  }

  final _foodkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //WAITER PAGE CONTENTS

    var content = [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 60),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            'Food menu',
            style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
        ),
        const SizedBox(height: 25),
        Center(
          child: Text(
            'Categories',
            style: GoogleFonts.inter(color: Colors.white, fontSize: 25),
          ),
        ),
        const Expanded(child: FoodMenu()),
      ]),
      // ORDER PAGE
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 60),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            'Order menu',
            style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
        ),
        const Expanded(child: OrderMenu())
      ]),
    ];

    return Scaffold(
      backgroundColor: const Color.fromARGB(118, 44, 44, 44),
      body: content.elementAt(pageNum),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          return bottomsheet();
        },
        backgroundColor: green,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageNum,
        onTap: selected,
        backgroundColor: const Color.fromARGB(118, 44, 44, 44),
        selectedItemColor: green,
        unselectedItemColor: const Color.fromARGB(92, 255, 255, 255),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.check_circle), label: 'Ordered')
        ],
      ),
    );
  }

// FOOD ADDER FUNCTION
  void bottomsheet() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          // <-- SEE HERE
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 31, 31, 31),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 15),
                Center(
                  child: Text(
                    'Add Food',
                    style: GoogleFonts.inter(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 15),
                //CETEGORY CHOOSER BOTTONS
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          foodform = true;
                          drinkform = false;
                          dessrtform = false;
                          fruitform = false;
                        });
                      },
                      child: Text(
                        'Food',
                        style: GoogleFonts.inter(
                            color: foodform == true ? green : Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          foodform = false;
                          drinkform = true;
                          dessrtform = false;
                          fruitform = false;
                        });
                      },
                      child: Text(
                        'Drink',
                        style: GoogleFonts.inter(
                            color: drinkform == true ? green : Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          foodform = false;
                          drinkform = false;
                          dessrtform = true;
                          fruitform = false;
                        });
                      },
                      child: Text(
                        'Dessert',
                        style: GoogleFonts.inter(
                            color: dessrtform == true ? green : Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          foodform = false;
                          drinkform = false;
                          dessrtform = false;
                          fruitform = true;
                        });
                      },
                      child: Text(
                        'Fruit',
                        style: GoogleFonts.inter(
                            color: fruitform == true ? green : Colors.white),
                      ),
                    ),
                  ],
                ),

                Visibility(
                  visible: foodform,
                  child: Form(
                    key: _foodkey,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //FOOD NAME INPUT
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please enter name';
                                }
                                return null;
                              },
                              controller: foodname,
                              style: GoogleFonts.inter(color: Colors.white),
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    foodname.clear();
                                  },
                                  icon: const Icon(Icons.clear,
                                      color: Colors.red),
                                ),
                                hintText: 'Food name',
                                hintStyle: GoogleFonts.inter(
                                    color:
                                        const Color.fromARGB(255, 68, 67, 67)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: green),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          //FOOD PRICE INPUT
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please enter price';
                                }
                                return null;
                              },
                              controller: foodprice,
                              style: GoogleFonts.inter(color: Colors.white),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: green),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    foodprice.clear();
                                  },
                                  icon: const Icon(Icons.clear,
                                      color: Colors.red),
                                ),
                                hintText: 'Food price (so\'m)',
                                hintStyle: GoogleFonts.inter(
                                    color:
                                        const Color.fromARGB(255, 68, 67, 67)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            //NEEDS VALIDATION FOR TEXTFORM
                            child: ElevatedButton(
                              onPressed: () {
                                if (_foodkey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Done')),
                                  );
                                }

                                food.add({
                                  'name': foodname.text,
                                  'price': int.parse(foodprice.text),
                                  'isSelected': false,
                                  'amount': 0,
                                  'mainamount': 0,
                                  'colorchanger': false
                                });

                                foodname.clear();
                                foodprice.clear();
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(green),
                              ),
                              child: const Text('Done'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //DRINK FORM
                Visibility(
                  visible: drinkform,
                  child: Form(
                    key: _foodkey,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //DRINK NAME INPUT
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please enter name';
                                }
                                return null;
                              },
                              controller: foodname,
                              style: GoogleFonts.inter(color: Colors.white),
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    foodname.clear();
                                  },
                                  icon: const Icon(Icons.clear,
                                      color: Colors.red),
                                ),
                                hintText: 'Drink name',
                                hintStyle: GoogleFonts.inter(
                                    color:
                                        const Color.fromARGB(255, 68, 67, 67)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: green),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          //DRINK PRICE INPUT
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please enter price';
                                }
                                return null;
                              },
                              controller: foodprice,
                              style: GoogleFonts.inter(color: Colors.white),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: green),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    foodprice.clear();
                                  },
                                  icon: const Icon(Icons.clear,
                                      color: Colors.red),
                                ),
                                hintText: 'Drink price (so\'m)',
                                hintStyle: GoogleFonts.inter(
                                    color:
                                        const Color.fromARGB(255, 68, 67, 67)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            //NEEDS VALIDATION FOR TEXTFORM
                            child: ElevatedButton(
                              onPressed: () {
                                if (_foodkey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Done')),
                                  );
                                }

                                drink.add({
                                  'name': foodname.text,
                                  'price': int.parse(foodprice.text),
                                  'isSelected': false,
                                  'amount': 0,
                                  'mainamount': 0,
                                  'colorchanger': false
                                });

                                foodname.clear();
                                foodprice.clear();
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(green),
                              ),
                              child: const Text('Done'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //DESSRT FORM
                Visibility(
                  visible: dessrtform,
                  child: Form(
                    key: _foodkey,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //DESSRT NAME INPUT
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please enter name';
                                }
                                return null;
                              },
                              controller: foodname,
                              style: GoogleFonts.inter(color: Colors.white),
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    foodname.clear();
                                  },
                                  icon: const Icon(Icons.clear,
                                      color: Colors.red),
                                ),
                                hintText: 'Dessert name',
                                hintStyle: GoogleFonts.inter(
                                    color:
                                        const Color.fromARGB(255, 68, 67, 67)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: green),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          //DESSRT PRICE INPUT
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please enter price';
                                }
                                return null;
                              },
                              controller: foodprice,
                              style: GoogleFonts.inter(color: Colors.white),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: green),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    foodprice.clear();
                                  },
                                  icon: const Icon(Icons.clear,
                                      color: Colors.red),
                                ),
                                hintText: 'Dessert price (so\'m)',
                                hintStyle: GoogleFonts.inter(
                                  color: const Color.fromARGB(255, 68, 67, 67),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            child: ElevatedButton(
                              onPressed: () {
                                //VALIDATION FOR INPUT
                                if (_foodkey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Done')),
                                  );
                                }

                                dessert.add({
                                  'name': foodname.text,
                                  'price': int.parse(foodprice.text),
                                  'isSelected': false,
                                  'amount': 0,
                                  'mainamount': 0,
                                  'colorchanger': false
                                });

                                foodname.clear();
                                foodprice.clear();
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(green),
                              ),
                              child: const Text('Done'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //FRUIT FORM
                Visibility(
                  visible: fruitform,
                  child: Form(
                    key: _foodkey,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //fruit NAME INPUT
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please enter name';
                                }
                                return null;
                              },
                              controller: foodname,
                              style: GoogleFonts.inter(color: Colors.white),
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    foodname.clear();
                                  },
                                  icon: const Icon(Icons.clear,
                                      color: Colors.red),
                                ),
                                hintText: 'Fruit name',
                                hintStyle: GoogleFonts.inter(
                                    color:
                                        const Color.fromARGB(255, 68, 67, 67)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: green),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          //DRINK PRICE INPUT
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please enter price';
                                }
                                return null;
                              },
                              controller: foodprice,
                              style: GoogleFonts.inter(color: Colors.white),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: green),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    foodprice.clear();
                                  },
                                  icon: const Icon(Icons.clear,
                                      color: Colors.red),
                                ),
                                hintText: 'Fruit price (so\'m)',
                                hintStyle: GoogleFonts.inter(
                                    color:
                                        const Color.fromARGB(255, 68, 67, 67)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            //NEEDS VALIDATION FOR TEXTFORM
                            child: ElevatedButton(
                              onPressed: () {
                                if (_foodkey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Done')),
                                  );
                                }

                                fruit.add({
                                  'name': foodname.text,
                                  'price': int.parse(foodprice.text),
                                  'isSelected': false,
                                  'amount': 0,
                                  'mainamount': 0,
                                  'colorchanger': false
                                });

                                foodname.clear();
                                foodprice.clear();
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(green),
                              ),
                              child: const Text('Done'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          });
        });
  }
}
