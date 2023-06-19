import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'payment_config.dart';
import 'package:pharma_glow/ToastMessage/Utilis.dart';
import 'package:pharma_glow/confirmation/payemnt_succcessful.dart';
import 'package:pharma_glow/views/home_page/home_page.dart';
import 'package:pharma_glow/views/home_page/items.dart';
import 'package:pharma_glow/payment/Jazzcash/jazz_screen.dart';
// import 'jazzcash.dart';

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
      paymentItems: paymentItems,
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
              child: const Center(
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
                    child: const Center(
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
                          padding: const EdgeInsets.only(top: 12.0),
                          child: const Text(
                            'PAYMENT',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                            ),
                          ),
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
                    child: const Center(
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
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 200,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder:
                                          (context) => JazzPage(cartItems: CartManager.getCartItems()),
                                  )
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.red.shade800),
                              minimumSize: MaterialStateProperty.all<Size>(Size(160, 50)),
                            ),
                            child: Text('JAZZCASH',
                            style: TextStyle(
                              color: Colors.yellow[600],
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),)
                        ),
                      ],
                    ),
                    SizedBox(height: 30.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (Platform.isIOS) applePayButton,
                        if (!Platform.isIOS) googlePayButton,
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

