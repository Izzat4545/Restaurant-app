import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderMenu extends StatefulWidget {
  const OrderMenu({Key? key}) : super(key: key);

  @override
  State<OrderMenu> createState() => _OrderMenuState();
}

class _OrderMenuState extends State<OrderMenu> {
  var food = FirebaseFirestore.instance.collection('food');
  var drink = FirebaseFirestore.instance.collection('drink');
  var dessert = FirebaseFirestore.instance.collection('dessert');
  var fruit = FirebaseFirestore.instance.collection('fruit');
  var textstyle = GoogleFonts.inter(color: Colors.white);
  var green = GoogleFonts.inter(
      color: const Color.fromARGB(193, 76, 249, 99), fontSize: 18);
  var greenn = const Color.fromARGB(193, 76, 249, 99);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              StreamBuilder(
                stream: food.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                      .update({'isSelected': false});
                                  foodstore.reference.update({'mainamount': 0});
                                  foodstore.reference
                                      .update({'colorchanger': false});
                                },
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
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
                                color:
                                    const Color.fromARGB(119, 255, 255, 255)),
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
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                      .update({'isSelected': false});
                                  drinkstore.reference
                                      .update({'mainamount': 0});
                                },
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
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
                                color:
                                    const Color.fromARGB(119, 255, 255, 255)),
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
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                      .update({'isSelected': false});
                                  dessertstore.reference
                                      .update({'mainamount': 0});
                                },
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
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
                                color:
                                    const Color.fromARGB(119, 255, 255, 255)),
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
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                      .update({'isSelected': false});
                                  fruitstore.reference
                                      .update({'mainamount': 0});
                                },
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
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
                                color:
                                    const Color.fromARGB(119, 255, 255, 255)),
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
    );
  }
}
