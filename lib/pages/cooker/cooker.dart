import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class Cooker extends StatefulWidget {
  const Cooker({Key? key}) : super(key: key);

  @override
  State<Cooker> createState() => _CookerState();
}

class _CookerState extends State<Cooker> {
  var food = FirebaseFirestore.instance.collection('food');
  var drink = FirebaseFirestore.instance.collection('drink');
  var dessert = FirebaseFirestore.instance.collection('dessert');
  var fruit = FirebaseFirestore.instance.collection('fruit');
  var greenn = const Color.fromARGB(193, 76, 249, 99);
  var textstyle = GoogleFonts.inter(color: Colors.white);
  var green = GoogleFonts.inter(
      color: const Color.fromARGB(193, 76, 249, 99), fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: const Color.fromARGB(118, 44, 44, 44),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 70),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  'Order List',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    StreamBuilder(
                      stream: food.snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text('Loading', style: textstyle),
                          );
                        }

                        return ExpansionTile(
                          collapsedIconColor: Colors.white,
                          iconColor: greenn,
                          initiallyExpanded: true,
                          leading: const Icon(
                            Icons.food_bank,
                            color: Colors.white,
                          ),
                          backgroundColor: const Color.fromARGB(81, 43, 43, 43),
                          title: Text('Food', style: textstyle),
                          children: snapshot.data!.docs.map((foodstore) {
                            if (!foodstore.exists) {
                              return const ListTile(
                                title: Text('No data'),
                              );
                            }

                            //LIST ICONS
                            return Visibility(
                              visible: foodstore['isSelected'],
                              child: ListTile(
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      foodstore['mainamount'].toString(),
                                      style: textstyle,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        foodstore.reference
                                            .update({'colorchanger': true});
                                      },
                                      icon: const Icon(
                                        Icons.done_outline_sharp,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                                title: Text(
                                  foodstore['name'],
                                  style: foodstore['colorchanger'] == true
                                      ? green
                                      : GoogleFonts.inter(
                                          fontSize: 18, color: Colors.white),
                                ),
                                subtitle: Text(
                                  "${foodstore['price']} so'm",
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: const Color.fromARGB(
                                          119, 255, 255, 255)),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                    //DRINK
                    StreamBuilder(
                      stream: drink.snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text('Loading', style: textstyle),
                          );
                        }

                        return ExpansionTile(
                          collapsedIconColor: Colors.white,
                          iconColor: greenn,
                          initiallyExpanded: true,
                          leading: const Icon(
                            Icons.local_drink,
                            color: Colors.white,
                          ),
                          backgroundColor: const Color.fromARGB(81, 43, 43, 43),
                          title: Text('Drink', style: textstyle),
                          children: snapshot.data!.docs.map((drinkstore) {
                            if (!drinkstore.exists) {
                              return const ListTile(
                                title: Text('No data'),
                              );
                            }
                            //LIST ICONS
                            return Visibility(
                              visible: drinkstore['isSelected'],
                              child: ListTile(
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      drinkstore['mainamount'].toString(),
                                      style: textstyle,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        drinkstore.reference
                                            .update({'colorchanger': true});
                                      },
                                      icon: const Icon(
                                        Icons.done_outline_sharp,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                                title: Text(
                                  drinkstore['name'],
                                  style: drinkstore['colorchanger'] == true
                                      ? green
                                      : GoogleFonts.inter(
                                          fontSize: 18, color: Colors.white),
                                ),
                                subtitle: Text(
                                  "${drinkstore['price']} so'm",
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: const Color.fromARGB(
                                          119, 255, 255, 255)),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                    //DESSERT
                    StreamBuilder(
                      stream: dessert.snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text('Loading', style: textstyle),
                          );
                        }

                        return ExpansionTile(
                          collapsedIconColor: Colors.white,
                          iconColor: greenn,
                          initiallyExpanded: true,
                          leading: const Icon(
                            Icons.cake,
                            color: Colors.white,
                          ),
                          backgroundColor: const Color.fromARGB(81, 43, 43, 43),
                          title: Text('Dessert', style: textstyle),
                          children: snapshot.data!.docs.map((dessertstore) {
                            if (!dessertstore.exists) {
                              return const ListTile(
                                title: Text('No data'),
                              );
                            }
                            //LIST ICONS
                            return Visibility(
                              visible: dessertstore['isSelected'],
                              child: ListTile(
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      dessertstore['mainamount'].toString(),
                                      style: textstyle,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        dessertstore.reference
                                            .update({'colorchanger': true});
                                      },
                                      icon: const Icon(
                                        Icons.done_outline_sharp,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                                title: Text(
                                  dessertstore['name'],
                                  style: dessertstore['colorchanger'] == true
                                      ? green
                                      : GoogleFonts.inter(
                                          fontSize: 18, color: Colors.white),
                                ),
                                subtitle: Text(
                                  "${dessertstore['price']} so'm",
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: const Color.fromARGB(
                                          119, 255, 255, 255)),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                    //FRUIT
                    StreamBuilder(
                      stream: fruit.snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text('Loading', style: textstyle),
                          );
                        }

                        return ExpansionTile(
                          collapsedIconColor: Colors.white,
                          iconColor: greenn,
                          initiallyExpanded: true,
                          leading: const Icon(
                            Icons.apple,
                            color: Colors.white,
                          ),
                          backgroundColor: const Color.fromARGB(81, 43, 43, 43),
                          title: Text('Fruit', style: textstyle),
                          children: snapshot.data!.docs.map((fruitstore) {
                            if (!fruitstore.exists) {
                              return const ListTile(
                                title: Text('No data'),
                              );
                            }
                            //LIST ICONS
                            return Visibility(
                              visible: fruitstore['isSelected'],
                              child: ListTile(
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      fruitstore['mainamount'].toString(),
                                      style: textstyle,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        fruitstore.reference
                                            .update({'colorchanger': true});
                                      },
                                      icon: const Icon(
                                        Icons.done_outline_sharp,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                                title: Text(
                                  fruitstore['name'],
                                  style: fruitstore['colorchanger'] == true
                                      ? green
                                      : GoogleFonts.inter(
                                          fontSize: 18, color: Colors.white),
                                ),
                                subtitle: Text(
                                  "${fruitstore['price']} so'm",
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: const Color.fromARGB(
                                          119, 255, 255, 255)),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
