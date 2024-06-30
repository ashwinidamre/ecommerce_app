import 'package:flutter/material.dart';

class Home2 extends StatefulWidget {
  const Home2({super.key});

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  List<String> widgetList = ['Geeks', 'for', 'Geeks'];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return Scaffold(
        drawer: Drawer(
          backgroundColor: Colors.lightBlue[200],
          child: Column(
            children: [
              Card(
                elevation: 10,
                child: Container(
                  width: double.infinity,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.lightBlue[600],
                  ),
                  child: const Center(
                    child: Text(
                      'Menu',
                      style: TextStyle(
                          color: Colors.white60,
                          fontSize: 30,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Card(
                  color: Colors.blue[50],
                  child: const ListTile(
                    leading: Icon(Icons.person_3_outlined),
                    title: Text(
                      "My ",
                      style: TextStyle(color: Colors.amber),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 18,
                    ),
                  ),
                ),
              ),
              Card(
                color: Colors.blue[50],
                child: const ListTile(
                  leading: Icon(Icons.padding),
                  title: Text("Your Orders"),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 18,
                  ),
                ),
              ),
              Card(
                color: Colors.blue[50],
                child: const ListTile(
                  leading: Icon(Icons.person_3_outlined),
                  title: Text("Track Your Order"),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 18,
                  ),
                ),
              ),
              Card(
                color: Colors.blue[50],
                child: const ListTile(
                  leading: Icon(Icons.person_3_outlined),
                  title: Text("Seller Account"),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 18,
                  ),
                ),
              ),
              Card(
                color: Colors.blue[50],
                child: const ListTile(
                  leading: Icon(Icons.person_3_outlined),
                  title: Text("Select Language"),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 18,
                  ),
                ),
              ),
              Card(
                color: Colors.blue[50],
                child: const ListTile(
                  leading: Icon(Icons.person_3_outlined),
                  title: Text("Feedback"),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 18,
                  ),
                ),
              ),
              Card(
                color: Colors.blue[50],
                child: const ListTile(
                  leading: Icon(Icons.settings),
                  title: Text("Settings"),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 18,
                  ),
                ),
              )
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.lightBlue[600],
          title: const Center(child: Text('Shopping App')),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Image.asset(
                'assets/logo/cart.png',
                width: 30,
                color: Colors.white,
              ),
            ),

            // BottomAppBar(
            //   child: Text('sdhsdb'),
            // )
          ],
          bottom: AppBar(
            backgroundColor: const Color.fromARGB(255, 3, 229, 86),
            automaticallyImplyLeading: false,
            title: Padding(
              padding: const EdgeInsets.all(27.0),
              child: SizedBox(
                width: 300,
                child: SearchBar(
                  trailing: const [Icon(Icons.mic), Icon(Icons.camera_enhance)],
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/logo/search.png',
                          width: 45,
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          color: Colors.lightBlue[100],
          child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: (itemWidth / itemHeight),
              controller: ScrollController(keepScrollOffset: false),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                for (int i = 0; i < 20; i++) ...{
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: Column(
                      children: [
                        Container(
                          width: 190,
                          height: 350,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.lightBlue[400],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Column(
                              children: [
                                Card(
                                  child: Container(
                                    width: 185,
                                    height: 220,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10)),
                                        color: Colors.green),
                                  ),
                                ),
                                Container(
                                  width: 170,
                                  height: 110,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                }
              ]),
        ));
  }
}
