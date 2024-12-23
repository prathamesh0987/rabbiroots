import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
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
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int quantity = 1;
  bool isAdded = false; // Track whether the product has been added

  void increment() {
    setState(() {
      quantity++;
    });
  }

  void decrement() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    } else {
      setState(() {
        quantity = 1;
        isAdded = false; // Reset isAdded to false when quantity is 0
      });
    }
  }

  void addToCart() {
    setState(() {
      isAdded = true; // Change the state to show quantity buttons
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height
    double screenWidth = MediaQuery.of(context).size.width;

    // Adjust card width based on screen width
    double cardWidth = screenWidth * 0.45; // 45% of the screen width
    double imageHeight =
        screenWidth * 0.25; // Image height should be 25% of screen width
    double fontSize =
        screenWidth < 600 ? 12 : 14; // Scale text size for smaller screens
    double buttonHeight = 28.0; // Height of the button
    double buttonWidth = 60.0; // Width of the button

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
                      image: widget.imageUrl.startsWith('http')
                          ? NetworkImage(widget.imageUrl) // For network URLs
                          : AssetImage(widget.imageUrl)
                              as ImageProvider, // For local assets
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              // Add Button or Quantity Control
              Positioned(
                bottom: 6,
                right: 0,
                child: isAdded
                    ? Container(
                        height: buttonHeight, // Consistent height
                        width:
                            buttonWidth, // Make the size same as "Add" button
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.pink),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: decrement,
                              child: Container(
                                height: buttonHeight, // Consistent height
                                width: buttonWidth / 3.5,

                                child: Center(
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.pink,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: buttonWidth / 3.5,
                              child: Text(
                                '$quantity',
                                style: TextStyle(
                                  fontSize: fontSize + 2,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: increment,
                              child: Container(
                                height: buttonHeight, // Consistent height
                                width: buttonWidth / 3.5,
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.pink,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : GestureDetector(
                        onTap: addToCart,
                        child: Container(
                          height: buttonHeight, // Consistent height
                          width: buttonWidth,
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
                                fontSize: fontSize,
                              ),
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
              widget.weight,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 8),

          // Product Name
          Text(
            widget.productName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: fontSize + 2,
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
                widget.deliveryTime,
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "₹${widget.price * quantity}", // Show price for current quantity
                style: TextStyle(
                  fontSize: fontSize + 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "MRP ₹${widget.mrp}",
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
