import 'package:flutter/material.dart';
import 'package:rabbi_roots/screens/make_payment_screen.dart';

class CheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Pop the current screen off the navigation stack
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Rabbi Roots',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Delivery Information
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.home, color: Colors.green),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('20 mins to home',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Block 10 karvenagar...',
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
                Icon(Icons.arrow_drop_down),
              ],
            ),
            SizedBox(height: 16),

            // Cart Item
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Aiwa Multigrain Atta',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            Icon(Icons.remove_circle_outline,
                                color: Colors.grey),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text('1', style: TextStyle(fontSize: 16)),
                            ),
                            Icon(Icons.add_circle_outline, color: Colors.grey),
                          ],
                        ),
                        Text('₹510',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Divider(height: 24, color: Colors.grey),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(Icons.add, color: Colors.green),
                          SizedBox(width: 8),
                          Text('Add more items',
                              style: TextStyle(color: Colors.green)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Recommended Items
            Text('You may like to add',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildRecommendedItem('Besan Atta', '₹250',
                      'https://s3-alpha-sig.figma.com/img/6ba4/0efd/b1c0ff7c1e47be56e17bd1f72cfc1231?Expires=1735516800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=HOKO1iBhUtQ7OyQ6KVcMYLLruNwwLoXPQFW2pzeBKRr2z4iN-p-oKLf0ZiYsRPjRVMbxre9okoTm6wAh8Rq7qlHCm6GlkRhFbkEj9n1A9r6kvEvyBzcEBtRdukzCTQ1kKjcURVM7-Q8vEAqyBC5p5TokFOFauS0U-8ArWGHD4-G0ALlJXFYJL3bA2wSUSvmCs2tOUMktwVBHVRwmfQIqBOOIhINUVoLNlR8VopG4mLuBbA6hrEN~5-7MQIvHoUma6DNlrnDpIno0veRiNA82LzbVGDxbazWp6WLhUzQWQdgcc-QxO0mEhp8u1sqiVfNlTiwEEZA-kf2kTDEtl0ZBHQ__'),
                  _buildRecommendedItem('Black Till', '₹125',
                      'https://s3-alpha-sig.figma.com/img/81c6/1b28/d0fb1b18e3f28c5eecbcbf8a464ba0c7?Expires=1735516800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Am3xJN7poJD3qS-lp6KHwjnLLncbICUEZeJOvbQlG4lNpegRBkc1NPYQK6UrppEZbjE-9I~sgSm2htoNQ0e6Eo0qo1CoKeQeIp72WhVWhUS12ji0HeMSjJzQRXmdehF2BO8bArP0cOwhnzhCbgy83G0Jr~OF1l6yJceE1MTRtWnCa0IN1f1no-WT4Bdw08AsnW1NRgKIge6~Eag9vHxeVmE4238idHH9az7OtFXE6wGP2vVs1A2~KhaucNbiZ3sPG~XZJSIfUarz~MqtWoUG1v7Oz1FjtOXcdWlQLFghxdLOz2eMSGSYKn6HA6pifTF9IUK2KhoEHmIRwOIrFn5XtA__'),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text('Offers and Benefits',
                style: TextStyle(fontWeight: FontWeight.bold)),

            // Offers and Benefits
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('₹80 off',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        Text('Flat deal | Above ₹399',
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    Icon(Icons.percent, color: Colors.green),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Delivery Instructions
            Text('Delivery Instructions',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDeliveryInstruction(
                    'Avoid ringing bell', Icons.notifications_off),
                _buildDeliveryInstruction('Leave at the door', Icons.security),
                _buildDeliveryInstruction(
                    'Leave with security', Icons.security),
              ],
            ),
            SizedBox(height: 16),

            // Price Details
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildPriceDetail('Item Total', '₹510'),
                    _buildPriceDetail('Delivery fee', '₹30'),
                    _buildPriceDetail('Taxes', '₹20'),
                    _buildPriceDetail('Discount', '-₹80', isDiscount: true),
                    Divider(color: Colors.grey, height: 24),
                    _buildPriceDetail('Total', '₹480', isTotal: true),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Proceed to Pay Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MakePaymentScreen()),
                  );
                },
                child: Text('Proceed To Pay',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendedItem(String name, String price, String imageUrl) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Image.network(
            imageUrl,
            height: 80,
            width: 80,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 8),
          Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(price, style: TextStyle(color: Colors.grey)),
          SizedBox(height: 8),
          Icon(Icons.add_circle, color: Colors.green),
        ],
      ),
    );
  }

  Widget _buildDeliveryInstruction(String label, IconData icon) {
    return Card(
      child: Column(
        children: [
          Icon(icon, size: 32, color: Colors.grey),
          SizedBox(height: 8),
          SizedBox(child: Text(label, textAlign: TextAlign.center)),
        ],
      ),
    );
  }

  Widget _buildPriceDetail(String label, String value,
      {bool isDiscount = false, bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: isTotal ? TextStyle(fontWeight: FontWeight.bold) : null),
          Text(
            value,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : null,
              color: isDiscount ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CheckoutScreen(),
  ));
}
