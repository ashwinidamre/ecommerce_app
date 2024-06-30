import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Women_wedget extends StatefulWidget {
  const Women_wedget({super.key});

  @override
  State<Women_wedget> createState() => _Women_wedgetState();
}

class _Women_wedgetState extends State<Women_wedget> {
  List<Map<String, dynamic>> offerData = [
    {"img": "offer.jpg"},
    {"img": "offer1.jpg"},
    {"img": "offer2.jpg"},
    {"img": "offer3.jpg"}
  ];

  List<String> imageUrls = [""]; // List to store image URLs

  @override
  void initState() {
    super.initState();
    fetchImageUrls(); // Fetch image URLs when the widget initializes
  }

  Future<void> fetchImageUrls() async {
    const apiUrl =
        "http://192.168.251.76/projects/api_shoppingapp/category_women.php";

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        setState(() {
          imageUrls = responseData
              .map<String>((data) =>
                  "http://192.168.251.76/projects/api_shoppingapp/assets/womens/${data['cat_img']}")
              .toList();
          offerData = responseData.map<Map<String, dynamic>>((data) {
            return {
              "img":
                  "http://192.168.251.76/projects/api_shoppingapp/assets/womens/${data['cat_img']}",
              "cat_name": data['cat_name'],
              "price": data['price'],
            };
          }).toList();
        });
      } else {
        throw Exception('Failed to fetch image URLs');
      }
    } catch (e) {
      print('Error fetching image URLs: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        color: Colors.lightBlueAccent[200],
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              width: 380,
              height: 510,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.lightBlue[600]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 150,
                          height: 240,
                          color: Colors.brown,
                          child: imageUrls.isNotEmpty
                              ? Image.network(
                                  imageUrls[0],
                                  fit: BoxFit.cover,
                                )
                              : const Center(child: CircularProgressIndicator()),
                        ),
                        Container(
                          width: 150,
                          height: 240,
                          color: Colors.brown,
                          child: imageUrls.isNotEmpty
                              ? Image.network(
                                  imageUrls[1],
                                  fit: BoxFit.cover,
                                )
                              : const Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 150,
                          height: 240,
                          color: Colors.brown,
                          child: imageUrls.isNotEmpty
                              ? Image.network(
                                  imageUrls[2],
                                  fit: BoxFit.cover,
                                )
                              : const Center(child: CircularProgressIndicator()),
                        ),
                        Container(
                          width: 150,
                          height: 240,
                          color: Colors.brown,
                          child: imageUrls.isNotEmpty
                              ? Image.network(
                                  imageUrls[3],
                                  fit: BoxFit.cover,
                                )
                              : const Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            //latest collection
            const SizedBox(height: 10),
            CarouselSlider(
              options: CarouselOptions(height: 250),
              items: imageUrls.map((imageUrl) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                          color: Colors.lightBlue[500],
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Container(
                            width: 320,
                            height: 250,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(imageUrl),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            ),

// top selling
            const SizedBox(
              height: 35,
            ),
            const Padding(
              padding: EdgeInsets.only(right: 250),
              child: Text(
                'Top Selling',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 10),

            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 180,
                      height: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.lightBlue[600],
                      ),
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 170,
                                height: 220,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: imageUrls.isNotEmpty
                                      ? DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(imageUrls[0]),
                                        )
                                      : const DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              'https://via.placeholder.com/150'),
                                        ),
                                ),
                              )),
                          Container(
                            width: 170,
                            height: 110,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                color: Colors.white),
                            child: Column(
                              children: [
                                Text(
                                  offerData.isNotEmpty
                                      ? offerData[0]["cat_name"]
                                      : "",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  offerData.isNotEmpty
                                      ? "${offerData[0]["price"]}"
                                      : "",
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 180,
                      height: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.lightBlue[600],
                      ),
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 170,
                                height: 220,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: imageUrls.isNotEmpty
                                      ? DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(imageUrls[1]),
                                        )
                                      : const DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              'https://via.placeholder.com/150'),
                                        ),
                                ),
                              )),
                          Container(
                            width: 170,
                            height: 110,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                color: Colors.white),
                            child: Column(
                              children: [
                                Text(
                                  offerData.isNotEmpty
                                      ? offerData[1]["cat_name"]
                                      : "",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  offerData.isNotEmpty
                                      ? "${offerData[1]["price"]}"
                                      : "",
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 180,
                      height: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.lightBlue[600],
                      ),
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 170,
                                height: 220,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: imageUrls.isNotEmpty
                                      ? DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(imageUrls[2]),
                                        )
                                      : const DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              'https://via.placeholder.com/150'),
                                        ),
                                ),
                              )),
                          Container(
                            width: 170,
                            height: 110,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                color: Colors.white),
                            child: Column(
                              children: [
                                Text(
                                  offerData.isNotEmpty
                                      ? offerData[2]["cat_name"]
                                      : "",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  offerData.isNotEmpty
                                      ? "${offerData[2]["price"]}"
                                      : "",
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 180,
                      height: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.lightBlue[600],
                      ),
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 170,
                                height: 220,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: imageUrls.isNotEmpty
                                      ? DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(imageUrls[3]),
                                        )
                                      : const DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              'https://via.placeholder.com/150'),
                                        ),
                                ),
                              )),
                          Container(
                            width: 170,
                            height: 110,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                color: Colors.white),
                            child: Column(
                              children: [
                                Text(
                                  offerData.isNotEmpty
                                      ? offerData[3]["cat_name"]
                                      : "",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  offerData.isNotEmpty
                                      ? "${offerData[3]["price"]}"
                                      : "",
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
