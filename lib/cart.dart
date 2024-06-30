import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final String productImageUrl;
  final String productName;
  final double productPrice;
  final String productSize; // New field to store product size

  const Cart({
    super.key,
    required this.cartItems,
    required this.productImageUrl,
    required this.productName,
    required this.productPrice,
    required this.productSize, // Pass product size as a parameter
  });

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[700],
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_sharp,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(right: 60),
            child: Text(
              'My Cart',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 25,
                color: Colors.white70,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.lightBlue[200],
              child: Column(
                children: widget.cartItems.map((item) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      color: Colors.transparent,
                      child: Container(
                        width: double.infinity,
                        height: 250,
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 150,
                                height: 230,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.amber,
                                ),
                                child: Image.network(widget.productImageUrl),
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 200,
                                  color: Colors.transparent,
                                  child: Column(
                                    children: [
                                      Text(
                                        widget.productName,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(height: 16,),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Row(
                                          children: [
                                            const CircleAvatar(
                                              radius: 25,
                                              child: CircleAvatar(
                                                radius: 23,
                                                backgroundColor: Colors.amber,
                                              ),
                                            ),
                                            const SizedBox(width: 15,),
                                            Container(
                                              width: 70,
                                              height: 40,
                                              color: Colors.black12,
                                              child: Center(
                                                child: Text(
                                                  widget.productSize, // Use product size from parameter
                                                  style: const TextStyle(fontSize: 21),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 47,),
                                Container(
                                  width: 200,
                                  height: 75,
                                  color: Colors.transparent,
                                  child: Row(
                                    children: [
                                      Text(
                                        widget.productPrice.toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      const SizedBox(width: 15,),
                                      const Icon(Icons.add, size: 30,),
                                      const SizedBox(width: 5,),
                                      const Text(
                                        'data',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(width: 5,),
                                      const Icon(Icons.remove, size: 30,),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            // total price and place order
            Container(
              width: 400,
              height: 120,
              color: Colors.lightBlue[600],
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        const Text(
                          'Total Price',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          widget.productPrice.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 27,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 40,),
                  Container(
                    width: 170,
                    height: 65,
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Center(
                      child: Text(
                        'Place Order',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 400,
              height: 450,
              color: Colors.lightBlue[200],
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Row(
                    children: [
                      Card(
                        child: Container(
                          width: 180,
                          height: 430,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.lightBlue[600],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                Container(
                                  width: 170,
                                  height: 200,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5,),
                                Container(
                                  width: 170,
                                  height: 210,
                                  decoration: const BoxDecoration(
                                    color: Colors.brown,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: const Column(
                                    children: [
                                      Text(
                                        'Product ditails',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          width: 180,
                          height: 430,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.lightBlue[600],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                Container(
                                  width: 170,
                                  height: 200,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5,),
                                Container(
                                  width: 170,
                                  height: 210,
                                  decoration: const BoxDecoration(
                                    color: Colors.brown,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: const Column(
                                    children: [
                                      Text(
                                        'Product ditails',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          width: 180,
                          height: 430,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.lightBlue[600],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                Container(
                                  width: 170,
                                  height: 200,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5,),
                                Container(
                                  width: 170,
                                  height: 210,
                                  decoration: const BoxDecoration(
                                    color: Colors.brown,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: const Column(
                                    children: [
                                      Text(
                                        'Product ditails',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
