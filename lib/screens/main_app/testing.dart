// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/material.dart';

// int selectedIndex = 0;

// class Testing extends StatelessWidget {
//   const Testing({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[350],
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.menu, color: Colors.black),
//           onPressed: () {},
//         ),
//         title: Image.asset(
//           scale: 10,
//           "images/logo.png",
//           fit: BoxFit.contain,
//         ),
//         centerTitle: true,
//         actions: [
//           Stack(
//             alignment: Alignment.topRight,
//             children: [
//               IconButton(
//                 icon: Icon(Icons.notifications_none, color: Colors.black),
//                 onPressed: () {},
//               ),
//               Positioned(
//                 right: 10,
//                 top: 10,
//                 child: Container(
//                   padding: EdgeInsets.all(2),
//                   decoration: BoxDecoration(
//                     color: Colors.red,
//                     shape: BoxShape.circle,
//                   ),
//                   constraints: BoxConstraints(minWidth: 14, minHeight: 14),
//                   child: Center(
//                     child: Text(
//                       "1", // You can make this dynamic
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 10,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//       body: ListView(
//         children: [
//           adsContainer(),
//           SizedBox(
//             height: 30,
//           ),
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.vertical(
//                 top: Radius.circular(20),
//               ),
//             ),
//             padding: EdgeInsets.all(15),
//             child: Column(
//               children: [Text("Category"), CategoryRows(), ProductG()],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// Widget adsContainer() {
//   return Container(
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.vertical(
//         bottom: Radius.circular(40),
//       ),
//     ),
//     width: double.infinity,
//     height: 150,
//     child: Padding(
//       padding: EdgeInsets.all(30),
//       child: Container(
//         child: Padding(
//           padding: EdgeInsets.all(10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("NEW OFFER TEXT"),
//               Text("Discount 50% For The First Transaction ")
//             ],
//           ),
//         ),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             gradient: LinearGradient(
//                 begin: Alignment.bottomCenter,
//                 end: Alignment.topCenter,
//                 stops: [0, 1],
//                 colors: [Colors.grey, Color.fromRGBO(241, 86, 35, 1.0)])),
//       ),
//     ),
//   );
// }

// class CategoryRows extends StatefulWidget {
//   const CategoryRows({super.key});

//   @override
//   State<CategoryRows> createState() => _CategoryRowsState();
// }

// class _CategoryRowsState extends State<CategoryRows> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: 7,
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () {
//               selectedIndex = index;
//               print(selectedIndex);
//               setState(() {});
//             },
//             child: Padding(
//               padding: EdgeInsets.all(8),
//               child: Container(
//                 width: 100,
//                 height: 50,
//                 decoration: BoxDecoration(
//                     color: selectedIndex == index
//                         ? Colors.black
//                         : Colors.grey[350],
//                     borderRadius: BorderRadius.circular(20)),
//                 child: Center(
//                   child: Text(
//                     "DATA$index",
//                     style: TextStyle(
//                       color:
//                           selectedIndex == index ? Colors.white : Colors.black,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//     ;
//   }
// }

// Widget ProductG() {
//   return GridView.builder(
//     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2, crossAxisSpacing: 20),
//     itemCount: 8,
//     physics: NeverScrollableScrollPhysics(),
//     shrinkWrap: true,
//     itemBuilder: (context, index) {
//       return Stack(
//         fit: StackFit.expand,
//         children: [
//           Card(
//             child: Column(children: [
//               Image.asset(
//                 'images/gloves.png',
//                 fit: BoxFit.cover,
//                 width: 100,
//                 height: 100,
//               ),
//               Text("Gloves"),
//               Text("200 EGP"),
//             ]),
//           ),
//           Visibility(
//             visible: true,
//             child: Positioned(
//               width: 100,
//               bottom: -30,
//               right: -10,
//               child: Image.asset(
//                 'images/new.png', // Your NEW badge image
//                 width: 100,
//               ),
//             ),
//           )
//         ],
//       );
//     },
//   );
// }

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:rev_rider/constants/colors.dart';
import 'package:rev_rider/widgets/quantity_selector.dart';

class Testing extends StatelessWidget {
  const Testing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("images/helmet.png"),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      textAlign: TextAlign.start,
                      "Ghost Helmet,Blue",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        style: TextStyle(fontSize: 20),
                        "200 EGP",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                        "blending the classic Bandit styling with modern features. This full-face helmet is DOT/ECE certified, featuring a lightweight shell made of proprietary composite materials."),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: QuantitySelector(
                        onPlusTap: () {}, quantity: 0, onMinusTap: () {}),
                  ),
                  MaterialButton(
                    color: PrimaryOrangeColor,
                    onPressed: () {},
                    child: Text(
                      "ADD TO CART",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
