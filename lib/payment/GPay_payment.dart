import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'payment_config.dart';
import 'package:pharma_glow/ToastMessage/Utilis.dart';
import 'package:pharma_glow/confirmation/payemnt_succcessful.dart';
import 'package:pharma_glow/views/home_page/home_page.dart';
import 'package:pharma_glow/views/home_page/items.dart';
import 'jazzcash.dart';

class PaymentPage extends StatefulWidget {
  final double totalprice;
  const PaymentPage({Key? key,required this.totalprice,}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late double totalprice;
  String os = Platform.operatingSystem;
  late ApplePayButton applePayButton;
  late GooglePayButton googlePayButton;

  @override
  void initState() {
    super.initState();
    totalprice = widget.totalprice;

    applePayButton = ApplePayButton(
      paymentConfiguration: PaymentConfiguration.fromJsonString(defaultApplePay),
      paymentItems: const [
        PaymentItem(
          label: 'Item A',
          amount: '0.01',
          status: PaymentItemStatus.final_price,
        ),
        PaymentItem(
          label: 'Item B',
          amount: '0.01',
          status: PaymentItemStatus.final_price,
        ),
        PaymentItem(
          label: 'Total',
          amount: '0.02',
          status: PaymentItemStatus.final_price,
        ),
      ],
      style: ApplePayButtonStyle.black,
      width: double.infinity,
      height: 50,
      type: ApplePayButtonType.buy,
      margin: const EdgeInsets.only(top: 15.0),
      onPaymentResult: _navigateToPaymentSuccessfulPage,
      loadingIndicator: const Center(
        child: CircularProgressIndicator(),
      ),
    );

    googlePayButton = GooglePayButton(
      paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePay),
      paymentItems: paymentItems,
      type: GooglePayButtonType.pay,
      margin: const EdgeInsets.only(top: 15.0),
      onPaymentResult: _navigateToPaymentSuccessfulPage,
      loadingIndicator: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  // List<PaymentItem> get paymentItems {
  //   const _paymentItems = [
  //     PaymentItem(
  //       label: 'Total',
  //       amount: '1.99',
  //       status: PaymentItemStatus.final_price,
  //     ),
  //   ];
  //
  //   return _paymentItems;
  // }

  List<PaymentItem> get paymentItems {
    List<CartItemModel> cartItems = CartManager.getCartItems();

    List<PaymentItem> paymentItems = [];

    for (CartItemModel item in cartItems) {
      paymentItems.add(
        PaymentItem(
          label: item.productName,
          amount: item.productPrice.toString(),
          status: PaymentItemStatus.final_price,
        ),
      );
    }

    return paymentItems;
  }



  void _navigateToPaymentSuccessfulPage(dynamic paymentResult) {
    Utilis().toastMessage('STATUS UPDATED');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentSuccessfulPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40.0,
        backgroundColor: Color(0xFF001D66),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Center(
                child: Text(
                  "Checkout",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite, color: Colors.white),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 40.0,
            color: Color(0xFF001D66),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    child: Center(
                      child: Text(
                        'SHIPPING',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,

                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            'PAYMENT',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,

                            ),
                          ),
                          // color: Colors.red,
                          padding: EdgeInsets.only(top: 12.0),
                        ),
                        Container(
                          // color: Colors.green,
                          child: UpwardTriangleIcon(
                            color: Colors.white,
                            size: 10.0,
                          ),
                          padding: EdgeInsets.only(top: 2.0),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Center(
                      child: Text(
                        'CONFIRMATION',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,

                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                          onPressed: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder:
                                        (context) => JazzCash(totalAmount: totalprice))
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                          ),
                          child: Text('JAZZCASH',
                          style: TextStyle(
                            color: Colors.yellow[600],
                          ),)
                      ),
                      SizedBox(height: 50.0,),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (Platform.isIOS) applePayButton,
                      if (!Platform.isIOS) googlePayButton,
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

