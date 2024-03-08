import 'package:coffee_masters/datamanager.dart';
import 'package:coffee_masters/pages/menupage.dart';
import 'package:coffee_masters/pages/offerspage.dart';
import 'package:coffee_masters/pages/orderpage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Masters',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
      ),
      home: const MyHomePage(),
    );
  }
}

// class Greet extends StatefulWidget {
//   const Greet({super.key});

//   @override
//   State<Greet> createState() => _GreetState();
// }

// class _GreetState extends State<Greet> {
//   // State variable
//     var name = "";

//   @override
//   Widget build(BuildContext context) {
//     var greetStyle = TextStyle(fontSize: 24);
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             children: [
//               Text("Hello $name", style: greetStyle),
//               Text("!!!", style: greetStyle),
//             ],
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 20, right: 20),
//           child: TextField(decoration: const InputDecoration(
//               border: OutlineInputBorder(),
//               hintText: 'Enter name',
//             ),
//             onChanged: (value) {
//               setState(() {
//                 name = value;
//               });
//             },
//             ),
//         )
//       ],
//     );
    
//   }
// }


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var dataManager = DataManager();
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget currentWidgetPage = const Text("dfsdfs");

     switch(selectedIndex) {
        case 0:
         currentWidgetPage =  MenuPage(
          dataManager: dataManager,
         );
          break;
        case 1:
          currentWidgetPage = const OffersPage();
          break;
        case 2:
          currentWidgetPage =  OrderPage( 
            dataManager: dataManager,
          );
          break;
        
      }
    return Scaffold(
      appBar: AppBar(        
        title: Image.asset("images/logo.png"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (newIndex) => {
          setState(() {
            selectedIndex = newIndex;
          }),
        
        },
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.yellow.shade400,
        unselectedItemColor: Colors.brown.shade50,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.coffee),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            label: 'Offers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Order',
          ),
        ],
      ),
      body: currentWidgetPage,
    );
  }
}
