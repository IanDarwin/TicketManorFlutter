// lib/providers/cart_provider.dart
import 'package:flutter/material.dart';
import '../model/cart_item.dart';
import '../model/event.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  double get totalPrice {
    return _cartItems.fold(0.0, (sum, item) => sum + (item.event.price * item.quantity));
  }

  void addItem(Event event) {
    int existingIndex = _cartItems.indexWhere((item) => item.event.id == event.id);
    if (existingIndex != -1) {
      _cartItems[existingIndex].incrementQuantity();
    } else {
      _cartItems.add(CartItem(event: event));
    }
    notifyListeners();
  }

  void removeItem(String eventId) {
    _cartItems.removeWhere((item) => item.event.id == eventId);
    notifyListeners();
  }

  void incrementQuantity(String eventId) {
    _cartItems.firstWhere((item) => item.event.id == eventId).incrementQuantity();
    notifyListeners();
  }

  void decrementQuantity(String eventId) {
    CartItem item = _cartItems.firstWhere((item) => item.event.id == eventId);
    if (item.quantity > 1) {
      item.decrementQuantity();
    } else {
      _cartItems.remove(item); // Remove if quantity becomes 0
    }
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
