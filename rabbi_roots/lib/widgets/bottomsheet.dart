import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart'; // Import the badges package
import 'package:rabbi_roots/models/cart.dart';

void showCartBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Consumer<CartModel>(
        builder: (context, cart, child) {
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Your Cart',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                // Constraining ListView
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      return ListTile(
                        leading: Image.network(
                          "https://s3-alpha-sig.figma.com/img/deb2/759a/6f8e07da63ca90d5fa076b3102ff7577?Expires=1736121600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Ubz5e2Tlx2DDgBmjCTStj0oo~f51BfzmXoDWkZaUsnYAgbWG4axQHjoNaxodhLQCJtLBZdeZhR0Jy5Fv7AF28y3s1PMqC0w01LM0D0N~epNuiC86cCXG5sLLQ1OO-lcFJ-JSSNc1x7qFb35pAZ2MJ-E53s85oKMTfMDNqtUd6pI-r4nZb-6PatdEI-u5RgCM7P1sb9o2xdbWZvxX8paFS1AMkISDksVwyPNxZ-4HIQsFfSHhRba31i9nEcRFtLWk8bbtAdsS8s5asjsSJhpK0f3HNnmensde-r5V6MuBytHK22puXEtE2n20YE~~CeRVWN6-OAkB0mql6YWhXVocrQ__",
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(item.product.productName),
                        subtitle: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                cart.decrementQuantity(item.product);
                              },
                            ),
                            Text('Quantity: ${item.quantity}'),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                cart.incrementQuantity(item.product);
                              },
                            ),
                          ],
                        ),
                        trailing:
                            Text('₹${item.product.price * item.quantity}'),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close'),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
