import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_item.dart';
import 'dart:convert';

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]) {
    _loadCart();
  }

  Future<void> _loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartString = prefs.getString('cart');
    if (cartString != null) {
      final List<dynamic> jsonList = json.decode(cartString);
      state = jsonList.map((e) => CartItem.fromJson(e)).toList();
    }
  }

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartString = json.encode(state.map((e) => e.toJson()).toList());
    await prefs.setString('cart', cartString);
  }

  void addProduct(CartItem item) {
    final index = state.indexWhere((e) => e.product.id == item.product.id);
    if (index == -1) {
      state = [...state, item];
    } else {
      // create a new list with updated quantity
      final updated = [...state];
      final existing = updated[index];
      updated[index] = CartItem(
        product: existing.product,
        quantity: existing.quantity + item.quantity,
      );
      state = updated;
    }
    _saveCart();
  }

  void removeProduct(String productId) {
    state = state.where((e) => e.product.id != productId).toList();
    _saveCart();
  }

  void incrementQuantity(String productId) {
    final index = state.indexWhere((e) => e.product.id == productId);
    if (index != -1) {
      state =
          state.map((e) {
            if (e.product.id == productId) {
              return CartItem(product: e.product, quantity: e.quantity + 1);
            }
            return e;
          }).toList();
      _saveCart();
    }
  }

  void decrementQuantity(String productId) {
    final index = state.indexWhere((e) => e.product.id == productId);
    if (index == -1) return;

    final currentQty = state[index].quantity;
    if (currentQty > 1) {
      state =
          state.map((e) {
            if (e.product.id == productId) {
              return CartItem(product: e.product, quantity: e.quantity - 1);
            }
            return e;
          }).toList();
    } else {
      // remove item when quantity would drop below 1
      state = state.where((e) => e.product.id != productId).toList();
    }
    _saveCart();
  }

  void clearCart() {
    state = [];
    _saveCart();
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>(
  (ref) => CartNotifier(),
);
