import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cart_provider.dart';

class CartBadge extends ConsumerWidget {
  final bool useGradient;
  const CartBadge({super.key, this.useGradient = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final icon =
        useGradient
            ? ShaderMask(
              shaderCallback:
                  (bounds) => LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF5C4D2D), Color(0xFFBF9F5E)],
                  ).createShader(bounds),
              blendMode: BlendMode.srcIn,
              child: Icon(Icons.shopping_cart, color: Colors.white),
            )
            : Icon(
              Icons.shopping_cart,
              color: Theme.of(context).iconTheme.color,
            );

    return Stack(
      alignment: Alignment.center,
      children: [
        icon,
        if (cart.isNotEmpty)
          Positioned(
            right: 0,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Text(
                '${cart.length}',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
      ],
    );
  }
}
