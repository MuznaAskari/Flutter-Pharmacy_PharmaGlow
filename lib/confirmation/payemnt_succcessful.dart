import 'package:flutter/material.dart';
import 'package:pharma_glow/views/home_page/home_page.dart';

class PaymentSuccessfulPage extends StatelessWidget {
  const PaymentSuccessfulPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40.0,
        backgroundColor: Color(0xFF001D66),
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
            icon: Icon(Icons.home_filled, color: Colors.white),
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
                    child: Center(
                      child: Text(
                        'PAYMENT',
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
                            'CONFIRMATION',
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
              ],
            ),
          ),
          Container(
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 80,
                    color: Colors.green,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Payment Successful',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
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

class UpwardTriangleIcon extends StatelessWidget {
  final double size;
  final Color color;

  const UpwardTriangleIcon({
    Key? key,
    this.size = 24,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: UpwardTrianglePainter(color),
    );
  }
}

class UpwardTrianglePainter extends CustomPainter {
  final Color color;

  UpwardTrianglePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    // path.moveTo(size.width / 2, 0);
    // path.lineTo(0, size.height);
    // path.lineTo(size.width, size.height);
    // path.close();
    path.moveTo(size.width / 2, 0); // Start from the top-left quarter point
    path.lineTo(size.width , size.height); // Draw a line to the top-right three-quarter point
    path.lineTo(0, size.height); // Draw a line to the bottom-left quarter point
    path.close(); // Close the path to complete the triangle

    final paint = Paint()..color = color;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}