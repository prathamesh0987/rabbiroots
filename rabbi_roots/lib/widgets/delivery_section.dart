import 'package:flutter/material.dart';

class DeliverySection extends StatelessWidget {
  const DeliverySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xFFF06B2D),
                    radius: 25,
                    child: Icon(Icons.location_on, color: Colors.white),
                  ),
                  SizedBox(width: 9),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Deliver To',
                        style: TextStyle(
                          color: Color(0xFF056839),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Inter',
                        ),
                      ),
                      Text(
                        'Kothrud',
                        style: TextStyle(
                          color: Color(0xFF9D9D9D),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 9),
                  Icon(Icons.arrow_drop_down, color: Color(0xFF056839)),
                ],
              ),
              CircleAvatar(
                backgroundImage: AssetImage('assets/atta.png'),
                radius: 22.5,
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'Hello Amit, Good Afternoon !!',
            style: TextStyle(
              color: Color(0xFF056839),
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}
