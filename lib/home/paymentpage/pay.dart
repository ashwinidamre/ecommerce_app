import 'package:flutter/material.dart';
import 'package:upi_india/upi_india.dart';

class Pay extends StatefulWidget {
  const Pay({super.key});

  @override
  State<Pay> createState() => _PayState();
}

class _PayState extends State<Pay> {
  Future<UpiResponse>? _transaction;
  final UpiIndia _upiIndia = UpiIndia();
  // UpiApp app = UpiApp.googlePay;
  List<UpiApp>? apps;

  TextStyle header = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  TextStyle value = const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  @override
  void initState() {
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
      });
    }).catchError((e) {
      apps = [];
    });
    super.initState();
  }

  Future<UpiResponse> initiateTransaction(UpiApp app) async {
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: "9834789886@sbi",
      receiverName: 'Sahil Patel',
      transactionRefId: 'TestingUpiIndiaPlugin',
      transactionNote: 'Not actual. Just an example.',
      amount: 10.00,
    );
  }

  // Future<UpiResponse> initiateTransaction(UpiApp app) async {
  //   return _upiIndia.startTransaction(
  //     app: app,
  //     receiverUpiId: "abhishek11p121@oksbi",
  //     receiverName: '30:Abhishek vijay Patel',
  //     transactionRefId: 'TestingUpiIndiaPlugin',
  //     transactionNote: 'Not actual. Just an example.',
  //     amount: 1.00,
  //   );
  // }

  Widget displayUpiApps() {
    if (apps == null) {
      return const Center(child: CircularProgressIndicator());
    } else if (apps!.isEmpty)
      return Center(
        child: Text(
          "No apps found to handle transaction.",
          style: header,
        ),
      );
    else
      return Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Wrap(
            children: apps!.map<Widget>((UpiApp app) {
              return GestureDetector(
                onTap: () {
                  _transaction = initiateTransaction(app);
                  setState(() {});
                },
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.memory(
                        app.icon,
                        height: 60,
                        width: 60,
                      ),
                      Text(app.name),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
  }

  String _upiErrorHandler(error) {
    switch (error) {
      case UpiIndiaAppNotInstalledException:
        return 'Requested app not installed on device';
      case UpiIndiaUserCancelledException:
        return 'You cancelled the transaction';
      case UpiIndiaNullResponseException:
        return 'Requested app didn\'t return any response';
      case UpiIndiaInvalidParametersException:
        return 'Requested app cannot handle the transaction';
      default:
        return 'An Unknown error has occurred';
    }
  }

  void _checkTxnStatus(String status) {
    switch (status) {
      case UpiPaymentStatus.SUCCESS:
        print('Transaction Successful');
        break;
      case UpiPaymentStatus.SUBMITTED:
        print('Transaction Submitted');
        break;
      case UpiPaymentStatus.FAILURE:
        print('Transaction Failed');
        break;
      default:
        print('Received an Unknown transaction status');
    }
  }

  Widget displayTransactionData(title, body) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$title: ", style: header),
          Flexible(
              child: Text(
            body,
            style: value,
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UPI'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: displayUpiApps(),
          ),
          Expanded(
            child: FutureBuilder(
              future: _transaction,
              builder:
                  (BuildContext context, AsyncSnapshot<UpiResponse> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        _upiErrorHandler(snapshot.error.runtimeType),
                        style: header,
                      ), // Print's text message on screen
                    );
                  }

                  // If we have data then definitely we will have UpiResponse.
                  // It cannot be null
                  UpiResponse upiResponse = snapshot.data!;

                  // Data in UpiResponse can be null. Check before printing
                  String txnId = upiResponse.transactionId ?? 'N/A';
                  String resCode = upiResponse.responseCode ?? 'N/A';
                  String txnRef = upiResponse.transactionRefId ?? 'N/A';
                  String status = upiResponse.status ?? 'N/A';
                  String approvalRef = upiResponse.approvalRefNo ?? 'N/A';
                  _checkTxnStatus(status);

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        displayTransactionData('Transaction Id', txnId),
                        displayTransactionData('Response Code', resCode),
                        displayTransactionData('Reference Id', txnRef),
                        displayTransactionData('Status', status.toUpperCase()),
                        displayTransactionData('Approval No', approvalRef),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: Text('jhjjh'),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:upi_india/upi_india.dart';
// class Pay extends StatefulWidget {
//   const Pay({super.key});

//   @override
//   State<Pay> createState() => _PayState();
// }

// class _PayState extends State<Pay> {
//   Future<UpiResponse>? _transaction;
//   final UpiIndia _upiIndia = UpiIndia();
//   // UpiApp app = UpiApp.googlePay;
//   List<UpiApp>? apps;




//   TextStyle header = const TextStyle(
//     fontSize: 18,
//     fontWeight: FontWeight.bold,
//   );

//   TextStyle value = const TextStyle(
//     fontWeight: FontWeight.w400,
//     fontSize: 14,
//   );

//   @override
//   void initState() {
//     _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
//       setState(() {
//         apps = value;
//       });
//     }).catchError((e) {
//       apps = [];
//     });
//     super.initState();
//   }

//   Future<UpiResponse> initiateTransaction(UpiApp app, double finalTotal) async {
//     return _upiIndia.startTransaction(
//       app: app,
//       receiverUpiId: "abhishek11p121@oksbi",
//       receiverName: '30:Abhishek vijay Patel',
//       transactionRefId: 'TestingUpiIndiaPlugin',
//       transactionNote: 'Not actual. Just an example.',
//       // amount: finalTotal,
//       amount: 10.00,
//     );
//   }

//   // Future<double> fetchFinalTotal() async {
//   //   String apiUrl =
//   //       "http://192.168.251.76/projects/api_shoppingapp/fetch_order_details.php";

//   //   try {
//   //     var response = await http.get(Uri.parse(apiUrl));
//   //     print('Response status code: ${response.statusCode}');
//   //     print('Response body: ${response.body}');

//   //     if (response.statusCode == 200) {
//   //       if (response.headers['content-type']?.contains('application/json') ??
//   //           false) {
//   //         try {
//   //           List<dynamic> orders = jsonDecode(response.body);
//   //           if (orders.isNotEmpty) {
//   //             // Assuming the final total is in the first order
//   //             Map<String, dynamic> firstOrder = orders.first;
//   //             if (firstOrder.containsKey('final_total')) {
//   //               double finalTotal =
//   //                   double.parse(firstOrder['final_total'].toString());
//   //               print('Final Total: $finalTotal');
//   //               return finalTotal;
//   //             } else {
//   //               throw Exception('Key "final_total" not found in order');
//   //             }
//   //           } else {
//   //             throw Exception('No orders found');
//   //           }
//   //         } catch (e) {
//   //           throw Exception('Error parsing JSON: $e');
//   //         }
//   //       } else {
//   //         throw Exception(
//   //             'Unexpected content type: ${response.headers['content-type']}');
//   //       }
//   //     } else {
//   //       throw Exception(
//   //           'Failed to fetch final total. Status code: ${response.statusCode}');
//   //     }
//   //   } catch (e) {
//   //     print('Error fetching final total: $e');
//   //     rethrow;
//   //   }
//   // }
//   // Future<double> fetchFinalTotal() async {
//   //   String apiUrl =
//   //       "http://192.168.251.76/projects/api_shoppingapp/fetch_order_details.php";

//   //   try {
//   //     var response = await http.get(Uri.parse(apiUrl));
//   //     print('Response status code: ${response.statusCode}');
//   //     print('Response body: ${response.body}');

//   //     if (response.statusCode == 200) {
//   //       if (response.headers['content-type']?.contains('application/json') ??
//   //           false) {
//   //         try {
//   //           List<dynamic> orders = jsonDecode(response.body);
//   //           if (orders.isNotEmpty) {
//   //             // Assuming the final total is in the first order
//   //             Map<String, dynamic> firstOrder = orders.first;
//   //             if (firstOrder.containsKey('final_total')) {
//   //               double finalTotal =
//   //                   double.parse(firstOrder['final_total'].toString());
//   //               print('Final Total: $finalTotal');
//   //               return finalTotal;
//   //             } else {
//   //               throw Exception('Key "final_total" not found in order');
//   //             }
//   //           } else {
//   //             throw Exception('No orders found');
//   //           }
//   //         } catch (e) {
//   //           throw Exception('Error parsing JSON: $e');
//   //         }
//   //       } else {
//   //         throw Exception(
//   //             'Unexpected content type: ${response.headers['content-type']}');
//   //       }
//   //     } else {
//   //       throw Exception(
//   //           'Failed to fetch final total. Status code: ${response.statusCode}');
//   //     }
//   //   } catch (e) {
//   //     print('Error fetching final total: $e');
//   //     rethrow;
//   //   }
//   // }

//   // String _upiErrorHandler(error) {
//   //   switch (error) {
//   //     case UpiIndiaAppNotInstalledException:
//   //       return 'Requested app not installed on device';
//   //     case UpiIndiaUserCancelledException:
//   //       return 'You cancelled the transaction';
//   //     case UpiIndiaNullResponseException:
//   //       return 'Requested app didn\'t return any response';
//   //     case UpiIndiaInvalidParametersException:
//   //       return 'Requested app cannot handle the transaction';
//   //     default:
//   //       return 'An Unknown error has occurred';
//   //   }
//   // }

//   // void _checkTxnStatus(String status) {
//   //   switch (status) {
//   //     case UpiPaymentStatus.SUCCESS:
//   //       print('Transaction Successful');
//   //       break;
//   //     case UpiPaymentStatus.SUBMITTED:
//   //       print('Transaction Submitted');
//   //       break;
//   //     case UpiPaymentStatus.FAILURE:
//   //       print('Transaction Failed');
//   //       break;
//   //     default:
//   //       print('Received an Unknown transaction status');
//   //   }
//   // }

//   // Widget displayTransactionData(title, body) {
//   //   return Padding(
//   //     padding: const EdgeInsets.all(8.0),
//   //     child: Row(
//   //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //       children: [
//   //         Text("$title: ", style: header),
//   //         Flexible(
//   //           child: Text(
//   //             body,
//   //             style: value,
//   //           ),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
//    Widget displayUpiApps() {
//     if (apps == null) {
//       return const Center(child: CircularProgressIndicator());
//     } else if (apps!.isEmpty)
//       return Center(
//         child: Text(
//           "No apps found to handle transaction.",
//           style: header,
//         ),
//       );
//     else
//       // ignore: curly_braces_in_flow_control_structures
//       return Align(
//         alignment: Alignment.topCenter,
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: Wrap(
//             children: apps!.map<Widget>((UpiApp app) {
//               return GestureDetector(
//                 onTap: () {
//                   _transaction = initiateTransaction(app);
//                   setState(() {});
//                 },
//                 child: SizedBox(
//                   height: 100,
//                   width: 100,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Image.memory(
//                         app.icon,
//                         height: 60,
//                         width: 60,
//                       ),
//                       Text(app.name),
//                     ],
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//       );
//   }

//   String _upiErrorHandler(error) {
//     switch (error) {
//       case UpiIndiaAppNotInstalledException:
//         return 'Requested app not installed on device';
//       case UpiIndiaUserCancelledException:
//         return 'You cancelled the transaction';
//       case UpiIndiaNullResponseException:
//         return 'Requested app didn\'t return any response';
//       case UpiIndiaInvalidParametersException:
//         return 'Requested app cannot handle the transaction';
//       default:
//         return 'An Unknown error has occurred';
//     }
//   }

//   void _checkTxnStatus(String status) {
//     switch (status) {
//       case UpiPaymentStatus.SUCCESS:
//         print('Transaction Successful');
//         break;
//       case UpiPaymentStatus.SUBMITTED:
//         print('Transaction Submitted');
//         break;
//       case UpiPaymentStatus.FAILURE:
//         print('Transaction Failed');
//         break;
//       default:
//         print('Received an Unknown transaction status');
//     }
//   }

//   Widget displayTransactionData(title, body) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text("$title: ", style: header),
//           Flexible(
//               child: Text(
//             body,
//             style: value,
//           )),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('UPI'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: displayUpiApps(),
//           ),
//           Expanded(
//             child: FutureBuilder(
//               future: _transaction,
//               builder:
//                   (BuildContext context, AsyncSnapshot<UpiResponse> snapshot) {
//                 if (snapshot.connectionState == ConnectionState.done) {
//                   if (snapshot.hasError) {
//                     return Center(
//                       child: Text(
//                         _upiErrorHandler(snapshot.error.runtimeType),
//                         style: header,
//                       ), // Print's text message on screen
//                     );
//                   }

//                   // If we have data then definitely we will have UpiResponse.
//                   // It cannot be null
//                   UpiResponse upiResponse = snapshot.data!;

//                   // Data in UpiResponse can be null. Check before printing
//                   String txnId = upiResponse.transactionId ?? 'N/A';
//                   String resCode = upiResponse.responseCode ?? 'N/A';
//                   String txnRef = upiResponse.transactionRefId ?? 'N/A';
//                   String status = upiResponse.status ?? 'N/A';
//                   String approvalRef = upiResponse.approvalRefNo ?? 'N/A';
//                   _checkTxnStatus(status);

//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         displayTransactionData('Transaction Id', txnId),
//                         displayTransactionData('Response Code', resCode),
//                         displayTransactionData('Reference Id', txnRef),
//                         displayTransactionData('Status', status.toUpperCase()),
//                         displayTransactionData('Approval No', approvalRef),
//                       ],
//                     ),
//                   );
//                 } else {
//                   return const Center(
//                     child: Text('jhjjh'),
//                   );
//                 }
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// //   Widget displayUpiApps() {
// //     if (apps == null) {
// //       return const Center(child: CircularProgressIndicator());
// //     } else if (apps!.isEmpty)
// //       return Center(
// //         child: Text(
// //           "No apps found to handle transaction.",
// //           style: header,
// //         ),
// //       );
// //     else
// //       return Align(
// //         alignment: Alignment.topCenter,
// //         child: SingleChildScrollView(
// //           physics: const BouncingScrollPhysics(),
// //           child: Wrap(
// //             children: apps!.map<Widget>((UpiApp app) {
// //               return GestureDetector(
// //                 onTap: () {
// //                   fetchFinalTotal().then((finalTotal) {
// //                     _transaction = initiateTransaction(app, finalTotal);
// //                     setState(() {});
// //                   }).catchError((error) {
// //                     print('Error fetching final total: $error');
// //                   });
// //                 },
// //                 child: SizedBox(
// //                   height: 100,
// //                   width: 100,
// //                   child: Column(
// //                     mainAxisSize: MainAxisSize.min,
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: <Widget>[
// //                       Image.memory(
// //                         app.icon,
// //                         height: 60,
// //                         width: 60,
// //                       ),
// //                       Text(app.name),
// //                     ],
// //                   ),
// //                 ),
// //               );
// //             }).toList(),
// //           ),
// //         ),
// //       );
// //   }
// // }
