import 'package:flutter/material.dart';
import 'jazzcash_flutter.dart';
import 'jazzcash_payment_request.dart';
import 'jazz_expports.dart';
import 'package:pharma_glow/views/home_page/items.dart';
import 'package:pharma_glow/views/home_page/home_page.dart';

class JazzPage extends StatefulWidget {
  final List<CartItemModel> cartItems;

  const JazzPage({super.key, required this.cartItems});

  @override
  State<JazzPage> createState() => _JazzPageState();
}

class _JazzPageState extends State<JazzPage> {

  String paymentStatus = "pending";
  // ProductModel productModel = ProductModel("Product 1", "5");
  String integritySalt= "hax6160yc1";
  String merchantID= "MC57865";
  String merchantPassword = "u3074179xh";
  String transactionUrl= "https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF001D66),
        title: Text("JazzCash Flutter Example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text("Product Name : ${productModel.productName}"),
            // Text("Product Price : ${productModel.productPrice}"),
            ElevatedButton(
                onPressed: () {
                  _payViaJazzCash(context);
            },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.red.shade600,
                    width: 2.5,
                  ),
                  borderRadius: BorderRadius.circular(4),
                )
              ),
                child: Text("Purchase Now !",
                  style:  TextStyle(
                    color: Colors.yellow.shade500,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            )
          ],
        ),
      ),
    );
  }

  Future _payViaJazzCash(BuildContext context) async {
    List<CartItemModel> cartItems = CartManager.getCartItems();

    if (cartItems.isNotEmpty) {
      try {
        JazzCashFlutter jazzCashFlutter = JazzCashFlutter(
          merchantId: merchantID,
          merchantPassword: merchantPassword,
          integritySalt: integritySalt,
          isSandbox: true,
        );

        DateTime date = DateTime.now();

        for (CartItemModel item in cartItems) {
          JazzCashPaymentDataModelV1 paymentDataModelV1 = JazzCashPaymentDataModelV1(
            ppAmount: (item.productPrice + 200).toString(),
            ppBillReference: 'refbill${date.year}${date.month}${date.day}${date.hour}${date.millisecond}',
            ppDescription: 'Product name: ${item.productName} - Rs. ${item.productPrice}',
            ppMerchantID: merchantID,
            ppPassword: merchantPassword,
            ppReturnURL: transactionUrl,
          );

          jazzCashFlutter.startPayment(paymentDataModelV1: paymentDataModelV1, context: context).then((_response) {
            print("response from jazzcash $_response");

            // _checkIfPaymentSuccessfull(_response, element, context).then((res) {
            //   // res is the response you returned from your return URL;
            //   return res;
            // });

            setState(() {});
          });
        }
      } catch (err) {
        print("Error in payment $err");
        // CommonFunctions.CommonToast(
        //   message: "Error in payment $err",
        // );
        return false;
      }
    } else {
      print("No items in the cart.");
    }
  }

}
//  class ProductModel {
//   String? productName;
//  String? productPrice;
//
//  ProductModel(this.productName, this.productPrice);
// }
