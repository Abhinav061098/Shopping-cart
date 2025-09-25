import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../providers/cart_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartItemTile extends ConsumerWidget {
  final CartItem item;
  const CartItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF5C4D2D), Color(0xFFBF9F5E)],
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              item.product.imageUrl,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 6),
                Text(
                  '\u20B9${item.product.price.toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ],
            ),
          ),
          Row(
            children: [
              // decrement
              IconButton(
                icon: ShaderMask(
                  shaderCallback: (bounds) => gradient.createShader(bounds),
                  blendMode: BlendMode.srcIn,
                  child: Icon(Icons.remove_circle_outline),
                ),
                onPressed:
                    () => ref
                        .read(cartProvider.notifier)
                        .decrementQuantity(item.product.id),
              ),
              Text(
                '${item.quantity}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              // increment
              IconButton(
                icon: ShaderMask(
                  shaderCallback: (bounds) => gradient.createShader(bounds),
                  blendMode: BlendMode.srcIn,
                  child: Icon(Icons.add_circle_outline),
                ),
                onPressed:
                    () => ref
                        .read(cartProvider.notifier)
                        .incrementQuantity(item.product.id),
              ),
              // delete
              IconButton(
                icon: ShaderMask(
                  shaderCallback: (bounds) => gradient.createShader(bounds),
                  blendMode: BlendMode.srcIn,
                  child: Icon(Icons.delete_outline),
                ),
                onPressed:
                    () => ref
                        .read(cartProvider.notifier)
                        .removeProduct(item.product.id),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
