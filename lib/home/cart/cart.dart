import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hidden/home/paymentpage/paymentpage.dart';
import 'package:http/http.dart' as http;

class Cart extends StatefulWidget {
  final String productId;
  final String productImageUrl;
  final String productName;
  final double productPrice;
  final String productSize;

  const Cart({
    Key? key,
    required this.productImageUrl,
    required this.productName,
    required this.productId,
    required this.productSize,
    required this.productPrice,
    required List cartItems,
  }) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  late List<dynamic> cartItems = [];
  double finalTotal = 0;

  int _quantity = 1;

  void incrementQuantity(int index) {
    setState(() {
      cartItems[index]['qty']++;
      finalTotal = calculateFinalTotal();
    });
  }

  void decrementQuantity(int index) {
    setState(() {
      if (cartItems[index]['qty'] > 1) {
        cartItems[index]['qty']--;
        finalTotal = calculateFinalTotal();
      }
    });
  }

  Future<void> placeOrder() async {
    finalTotal = calculateFinalTotal();

    String orderUrl =
        "http://192.168.251.76/projects/api_shoppingapp/order_details.php";

    Map<String, dynamic> orderData = {
      'final_total': finalTotal.toString(),
    };

    try {
      var response = await http.post(
        Uri.parse(orderUrl),
        body: orderData,
      );

      if (response.statusCode == 200) {
        print("Order placed successfully");
      } else {
        throw Exception('Failed to place order');
      }
    } catch (e) {
      print('Error placing order: $e');
    }
  }

  Future<void> fetchCartDetails() async {
    String apiUrl =
        "http://192.168.251.76/projects/api_shoppingapp/fetch_cart.php";

    try {
      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        setState(() {
          cartItems = jsonDecode(response.body);
          finalTotal = calculateFinalTotal();
        });
      } else {
        throw Exception('Failed to load cart details');
      }
    } catch (e) {
      print('Error fetching cart details: $e');
    }
  }

  double calculateFinalTotal() {
    double total = 0;
    for (var item in cartItems) {
      total += double.parse(item['total'].toString());
    }
    return total;
  }

  // void deleteCartItem(int index) async {
  //   String deleteUrl =
  //       "http://192.168.251.76/projects/api_shoppingapp/delete_cart.php?id=${cartItems[index]['product_id']}";

  //   try {
  //     var response = await http.post(Uri.parse(deleteUrl));
  //     if (response.statusCode == 200) {
  //       setState(() {
  //         cartItems.removeAt(index);
  //         finalTotal = calculateFinalTotal();
  //       });
  //     } else {
  //       throw Exception('Failed to delete cart item');
  //     }
  //   } catch (e) {
  //     print('Error deleting cart item: $e');
  //   }
  // }

  void deleteCartItem(int index) async {
    String deleteUrl =
        "http://192.168.251.76/projects/api_shoppingapp/delete_cart.php?index=$index"; // Pass index as a parameter

    try {
      var response = await http.post(Uri.parse(deleteUrl));
      if (response.statusCode == 200) {
        setState(() {
          cartItems.removeAt(index);
          finalTotal = calculateFinalTotal();
        });
      } else {
        throw Exception('Failed to delete cart item');
      }
    } catch (e) {
      print('Error deleting cart item: $e');
    }
  }

  void goToPaymentPage() {
    placeOrder();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Payment_Page()),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchCartDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Details'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  var item = cartItems[index];
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      child: ListTile(
                        leading: Image.network(
                          "http://192.168.251.76/projects/api_shoppingapp/assets/home/${item['product_img']}",
                        ),
                        title: Text(
                          item['product_name'],
                          style: const TextStyle(
                            color: Color.fromARGB(255, 138, 34, 34),
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Price: ${item['price']}'),
                            Text('Quantity: ${item['qty']}'),
                            Text('Total: ${item['total']}'),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  decrementQuantity(index);
                                });
                              },
                              icon: const Icon(Icons.remove),
                            ),
                            Text('${item['qty']}'),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  incrementQuantity(index);
                                });
                              },
                              icon: const Icon(Icons.add),
                            ),
                            IconButton(
                              onPressed: () {
                                deleteCartItem(index);
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text('Final Total: $finalTotal'),
              ),
              ElevatedButton(
                onPressed: goToPaymentPage,
                child: const Text('Proceed to Payment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Center(
        child: Text('Payment Page'),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Cart(
      productId: '1',
      productImageUrl: 'image_url',
      productName: 'Product 1',
      productPrice: 10.0,
      productSize: 'M',
      cartItems: [],
    ),
  ));
}






//working code
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:hidden/home/paymentpage/paymentpage.dart';
// import 'package:http/http.dart' as http;

// class Cart extends StatefulWidget {
//   final String productId;
//   final String productImageUrl;
//   final String productName;
//   final double productPrice;
//   final String productSize;

//   const Cart({
//     super.key,
//     required this.productImageUrl,
//     required this.productName,
//     required this.productId,
//     required this.productSize,
//     required this.productPrice,
//     required List cartItems,
//   });

//   @override
//   State<Cart> createState() => _CartState();
// }

// class _CartState extends State<Cart> {
//   late List<dynamic> cartItems = [];
//   double finalTotal = 0;
//   // double finalTotal = 0;

//   int _quantity = 1;

//   void incrementQuantity() {
//     setState(() {
//       _quantity++;
//     });
//   }

//   void decrementQuantity() {
//     if (_quantity > 1) {
//       setState(() {
//         _quantity--;
//       });
//     }
//   }

//   // Your existing methods

//   Future<void> placeOrder() async {
//     // Calculate final total
//     finalTotal = calculateFinalTotal();

//     // API URL for inserting order details
//     String orderUrl =
//         "http://192.168.251.76/projects/api_shoppingapp/order_details.php";

//     // Parameters to be sent in the POST request
//     Map<String, dynamic> orderData = {
//       'final_total':
//           finalTotal.toString(), // Use 'final_total' instead of 'finalTotal'
//     };

//     try {
//       // Send POST request to the server
//       var response = await http.post(
//         Uri.parse(orderUrl),
//         body: orderData, // Don't need to jsonEncode here
//       );

//       if (response.statusCode == 200) {
//         // Order placed successfully
//         // You can handle the response here if needed
//         print("Order placed successfully");
//       } else {
//         // Failed to place order
//         throw Exception('Failed to place order');
//       }
//     } catch (e) {
//       print('Error placing order: $e');
//     }
//   }

//   Future<void> fetchCartDetails() async {
//     String apiUrl =
//         "http://192.168.251.76/projects/api_shoppingapp/fetch_cart.php";

//     try {
//       var response = await http.get(Uri.parse(apiUrl));
//       if (response.statusCode == 200) {
//         setState(() {
//           cartItems = jsonDecode(response.body);
//           finalTotal = calculateFinalTotal();
//         });
//       } else {
//         throw Exception('Failed to load cart details');
//       }
//     } catch (e) {
//       print('Error fetching cart details: $e');
//     }
//   }

//   double calculateFinalTotal() {
//     double total = 0;
//     for (var item in cartItems) {
//       total += double.parse(item['total'].toString());
//     }
//     return total;
//   }

//   void deleteCartItem(int index) async {
//     // API call to delete cart item with productId
//     String deleteUrl =
//         "http://192.168.251.76/projects/api_shoppingapp/delete_cart.php?id=${cartItems[index]['product_id']}";

//     try {
//       var response = await http.post(Uri.parse(deleteUrl));
//       if (response.statusCode == 200) {
//         setState(() {
//           cartItems.removeAt(index);
//           finalTotal = calculateFinalTotal();
//         });
//       } else {
//         throw Exception('Failed to delete cart item');
//       }
//     } catch (e) {
//       print('Error deleting cart item: $e');
//     }
//   }

//   void goToPaymentPage() {
//     // Insert the finalTotal into the database
//     placeOrder();

//     // Navigate to the payment page
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const Payment_Page()),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchCartDetails();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Cart Details'),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: cartItems.length,
//                 itemBuilder: (context, index) {
//                   var item = cartItems[index];
//                   return Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Card(
//                       child: ListTile(
//                         leading: Image.network(
//                           "http://192.168.251.76/projects/api_shoppingapp/assets/home/${item['product_img']}",
//                         ),
//                         title: Text(
//                           item['product_name'],
//                           style: const TextStyle(
//                             color: Color.fromARGB(255, 138, 34, 34),
//                             fontWeight: FontWeight.w600,
//                             fontSize: 24,
//                           ),
//                         ),
//                         subtitle: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('Price: ${item['price']}'),
//                             Text('Quantity: ${item['qty']}'),
//                             Text('Total: ${item['total']}'),
//                           ],
//                         ),
//                         trailing: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             IconButton(
//                               onPressed: () {
//                                 // Implement decrement quantity logic
//                               },
//                               icon: const Icon(Icons.remove),
//                             ),
//                             Text(
//                                 '${item['qty']}'), // Update this with actual quantity
//                             IconButton(
//                               onPressed: () {
//                                 // Implement increment quantity logic
//                               },
//                               icon: const Icon(Icons.add),
//                             ),
//                             IconButton(
//                               onPressed: () {
//                                 deleteCartItem(index);
//                               },
//                               icon: const Icon(Icons.delete),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//               const SizedBox(height: 20),
//               Container(
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 child: Text('Final Total: $finalTotal'),
//               ),
//               ElevatedButton(
//                 onPressed: goToPaymentPage,
//                 child: const Text('Proceed to Payment'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // class PaymentPage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Payment'),
// //       ),
// //       body: Center(
// //         child: Text('Payment Page'),
// //       ),
// //     );
// //   }
// // }

// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: Cart(
//       productId: '1',
//       productImageUrl: 'image_url',
//       productName: 'Product 1',
//       productPrice: 10.0,
//       productSize: 'M',
//       cartItems: [],
//     ),
//   ));
// }









//working code
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class Cart extends StatefulWidget {
//   final String productId;
//   final String productImageUrl;
//   final String productName;
//   final double productPrice;
//   final String productSize;

//   const Cart({
//     Key? key,
//     required this.productImageUrl,
//     required this.productName,
//     required this.productId,
//     required this.productSize,
//     required this.productPrice,
//     required List cartItems, // Define cartItems as a required parameter
//   }) : super(key: key);

//   @override
//   State<Cart> createState() => _CartState();
// }

// class _CartState extends State<Cart> {
//   late List<dynamic> cartItems = []; // Define and initialize cartItems

//   int _quantity = 1;
//    double finalTotal = 0;

//   void incrementQuantity() {
//     setState(() {
//       _quantity++;
//     });
//   }

//   void decrementQuantity() {
//     if (_quantity > 1) {
//       setState(() {
//         _quantity--;
//       });
//     }
//   }

//   Future<void> fetchCartDetails() async {
//     String apiUrl =
//         "http://192.168.168.76/projects/api_shoppingapp/fetch_cart.php";

//     try {
//       var response = await http.get(Uri.parse(apiUrl));
//       if (response.statusCode == 200) {
//         setState(() {
//           cartItems = jsonDecode(response.body);
//         });
//       } else {
//         throw Exception('Failed to load cart details');
//       }
//     } catch (e) {
//       print('Error fetching cart details: $e');
//     }
//   }
//    cartItems.forEach((item) {
//     finalTotal += double.parse(item['total'].toString());
//   });

//   @override
//   void initState() {
//     super.initState();
//     fetchCartDetails();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//     appBar: AppBar(
//       title: Text('Cart Details'),
//     ),
//     body: Center(
//       child: Column(
//         children: [
//           ListView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: cartItems.length,
//             itemBuilder: (context, index) {
//               var item = cartItems[index];
//               return Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Card(
//                   child: ListTile(
//                     leading: Image.network(
//                       "http://192.168.168.76/projects/api_shoppingapp/assets/home/${item['product_img']}",
//                     ),
//                     title: Text(
//                       item['product_name'],
//                       style: TextStyle(
//                         color: const Color.fromARGB(255, 138, 34, 34),
//                         fontWeight: FontWeight.w600,
//                         fontSize: 24,
//                       ),
//                     ),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Price: ${item['price']}'),
//                         Text('Quantity: ${item['qty']}'),
//                         Text('Total: ${item['total']}'),
//                       ],
//                     ),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           onPressed: () {
//                             // Implement decrement quantity logic
//                           },
//                           icon: Icon(Icons.remove),
//                         ),
//                         Text('1'), // Update this with actual quantity
//                         IconButton(
//                           onPressed: () {
//                             // Implement increment quantity logic
//                           },
//                           icon: Icon(Icons.add),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//           SizedBox(height: 20),
//           Text('Final Total: $finalTotal'), // Display the final total
//         ],
//       ),
//     ),
//   );
//   }
// }




// class Cart extends StatefulWidget {
//   final List<Map<String, dynamic>> cartItems;
//   final String productId;
//   final String productImageUrl;
//   final String productName;
//   final double productPrice;
//   final String productSize;

//   const Cart({
//     Key? key,
//     required this.cartItems,
//     required this.productImageUrl,
//     required this.productName,
//     required this.productId,
//     required this.productSize,
//     required this.productPrice,
//   }) : super(key: key);

//   @override
//   State<Cart> createState() => _CartState();
// }

// class _CartState extends State<Cart> {
//   late Map<String, dynamic> cartItem = {};

//   @override
//   void initState() {
//     super.initState();
//     fetchCartDetails();
//   }

//   Future<void> fetchCartDetails() async {
//     // Construct the URL without the product ID
//     String apiUrl =
//         "http://192.168.168.76/projects/api_shoppingapp/fetch_cart.php";

//     try {
//       // Make GET request
//       var response = await http.get(Uri.parse(apiUrl));
//       // Check response status code
//       if (response.statusCode == 200) {
//         // Parse response body
//         List<dynamic> cartItemsJson = jsonDecode(response.body);
//         // Update userdata with the fetched list of cart items
//         setState(() {
//           userdata = cartItemsJson.cast<Map<String, dynamic>>();
//         });
//       } else {
//         // Throw exception if request fails
//         throw Exception('Failed to load cart details');
//       }
//     } catch (e) {
//       // Catch and print any errors
//       print('Error fetching cart details: $e');
//     }
//   }

//   String getImageUrl(String productId) {
//     try {
//       if (cartItem['product_img'] != null &&
//           cartItem['product_img'].isNotEmpty) {
//         return "http://192.168.168.76/projects/api_shoppingapp/assets/home/${cartItem['product_img']}";
//       }
//       // If the product image URL is empty or null, return a placeholder URL
//       return "https://via.placeholder.com/150"; // Placeholder URL
//     } catch (e) {
//       print("Error parsing product ID: $e");
//       return "https://via.placeholder.com/150"; // Return placeholder URL on error
//     }
//   }

//   String getProductName(String productId) {
//     try {
//       return cartItem['product_name'] ?? '';
//     } catch (e) {
//       print("Error parsing product name: $e");
//       return ''; // Return empty string on error
//     }
//   }

//   int _quantity = 1;

//   void incrementQuantity() {
//     setState(() {
//       _quantity++;
//     });
//   }

//   void decrementQuantity() {
//     if (_quantity > 1) {
//       setState(() {
//         _quantity--;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cart Details'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text('Product ID: ${widget.productId}'),
//             SizedBox(height: 20),
//             Text('Product Name: ${getProductName(widget.productId)}'),
//             SizedBox(height: 20),
//             Text('Product Price: ${cartItem['price']}'),
//             SizedBox(height: 20),
//             Text('Product Quantity: ${cartItem['qty']}'),
//             SizedBox(height: 20),
//             Text('Total Price: ${cartItem['total']}'),
//           ],
//         ),
//       ),
//     );
//   }
// }



// class Cart extends StatefulWidget {
//   final String productId;
//   final String productImageUrl;
//   final String productName;
//   final double productPrice;
//   final String productSize;

//   const Cart({
//     Key? key,
//     required this.productImageUrl,
//     required this.productName,
//     required this.productId,
//     required this.productSize,
//     required this.productPrice,
//     required List cartItems,
//   }) : super(key: key);

//   @override
//   State<Cart> createState() => _CartState();
// }

// class _CartState extends State<Cart> {
//   int _quantity = 1;

//   void incrementQuantity() {
//     setState(() {
//       _quantity++;
//     });
//   }

//   void decrementQuantity() {
//     if (_quantity > 1) {
//       setState(() {
//         _quantity--;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.lightBlue[700],
//         leading: GestureDetector(
//           child: const Icon(
//             Icons.arrow_back_sharp,
//             color: Colors.white,
//           ),
//           onTap: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: const Center(
//           child: Padding(
//             padding: EdgeInsets.only(right: 60),
//             child: Text(
//               'My Cart',
//               style: TextStyle(
//                 fontWeight: FontWeight.w500,
//                 fontSize: 25,
//                 color: Colors.white70,
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 'Cart Items',
//                 style: TextStyle(
//                   fontSize: 24.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Card(
//                 child: ListTile(
//                   leading: Image.network(widget.productImageUrl),
//                   title: Text(
//                     widget.productName,
//                     style: TextStyle(
//                       color: const Color.fromARGB(255, 138, 34, 34),
//                       fontWeight: FontWeight.w600,
//                       fontSize: 36,
//                     ),
//                   ),
//                   subtitle: Text(widget.productSize),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                         onPressed: decrementQuantity,
//                         icon: Icon(Icons.remove),
//                       ),
//                       Text('$_quantity'),
//                       IconButton(
//                         onPressed: incrementQuantity,
//                         icon: Icon(Icons.add),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Total Price:   ${widget.productPrice * _quantity}',
//                     style: TextStyle(
//                       fontSize: 20.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     'Rs. ',
//                     style: TextStyle(
//                       fontSize: 20.0,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.green,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Implement your proceed to payment logic here
//                 },
//                 child: Text('Proceed to Payment'),
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




// class Cart extends StatefulWidget {
//   final List<Map<String, dynamic>> cartItems;
//   final String productId;
//   final String productImageUrl;
//   final String productName;
//   final double productPrice;
//   final String productSize;

//   const Cart({
//     Key? key,
//     required this.cartItems,
//     required this.productImageUrl,
//     required this.productName,
//     required this.productId,
//     required this.productSize,
//     // required double productPrice,
//     required this.productPrice,
//   }) : super(key: key);

//   @override
//   State<Cart> createState() => _CartState();
// }

// class _CartState extends State<Cart> {
//   late List<Map<String, dynamic>> userdata = [];

//   @override
//   void initState() {
//     super.initState();
//     getProductDetails(widget.productId);
//   }

//   Future<void> getProductDetails(String productId) async {
//     String uri =
//         "http://192.168.168.76/projects/api_shoppingapp/fetch_cart.php?id=$productId";

//     try {
//       var response = await http.get(Uri.parse(uri));
//       if (response.statusCode == 200) {
//         setState(() {
//           userdata = List<Map<String, dynamic>>.from(jsonDecode(response.body));
//         });
//       } else {
//         throw Exception('Failed to load product details');
//       }
//     } catch (e) {
//       print('Error fetching product details: $e');
//     }
//   }

//   String getImageUrl(String productId) {
//     try {
//       for (var userData in userdata) {
//         if (userData['product_id'] == productId) {
//           // Check if the product image URL is not empty or null
//           if (userData['product_img'] != null &&
//               userData['product_img'].isNotEmpty) {
//             return "http://192.168.168.76/projects/api_shoppingapp/assets/home/${userData['product_img']}";
//           }
//         }
//       }
//       // If the product_id is not found or image URL is empty or null, return a placeholder URL
//       return "https://via.placeholder.com/150"; // Placeholder URL
//     } catch (e) {
//       print("Error parsing product ID: $e");
//       return "https://via.placeholder.com/150"; // Return placeholder URL on error
//     }
//   }

//   String getProductName(String productId) {
//     for (var data in userdata) {
//       if (data['product_id'] == productId) {
//         return data['product_name'] ?? '';
//       }
//     }
//     return ''; // Return empty string if product_id is not found
//   }

//   int _quantity = 1;

//   void incrementQuantity() {
//     setState(() {
//       _quantity++;
//     });
//   }

//   void decrementQuantity() {
//     if (_quantity > 1) {
//       setState(() {
//         _quantity--;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var userData;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.lightBlue[700],
//         leading: GestureDetector(
//           child: const Icon(
//             Icons.arrow_back_sharp,
//             color: Colors.white,
//           ),
//           onTap: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: const Center(
//           child: Padding(
//             padding: EdgeInsets.only(right: 60),
//             child: Text(
//               'My Cart',
//               style: TextStyle(
//                 fontWeight: FontWeight.w500,
//                 fontSize: 25,
//                 color: Colors.white70,
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 'Cart Items',
//                 style: TextStyle(
//                   fontSize: 24.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Card(
//                 child: ListTile(
//                   leading: Image.network(
//                     getImageUrl(widget.productId),
//                   ),
//                   title: Text(
//                     getProductName(widget.productId),
//                     style: TextStyle(
//                       color: const Color.fromARGB(255, 138, 34, 34),
//                       fontWeight: FontWeight.w600,
//                       fontSize: 36,
//                     ),
//                   ),
//                   subtitle: Text('Size'),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                         onPressed: decrementQuantity,
//                         icon: Icon(Icons.remove),
//                       ),
//                       Text('$_quantity'),
//                       IconButton(
//                         onPressed: incrementQuantity,
//                         icon: Icon(Icons.add),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Total Price:   200',
//                     style: TextStyle(
//                       fontSize: 20.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     'Rs. ',
//                     style: TextStyle(
//                       fontSize: 20.0,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.green,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Navigator.push(
//                   //   context,
//                   //   MaterialPageRoute(
//                   //     builder: (context) => Payment_Page(
//                   //       // totalPrice: widget.productPrice * _quantity,
//                   //     ),
//                   //   ),
//                   // );
//                 },
//                 child: Text('Proceed to Payment'),
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
