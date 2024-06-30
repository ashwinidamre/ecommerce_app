import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hidden/home/cart/cart.dart';
// import 'package:hidden/cart.dart';
import 'package:hidden/menu/profile.dart';
import 'package:hidden/menu/trackyourorder.dart';
import 'package:http/http.dart' as http;
import 'package:search_page/search_page.dart';

import '../product/productpage.dart';

class Home_page extends StatefulWidget {
  const Home_page({super.key});

  @override
  State<Home_page> createState() => _Home_pageState();
}

class CartData {
  final int totalProduct;

  CartData({required this.totalProduct});

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(totalProduct: json['total_product']);
  }
}

class _Home_pageState extends State<Home_page> {
  final CarouselController _controller = CarouselController();

  List<String> imageUrls = [];
  List<String> productNames = [];
  List<dynamic> responseData = [];
  List<String> imageUrls1 = [];
  List<String> imageUrls2 = [];
  // List<String> catNames = [];
  List<dynamic> responseData1 = [];
  List<dynamic> responseData2 = [];

  // List<double> productPrices = [];

  @override
  void initState() {
    super.initState();
    fetchImages('');
    fetchImages1('');
    fetchImages2(''); // Fetch images when the widget initializes
  }

  Future<void> fetchImages(String productId) async {
    final apiUrl =
        "http://192.168.52.76/projects/api_shoppingapp/product_details.php?id=$productId";

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        responseData = json.decode(response.body);

        setState(() {
          imageUrls = responseData
              .map<String>((data) =>
                  "http://192.168.52.76/projects/api_shoppingapp/assets/home/${data['product_img']}")
              .toList();

          productNames = responseData
              .map<String>((data) => data['product_name'].toString())
              .toList();
        });
      } else {
        throw Exception('Failed to fetch images');
      }
    } catch (e) {
      print('Error fetching images: $e');
    }
  }

  Future<void> fetchImages1(String productId) async {
    final apiUrl1 =
        "http://192.168.52.76/projects/api_shoppingapp/product_details1.php?id=$productId";

    try {
      final response1 = await http.get(Uri.parse(apiUrl1));
      if (response1.statusCode == 200) {
        responseData1 = json.decode(response1.body);

        setState(() {
          imageUrls1 = responseData1
              .map<String>((data1) =>
                  "http://192.168.52.76/projects/api_shoppingapp/assets/${data1['product_img']}")
              .toList();

          // productNames = responseData1
          //     .map<String>((data1) => data1['product_name'].toString())
          //     .toList();
        });
      } else {
        throw Exception('Failed to fetch images');
      }
    } catch (e) {
      print('Error fetching images: $e');
    }
  }

  Future<void> fetchImages2(String productId) async {
    final apiUrl1 =
        "http://192.168.52.76/projects/api_shoppingapp/home_category.php?id=$productId";

    try {
      final response2 = await http.get(Uri.parse(apiUrl1));
      if (response2.statusCode == 200) {
        responseData2 = json.decode(response2.body);

        setState(() {
          imageUrls2 = responseData2
              .map<String>((data2) =>
                  "http://192.168.52.76/projects/api_shoppingapp/assets/${data2['cat_img']}")
              .toList();

          // productNames = responseData2
          //     .map<String>((data2) => data2['cat_name'].toString())
          //     .toList();
        });
      } else {
        throw Exception('Failed to fetch images');
      }
    } catch (e) {
      print('Error fetching images: $e');
    }
  }

  Future<CartData> fetchCartData() async {
    const apiUrl = "http://localhost/shopping_app.php";

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        if (responseData is Map<String, dynamic>) {
          return CartData.fromJson(responseData);
        } else {
          throw Exception('Unexpected response format: $responseData');
        }
      } else {
        throw Exception('Failed to fetch cart data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching cart data: $e');
      return CartData(totalProduct: 0); // Return default value in case of error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 206, 214, 217),
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
              child: GestureDetector(
                onTap: () {
                  // Navigate to the profile page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Your_Profile()),
                  );
                },
                child: Card(
                  color: Colors.blue[50],
                  child: const ListTile(
                    leading: Icon(Icons.person_3_outlined),
                    title: Text(
                      "My Profile",
                      style: TextStyle(),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: GestureDetector(
                onTap: () {
                  // Navigate to the profile page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Track_Order()),
                  );
                },
                child: Card(
                  color: Colors.blue[50],
                  child: const ListTile(
                    leading: Icon(Icons.person_3_outlined),
                    title: Text(
                      "Track your order",
                      style: TextStyle(),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 18,
                    ),
                  ),
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
          FutureBuilder<CartData>(
            future: fetchCartData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  print(
                      '\x1B[31mError: ${snapshot.error}\x1B[0m'); // Print error message in red color
                  // Return an empty container or null if there's an error
                  return const SizedBox.shrink(); // or return null;
                } else {
                  // Cart data fetched successfully
                  CartData? cartData = snapshot.data;
                  int itemCount = cartData?.totalProduct ?? 0;

                  // Print the total quantity in red color
                  print('\x1B[31mTotal Quantity: $itemCount\x1B[0m');
                  if (snapshot.hasError) {
                    print('Error fetching cart data: ${snapshot.error}');
                    return const SizedBox
                        .shrink(); // Return an empty container or null if there's an error
                  }

                  return Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: GestureDetector(
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/logo/cart.png',
                            width: 30,
                            color: Colors.white,
                          ),
                          if (itemCount > 0)
                            Positioned(
                              right: 0,
                              child: CircleAvatar(
                                backgroundColor: Colors.red,
                                radius: 9,
                                child: Text(
                                  itemCount.toString(),
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      onTap: () {
                        // Navigate to Cart page and pass necessary data
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Cart(
                              cartItems: [], // Pass your cart items list here
                              productImageUrl: "", // Pass product image URL
                              productName: "", // Pass product name
                              productId: "", // Pass product ID
                              productSize: "", // Pass product size
                              productPrice: 0.0, // Pass product price
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              }
              // Show a loading indicator while waiting for the data
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          //height: double.infinity,
          color: Colors.lightBlue[100],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 135,
                    color: Colors.lightBlue[300],
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.blue[600],
                                      radius: 43,
                                      // backgroundImage: imageUrls2.isNotEmpty
                                      //     ? NetworkImage(imageUrls2[1])
                                      //     : null,
                                      backgroundImage: const AssetImage(
                                          'assets/category/saari.jpg'),
                                    ),
                                    Text(
                                      'Saari',
                                      style: TextStyle(
                                          color: Colors.blue[900],
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.blue[600],
                                      radius: 43,
                                      // backgroundImage: imageUrls1.isNotEmpty
                                      //     ? NetworkImage(imageUrls1[1])
                                      //     : null,
                                      backgroundImage: const AssetImage(
                                          'assets/category/jacket.jpg'),
                                    ),
                                    Text(
                                      'Jacket',
                                      style: TextStyle(
                                          color: Colors.blue[900],
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.blue[600],
                                      radius: 43,
                                      // backgroundImage: imageUrls1.isNotEmpty
                                      //     ? NetworkImage(imageUrls1[2])
                                      //     : null,
                                      backgroundImage: const AssetImage(
                                          'assets/category/jeans.jpg'),
                                    ),
                                    Text(
                                      'Jeans',
                                      style: TextStyle(
                                          color: Colors.blue[900],
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.blue[600],
                                      radius:
                                          43, // backgroundImage: imageUrls1.isNotEmpty
                                      //     ? NetworkImage(imageUrls1[3])
                                      //     : null,
                                      backgroundImage: const AssetImage(
                                          'assets/category/shirt.jpg'),
                                    ),
                                    Text(
                                      'Shirt',
                                      style: TextStyle(
                                          color: Colors.blue[900],
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.blue[600],
                                      radius: 43,
                                      child: const CircleAvatar(
                                        backgroundColor: Colors.lightBlueAccent,
                                        radius: 40,
                                        child: Text('Others'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 400,
                height: 50,
                color: const Color.fromRGBO(0, 0, 0, 0),
                child: Column(
                  children: [
                    SizedBox(
                      width: 300,
                      height: 50,
                      child: FloatingActionButton(
                        onPressed: () => showSearch(
                          context: context,
                          delegate: SearchPage(
                            onQueryUpdate: print,
                            items: imageUrls,
                            searchLabel: 'Search products',
                            suggestion: const Center(
                              child:
                                  Text('Filter products by name or category'),
                            ),
                            failure: const Center(
                              child: Text('No product found :('),
                            ),
                            filter: (imageUrl) => [imageUrl],
                            builder: (imageUrl) => ListTile(
                              title: Text(imageUrl),
                              // Implement the desired UI for the search results here
                            ),
                          ),
                        ),
                        child: const Icon(Icons.search),
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                color: Colors.transparent,
                child: const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    "Products Offer",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                        color: Colors.white60),
                  ),
                ),
              ),
              // CarouselSlider(
              //   options: CarouselOptions(
              //     height: 180,
              //     autoPlay: true, // Enable automatic image change
              //     autoPlayInterval:
              //         Duration(seconds: 3), // Set the duration for each image
              //   ),
              //   items: imageUrls1.map((imageUrl1) {
              //     return Builder(
              //       builder: (BuildContext context) {
              //         return Container(
              //           width: MediaQuery.of(context).size.width,
              //           margin: const EdgeInsets.symmetric(horizontal: 6.0),
              //           decoration: BoxDecoration(
              //             color: Colors.lightBlue[100],
              //             borderRadius: BorderRadius.circular(10),
              //           ),
              //           child: imageUrl1.isNotEmpty
              //               ? SizedBox(
              //                   width: 180,
              //                   height: 500,
              //                   child: Image.network(
              //                     imageUrl1,
              //                     // You can adjust the fit here
              //                   ),
              //                 )
              //               : Container(),
              //         );
              //       },
              //     );
              //   }).toList(),
              // ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 180,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                ),
                items: imageUrls1.map((imageUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 6.0),
                        decoration: BoxDecoration(
                          color: Colors.lightBlue[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: imageUrl.isNotEmpty
                            ? Image.network(
                                imageUrl,
                                fit:
                                    BoxFit.cover, // Adjust the fit of the image
                              )
                            : Container(),
                      );
                    },
                  );
                }).toList(),
              ),

              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    color: Colors.lightBlue[200],
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        "Popular Fasion",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                            color: Colors.white60),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    color: Colors.lightBlue[200],
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          for (int b = 0;
                              b < imageUrls.length && b < 2;
                              b++) ...{
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Container(
                                width: 160,
                                height: 350,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.lightBlue[300],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 180,
                                          height: 220,
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight:
                                                      Radius.circular(10)),
                                              color: Colors.green),
                                          child: Image.network(
                                            imageUrls.isNotEmpty
                                                ? imageUrls[b]
                                                : "",
                                            width:
                                                180, // set the width of the image
                                            height:
                                                220, // set the height of the image
                                            fit: BoxFit
                                                .cover, // adjust this according to your needs
                                          ), // Fetch image URL from the list
                                        ),
                                        Container(
                                          width: 170,
                                          height: 110,
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10)),
                                              color: Colors.white),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(productNames.isNotEmpty
                                                  ? productNames[b]
                                                  : ""), // Fetch product name from the list
                                              const Text(
                                                  '400'), // You need to replace this with actual data
                                              // Text(productPrices.isNotEmpty
                                              //     ? productPrices[b].toString()
                                              //     : ""), // Fetch product price from the list
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    onTap: () {
                                      if (responseData.isNotEmpty &&
                                          b < responseData.length) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ProductPage(
                                              productId: responseData[b]
                                                  ['product_id'],
                                              productPrice:
                                                  0.0, // Add the product price here if available
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          }
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    color: Colors.lightBlue[200],
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          for (int b = 2;
                              b < imageUrls.length && b < 4;
                              b++) ...{
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Container(
                                width: 160,
                                height: 350,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.lightBlue[300],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 170,
                                          height: 220,
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight:
                                                      Radius.circular(10)),
                                              color: Colors.green),
                                          child: Image.network(
                                            imageUrls.isNotEmpty
                                                ? imageUrls[b]
                                                : "",
                                            width:
                                                180, // set the width of the image
                                            height:
                                                220, // set the height of the image
                                            fit: BoxFit
                                                .cover, // adjust this according to your needs
                                          ), // Fetch image URL from the list
                                        ),
                                        Container(
                                          width: 170,
                                          height: 110,
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10)),
                                              color: Colors.white),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(productNames.isNotEmpty
                                                  ? productNames[b]
                                                  : ""), // Fetch product name from the list
                                              const Text(
                                                  '300'), // You need to replace this with actual data
                                              // Text(productPrices.isNotEmpty
                                              //     ? productPrices[b].toString()
                                              //     : ""), // Fetch product price from the list
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    onTap: () {
                                      if (responseData.isNotEmpty &&
                                          b < responseData.length) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ProductPage(
                                              productId: responseData[b]
                                                  ['product_id'],
                                              productPrice:
                                                  0.0, // Add the product price here if available
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          }
                        ],
                      ),
                    ),
                  ),
                  // Container(
                  //   width: 400,
                  //   height: 250,
                  //   color: Colors.amber,
                  // )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Shopping App'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 20),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Text(
//                 'Products Offer',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             CarouselSlider(
//               options: CarouselOptions(height: 180),
//               items: imageUrls.map((imageUrl) {
//                 return Builder(
//                   builder: (BuildContext context) {
//                     return Container(
//                       width: MediaQuery.of(context).size.width,
//                       margin: const EdgeInsets.symmetric(horizontal: 5),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: imageUrl.isNotEmpty
//                           ? Image.network(
//                               imageUrl,
//                               fit: BoxFit.cover,
//                             )
//                           : Container(),
//                     );
//                   },
//                 );
//               }).toList(),
//             ),
//             const SizedBox(height: 20),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Text(
//                 'Popular Fashion',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: [
//                   for (int i = 0; i < imageUrls.length; i++)
//                     GestureDetector(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           children: [
//                             CircleAvatar(
//                               backgroundColor: Colors.amber,
//                               radius: 40,
//                               backgroundImage: NetworkImage(imageUrls[i]),
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               productNames.length > i
//                                   ? productNames[i]
//                                   : 'Product ${i + 1}',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       onTap: () {
//                         if (responseData.isNotEmpty &&
//                             i < responseData.length) {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => ProductPage(
//                                 productId: responseData[i]['product_id'],
//                               ),
//                             ),
//                           );
//                         }
//                       },
//                     ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
