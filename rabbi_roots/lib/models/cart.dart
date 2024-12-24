import 'package:flutter/material.dart';
import 'package:rabbi_roots/widgets/product_card_sub.dart';

class CartItem {
  final ProductCard product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}

class CartModel extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addProduct(ProductCard product) {
    for (var item in _items) {
      if (item.product == product) {
        item.quantity++;
        notifyListeners();
        return;
      }
    }
    _items.add(CartItem(product: product, quantity: 1));
    notifyListeners();
  }

  void removeProduct(ProductCard product) {
    _items.removeWhere((item) => item.product == product);
    notifyListeners();
  }

  void incrementQuantity(ProductCard product) {
    for (var item in _items) {
      if (item.product == product) {
        item.quantity++;
        notifyListeners();
        return;
      }
    }
  }

  void decrementQuantity(ProductCard product) {
    for (var item in _items) {
      if (item.product == product && item.quantity > 1) {
        item.quantity--;
        notifyListeners();
        return;
      } else if (item.product == product && item.quantity == 1) {
        removeProduct(product);
        return;
      }
    }
  }

  void updateQuantity(ProductCard product, int quantity) {
    for (var item in _items) {
      if (item.product == product) {
        item.quantity = quantity;
        notifyListeners();
        return;
      }
    }
  }
}
