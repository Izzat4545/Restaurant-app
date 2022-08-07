import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodMenu extends StatefulWidget {
  const FoodMenu({Key? key}) : super(key: key);

  @override
  State<FoodMenu> createState() => _FoodMenuState();
}

class _FoodMenuState extends State<FoodMenu> {
  @override
  Widget build(BuildContext context) {
    var textstyle = GoogleFonts.inter(color: Colors.white);

    var food = FirebaseFirestore.instance.collection('food');
    var drink = FirebaseFirestore.instance.collection('drink');
    var dessert = FirebaseFirestore.instance.collection('dessert');
    var fruit = FirebaseFirestore.instance.collection('fruit');
    var green = const Color.fromARGB(193, 76, 249, 99);

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
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Please check your internet'),
                    );
                  }

                  return ExpansionTile(
                    collapsedIconColor: Colors.white,
                    iconColor: green,
                    leading: const Icon(
                      Icons.food_bank,
                      color: Colors.white,
                    ),
                    backgroundColor: const Color.fromARGB(81, 43, 43, 43),
                    title: Text('Food', style: textstyle),
                    children: snapshot.data!.docs.map((foodstore) {
                      //LIST ICONS
                      return ListTile(
                        onLongPress: () {
                          foodstore.reference.delete();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Done')),
                          );
                        },
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (foodstore['amount'] > 0) {
                                      foodstore.reference.update(
                                        {'amount': FieldValue.increment(-1)},
                                      );
                                    }
                                  });
                                },
                                icon: const Icon(Icons.remove,
                                    color: Colors.white)),
                            Text(
                              foodstore['amount'].toString(),
                              style: textstyle,
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    foodstore.reference.update(
                                      {'amount': FieldValue.increment(1)},
                                    );
                                  });
                                },
                                icon:
                                    const Icon(Icons.add, color: Colors.white)),
                            //MAIN FUNCTION DO NOT TOUCH IT
                            IconButton(
                              onPressed: () {
                                if (foodstore['amount'] > 0) {
                                  foodstore.reference
                                      .update({'isSelected': true});

                                  foodstore.reference
                                      .update({'colorchanger': false});
                                }

                                foodstore.reference.update({
                                  'mainamount':
                                      FieldValue.increment(foodstore['amount']),
                                });

                                foodstore.reference.update({'amount': 0});
                              },
                              icon: const Icon(
                                Icons.add_task_rounded,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        title: Text(
                          foodstore['name'],
                          style: GoogleFonts.inter(
                              fontSize: 18, color: Colors.white),
                        ),
                        subtitle: Text(
                          "${foodstore['price']} so'm",
                          style: GoogleFonts.inter(
                              fontSize: 12,
                              color: const Color.fromARGB(119, 255, 255, 255)),
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
                    iconColor: green,
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
                      return ListTile(
                        onLongPress: () {
                          drinkstore.reference.delete();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Done')),
                          );
                        },
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (drinkstore['amount'] > 0) {
                                      drinkstore.reference.update(
                                        {'amount': FieldValue.increment(-1)},
                                      );
                                    }
                                  });
                                },
                                icon: const Icon(Icons.remove,
                                    color: Colors.white)),
                            Text(
                              drinkstore['amount'].toString(),
                              style: textstyle,
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    drinkstore.reference.update(
                                      {'amount': FieldValue.increment(1)},
                                    );
                                  });
                                },
                                icon:
                                    const Icon(Icons.add, color: Colors.white)),
                            //MAIN FUNCTION DO NOT TOUCH IT
                            IconButton(
                              onPressed: () {
                                if (drinkstore['amount'] > 0) {
                                  drinkstore.reference
                                      .update({'isSelected': true});
                                  drinkstore.reference
                                      .update({'colorchanger': false});
                                }

                                drinkstore.reference.update({
                                  'mainamount':
                                      FieldValue.increment(drinkstore['amount'])
                                });
                                drinkstore.reference.update({'amount': 0});
                              },
                              icon: const Icon(
                                Icons.add_task_rounded,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        title: Text(
                          drinkstore['name'],
                          style: GoogleFonts.inter(
                              fontSize: 18, color: Colors.white),
                        ),
                        subtitle: Text(
                          "${drinkstore['price']} so'm",
                          style: GoogleFonts.inter(
                              fontSize: 12,
                              color: const Color.fromARGB(119, 255, 255, 255)),
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
                    iconColor: green,
                    leading: const Icon(
                      Icons.cake,
                      color: Colors.white,
                    ),
                    backgroundColor: const Color.fromARGB(81, 43, 43, 43),
                    title: Text('Dessert', style: textstyle),
                    children: snapshot.data!.docs.map((dessertstore) {
                      //LIST ICONS
                      return ListTile(
                        onLongPress: () {
                          dessertstore.reference.delete();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Done')),
                          );
                        },
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (dessertstore['amount'] > 0) {
                                      dessertstore.reference.update(
                                        {'amount': FieldValue.increment(-1)},
                                      );
                                    }
                                  });
                                },
                                icon: const Icon(Icons.remove,
                                    color: Colors.white)),
                            Text(
                              dessertstore['amount'].toString(),
                              style: textstyle,
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    dessertstore.reference.update(
                                      {'amount': FieldValue.increment(1)},
                                    );
                                  });
                                },
                                icon:
                                    const Icon(Icons.add, color: Colors.white)),
                            //MAIN FUNCTION DO NOT TOUCH IT
                            IconButton(
                              onPressed: () {
                                if (dessertstore['amount'] > 0) {
                                  dessertstore.reference
                                      .update({'isSelected': true});
                                  dessertstore.reference
                                      .update({'colorchanger': false});
                                }

                                dessertstore.reference.update({
                                  'mainamount': FieldValue.increment(
                                      dessertstore['amount'])
                                });
                                dessertstore.reference.update({'amount': 0});
                              },
                              icon: const Icon(
                                Icons.add_task_rounded,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        title: Text(
                          dessertstore['name'],
                          style: GoogleFonts.inter(
                              fontSize: 18, color: Colors.white),
                        ),
                        subtitle: Text(
                          "${dessertstore['price']} so'm",
                          style: GoogleFonts.inter(
                              fontSize: 12,
                              color: const Color.fromARGB(119, 255, 255, 255)),
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
                    iconColor: green,
                    leading: const Icon(
                      Icons.apple,
                      color: Colors.white,
                    ),
                    backgroundColor: const Color.fromARGB(81, 43, 43, 43),
                    title: Text('Fruit', style: textstyle),
                    children: snapshot.data!.docs.map((fruitstore) {
                      //LIST ICONS
                      return ListTile(
                        onLongPress: () {
                          fruitstore.reference.delete();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Done')),
                          );
                        },
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (fruitstore['amount'] > 0) {
                                      fruitstore.reference.update(
                                        {'amount': FieldValue.increment(-1)},
                                      );
                                    }
                                  });
                                },
                                icon: const Icon(Icons.remove,
                                    color: Colors.white)),
                            Text(
                              fruitstore['amount'].toString(),
                              style: textstyle,
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    fruitstore.reference.update(
                                      {'amount': FieldValue.increment(1)},
                                    );
                                  });
                                },
                                icon:
                                    const Icon(Icons.add, color: Colors.white)),
                            //MAIN FUNCTION DO NOT TOUCH IT
                            IconButton(
                              onPressed: () {
                                if (fruitstore['amount'] > 0) {
                                  fruitstore.reference
                                      .update({'isSelected': true});
                                  fruitstore.reference
                                      .update({'colorchanger': false});
                                }

                                fruitstore.reference.update({
                                  'mainamount':
                                      FieldValue.increment(fruitstore['amount'])
                                });
                                fruitstore.reference.update({'amount': 0});
                              },
                              icon: const Icon(
                                Icons.add_task_rounded,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        title: Text(
                          fruitstore['name'],
                          style: GoogleFonts.inter(
                              fontSize: 18, color: Colors.white),
                        ),
                        subtitle: Text(
                          "${fruitstore['price']} so'm",
                          style: GoogleFonts.inter(
                              fontSize: 12,
                              color: const Color.fromARGB(119, 255, 255, 255)),
                        ),
                      );
                    }).toList(),
                  );
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
