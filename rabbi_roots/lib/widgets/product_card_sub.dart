import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String weight;
  final String productName;
  final String deliveryTime;
  final int price;
  final int mrp;

  const ProductCard({
    Key? key,
    required this.imageUrl,
    required this.weight,
    required this.productName,
    required this.deliveryTime,
    required this.price,
    required this.mrp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height
    double screenWidth = MediaQuery.sizeOf(context).width;

    // Adjust card width based on screen width
    double cardWidth = screenWidth * 0.45; // 45% of the screen width
    double imageHeight =
        screenWidth * 0.25; // Image height should be 25% of screen width
    double fontSize =
        screenWidth < 600 ? 12 : 14; // Scale text size for smaller screens

    return Container(
      width: cardWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 1,
            blurRadius: 4,
          ),
        ],
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image and Add Button
          Stack(
            clipBehavior:
                Clip.none, // To allow the button to overflow outside the image
            children: [
              // Product Image
              Center(
                child: Container(
                  height: imageHeight,
                  width: cardWidth, // Make image responsive to card width
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              // Add Button positioned at the bottom-right corner of the image
              Positioned(
                bottom: 6,
                right: 0,
                child: Container(
                  width: 60,
                  height: 28,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.pink),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text(
                      "Add",
                      style: TextStyle(
                        color: Colors.pink,
                        fontWeight: FontWeight.bold,
                        fontSize:
                            fontSize, // Adjust font size based on screen size
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 8),

          // Weight Tag
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              weight,
              style: TextStyle(
                fontSize: fontSize, // Adjust font size based on screen size
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          SizedBox(height: 8),

          // Product Name
          Text(
            productName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: fontSize + 2, // Make product name slightly larger
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          SizedBox(height: 4),

          // Delivery Time
          Row(
            children: [
              Icon(Icons.circle, size: 8, color: Colors.purple),
              SizedBox(width: 4),
              Text(
                deliveryTime,
                style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.black54,
                ),
              ),
            ],
          ),

          SizedBox(height: 8),

          // Price and MRP Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "₹$price",
                style: TextStyle(
                  fontSize: fontSize + 2, // Slightly larger for the price
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "MRP ₹$mrp",
                style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.black54,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
