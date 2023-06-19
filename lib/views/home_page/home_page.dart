import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_glow/Login.dart';
import 'package:pharma_glow/Prescription.dart';
import 'package:pharma_glow/chat/chat.dart';
import 'package:pharma_glow/consts/consts.dart';
import 'package:pharma_glow/views/home_page/home.dart';
import 'package:pharma_glow/Controller/home_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:pharma_glow/lib/firebase_options.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pharma_glow/views/splash-screen-logo/splash.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../ToastMessage/Utilis.dart';
import '../../checkout/Checkout.dart';
import '../../consts/lists.dart';
import 'items.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(PharmaGlowApp());
}
class PharmaGlowApp extends StatelessWidget {
  const PharmaGlowApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pharma Glow',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = Get.put(HomeController());
  int cartItemCount = 0;

  final List<BottomNavigationBarItem> navbarItems = [
    BottomNavigationBarItem(
      icon: Image.asset(icHome, width: 24),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.chat_bubble_outline),
      label: 'ChatBot',
    ),
    BottomNavigationBarItem(
      icon: Image.asset(icCart, width: 24),
      label: 'Cart',
    ),
    BottomNavigationBarItem(
      icon: Image.asset(icProfile, width: 24),
      label: 'Account',
    ),
  ];


  final List<Widget> navBody = [
    Home(),
    const CategoryPage(),
    CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF001D66),
        title: Text(
          'PharmaGlow',
          style: GoogleFonts.dancingScript(
              color: Colors.white,
              textStyle: TextStyle(
                fontSize: 30,
              )
          ),
        ),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                Icon(Icons.shopping_cart),
                if (cartItemCount > 0) Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${cartItems.length}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {
              // Navigate to the cart page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(),
                ),
              );
            },
          ),

        ],

        centerTitle: false,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
    Expanded(
    child: Container(
    color: Colors.white,
    width: context.screenWidth,
    height: context.screenHeight,
    child: SafeArea(
    child: Column(
    children: [
    Container(
          alignment: Alignment.center,
          height: 60,
          color: Colors.grey,
          child: TextFormField(
          decoration: InputDecoration(
                suffixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                hintText: "Search",
           ),
        ),
    ),
    Expanded(
    child: VxSwiper.builder(
    autoPlay: true,
    height: 220,
    enlargeCenterPage: true,
    itemCount: slidersList.length,
      itemBuilder: (context, index) {
        return Image.asset(
          slidersList[index],
          fit: BoxFit.fill,
        )
            .box
            .rounded
            .clip(Clip.antiAlias)
            .make();
      },
    ),
    ),
],
    ),
    ),
      ),),
          // Expanded(
          //   child:
          //   Obx(() {
          //     final currentIndex = controller.currentNavIndex.value;
          //     if (currentIndex >= 0 && currentIndex < navBody.length) {
          //       return navBody[currentIndex];
          //     } else {
          //       // Return a fallback widget if the index is invalid
          //       return Container(); // Replace Container() with the appropriate fallback widget
          //     }
          //   }),
          // ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    buildCategoryCard(
                      context,
                      'Prescription Drugs',
                      'assets/images/prescription.jpg',
                    ),
                    buildCategoryCard(
                      context,
                      'Cold Relief',
                      'assets/images/cold.webp',
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    buildCategoryCard(
                      context,
                      'Everyday Essentials',
                      'assets/images/everyday.webp',
                    ),
                    buildCategoryCard(
                      context,
                      'Facial Care',
                      'assets/images/facial-care.webp',
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    buildCategoryCard(
                      context,
                      'Multivitamins',
                      'assets/images/vitamins.webp',
                    ),
                    buildCategoryCard(
                      context,
                      'Baby Care',
                      'assets/images/baby.webp',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentNavIndex.value >= navbarItems.length ? 0 : controller.currentNavIndex.value,
          selectedItemColor: Colors.white,
          selectedLabelStyle: const TextStyle(fontFamily: 'semibold'),
          unselectedItemColor: Colors.white,
          backgroundColor: const Color(0xFF001D66),
          type: BottomNavigationBarType.fixed,
          items: navbarItems,

          onTap: (value) {
            setState(() {
              controller.currentNavIndex.value = value;
              switch (value){
                case 0:
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                  break;
                case 1:
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatScreen()));
                  break;
                case 2:
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
                  break;
                case 3:
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>LoginScreen()));
                  break;
              }

            });
          },
        ),
      ),
    );
  }

  Widget buildCategoryCard(
      BuildContext context, String title, String imageUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductsPage(category: title),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Image.asset(
              imageUrl,
              width: 120.0,
              height: 120.0,
            ),
            const SizedBox(height: 10.0),
            Text(
              title,
              style: TextStyle(
                color: const Color(0xFF001D66),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Category Page'),
      ),
    );
  }
}

class ProductsPage extends StatelessWidget {
  final String category;

  const ProductsPage({required this.category});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF001D66),
        title: Text(category),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to the cart page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(),
                ),
              );
            },
          ),
        ],
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('products')
            .where('category', isEqualTo: category)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Text('No products available for this category.');
          }

          final products = snapshot.data!.docs;

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Two cards in each row
              childAspectRatio: 0.75, // Adjust the aspect ratio as needed
            ),
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot document = products[index];
              // Access the product data from the document
              String productName = document['name'];
              String productDesc = document['desc'];
              String productImage = document['image'];
              int productPrice = document['price'];

              return GestureDetector(
                onTap: () {
                  // Navigate to product details page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailsPage(
                        productName: productName,
                        productImage: productImage,
                        productPrice: productPrice,
                        productDesc: productDesc,
                      ),
                    ),
                  );
                },
                child: Card(
                  margin: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Image.network(
                        productImage,
                        width: 120.0,
                        height: 120.0,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        productName,
                        style: TextStyle(
                          color: Color(0xFF001D66),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        ' Rs. ${productPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Color(0xFF001D66),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: () {
                      CartItemModel cartItem = CartItemModel(
                          productName: productName,
                          productImage: productImage,
                          productPrice: productPrice,
                          index: 1,
                      );
                      cartItems.add(cartItem);
                      CartManager.addToCart(cartItem);
                      Utilis().toastMessage('$productName has been added to the cart');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF001D66), // Set the desired background color
                    ),
                    child: Text('Add to Cart'),
                  ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

}
class ProductDetailsPage extends StatelessWidget {
  final String productName;
  final String productImage;
  final int productPrice;
  final String productDesc;

  const ProductDetailsPage({
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.productDesc,

  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF001D66),
        title: Text(productName),
      ),
      body: Padding(
        padding: EdgeInsets.all(1.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 1.0),
            Image.network(
              productImage,
              width: 400.0,
              height: 400.0,
            ),

            Center(
            child:Text(
              productDesc,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.center,


            ),
            ),
            SizedBox(height: 50.0),

            Text(
              'Rs. ${productPrice.toString()}',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              width: 350, // Set the desired width
              child: ElevatedButton(
                onPressed: () {
                  CartItemModel cartItem = CartItemModel(
                    productName: productName,
                    productImage: productImage,
                    productPrice: productPrice,
                    index: 1,
                  );
                  cartItems.add(cartItem);
                  Utilis().toastMessage('$productName has been added to the cart');
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF001D66), // Set the desired background color
                ),
                child: Text('Add to Cart'),
              ),
            ),

          ],
        ),
      ),

    );
  }
}
class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool editMode = false;
  bool PrescriptionUploaded = false;
  Color CheckoutButtonColor = Colors.grey[700]!;

  void CheckPrescriptionUploaded() async{
    await Navigator.push(context, MaterialPageRoute(builder: (context) => Prescription_Upload()));
    PrescriptionUploaded = true;
    setState(() {
      CheckoutButtonColor = Color(0xFF001D66) ;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF001D66),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Shopping Cart',
          style: GoogleFonts.oxygen(
            textStyle: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )

        ),
    ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Padding(
          //   padding: EdgeInsets.only(left: 22.0, right: 16.0, top: 22.0),
          //   child:
          // ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${cartItems.length} Products',
                  style: TextStyle(fontSize: 14.0),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      editMode = !editMode;
                    });
                  },
                  child: Text(
                    'Edit',
                    style: TextStyle(fontSize: 14.0),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 8,
            color: Color(0xFF001D66),
            indent: 22.0,
            endIndent: 22.0,
            thickness: 2,

          ),
          SizedBox(height: 16.0),
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return CartItem(
                  cartItems: cartItems[index],
                  editMode: editMode,
                  onDelete: () {
                    setState(() {
                      cartItems.removeAt(index);
                    });
                  },
                  onIncrement: () {
                    setState(() {
                      cartItems[index].quantity++;
                    });
                  },
                  onDecrement: () {
                    setState(() {
                      if (cartItems[index].quantity > 1) {
                        cartItems[index].quantity--;
                      }
                    });
                  },
                );
              },
            ),
          ),
          SizedBox(height: 16.0),
          OrderSummary(
            subtotal: cartItems.fold(
                0, (sum, cartItems) => sum + (cartItems.productPrice * cartItems.quantity)),
            deliveryFee: 200,
            totalAmount: cartItems.fold(
                0, (sum, cartItems) => sum + (cartItems.productPrice * cartItems.quantity).toInt()) + 200,
          ),
          SizedBox(height: 16.0),
          Center(
            child: Container(
              width: 300,
              height: 40,
              margin: EdgeInsets.all(5.0),
              child: ElevatedButton(
                onPressed: () {
                  CheckPrescriptionUploaded();
                },
                style:ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF001D66),
                  // Color(0xFF001D66), // Set the desired background color
                ),
                child: Text('Upload prescription',
                    style: GoogleFonts.oxygen(
                      textStyle:TextStyle(
                          color: Colors.white,
                          fontSize: 20
                      ),)
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Center(
            child: Container(
              width: 300,
              height: 40,
              margin: EdgeInsets.all(5.0),
              child: ElevatedButton(
                onPressed: () {
                  // Implement checkout functionality
                  if (PrescriptionUploaded == true){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  Checkout(totalAmount: cartItems.fold(
                      0, (sum, cartItems) => sum + (cartItems.productPrice * cartItems.quantity).toInt()) + 200,),
                  ));} else {null;}
                },
                style:ElevatedButton.styleFrom(
                  backgroundColor: CheckoutButtonColor, // Set the desired background color
                ),
                child: Text('Checkout',
                  style: GoogleFonts.oxygen(
                    textStyle:TextStyle(
                    color: Colors.white,
                      fontSize: 20
                  ),)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  final CartItemModel cartItems;
  final bool editMode;
  final VoidCallback onDelete;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CartItem({
    Key? key,
    required this.cartItems,
    required this.editMode,
    required this.onDelete,
    required this.onIncrement,
    required this.onDecrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(
              cartItems.productImage,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItems.productName,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Item no. ${cartItems.index + 1}',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    'Rs.${cartItems.productPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            if (editMode)
              IconButton(
                onPressed: onDelete,
                icon: Icon(Icons.close),
              ),
            if (!editMode)
              Container(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: onDecrement,
                      icon: Icon(Icons.remove, size: 14.0,),
                      padding: EdgeInsets.zero,
                    ),
                    Text(
                      cartItems.quantity.toString(),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    IconButton(
                      onPressed: onIncrement,
                      icon: Icon(Icons.add, size: 14.0,),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class OrderSummary extends StatelessWidget {
  final double subtotal;
  final double deliveryFee;
  final double totalAmount;

  const OrderSummary({
    Key? key,
    required this.subtotal,
    required this.deliveryFee,
    required this.totalAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 18.0, right: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Subtotal'),
              Text('Rs.${subtotal.toStringAsFixed(2)}'),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Delivery Fee'),
              Text('Rs.${deliveryFee.toStringAsFixed(2)}'),
            ],
          ),
          SizedBox(height: 8.0),
          Divider(
            height: 1,
            color: Colors.grey[400],
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Rs. ${(totalAmount).toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.0)
        ],
      ),
    );
  }
}

class CartItemModel {
  final String productName;
  final int productPrice;
  final String productImage;
  int quantity;
  final int index;

  CartItemModel({
    required this.productName,
    required this.productPrice,
    required this.productImage,
    this.quantity = 1,
    required this.index,
  });
}

List<CartItemModel> cartItems = [];




