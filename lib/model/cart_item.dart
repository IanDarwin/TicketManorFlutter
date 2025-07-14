import 'event.dart';

class CartItem {
  final Event event;
  int quantity;

  CartItem({required this.event, this.quantity = 1});

  void incrementQuantity() {
    quantity++;
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }
}
