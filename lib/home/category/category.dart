import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hidden/home/category/cat_widgets/kidswidget.dart';
import 'package:hidden/home/category/cat_widgets/mens.dart';
import 'package:hidden/home/category/cat_widgets/womenswedget.dart';

class category extends StatefulWidget {
  const category({super.key});

  @override
  State<category> createState() => _categoryState();
}

List<Map<String, dynamic>> userdata = []; // Holds product details

Future<void> getProductDetails() async {
  String uri =
      "http://192.168.251.76/projects/api_shoppingapp/product_details.php";
  try {
    var response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      setState(() {
        userdata = List<Map<String, dynamic>>.from(jsonDecode(response.body));
      });
    } else {
      throw Exception('Failed to load product details');
    }
  } catch (e) {
    print(e);
  }
}

void setState(Null Function() param0) {}

class _categoryState extends State<category> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.lightBlue[700],
            leading: const Icon(
              Icons.arrow_back_sharp,
              color: Colors.white,
            ),
            title: const Center(
              child: Padding(
                padding: EdgeInsets.only(right: 50),
                child: Text(
                  'Categroy',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                      color: Colors.white70),
                ),
              ),
            ),
            bottom: TabBar(
              tabs: [
                Tab(
                  child: CircleAvatar(
                    radius: 43,
                    backgroundColor: Colors.lightBlue[800],
                    child: const CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.amber,
                      child: Text(
                        'Man',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: CircleAvatar(
                    radius: 43,
                    backgroundColor: Colors.lightBlue[800],
                    child: const CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.amber,
                      child: Text(
                        'Women',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  // women
                ),
                Tab(
                  child: CircleAvatar(
                    radius: 43,
                    backgroundColor: Colors.lightBlue[800],
                    child: const CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.amber,
                      child: Text(
                        'kids',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  // kids
                )
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              MensWidget(),
              Women_wedget(),
              Kids_widgets(),
            ],
          ),
        ),
      ),
    );
  }
}
