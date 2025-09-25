import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/product_provider.dart';
import '../widgets/product_tile.dart';
import '../widgets/cart_badge.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFE6DAC1), Color(0xFFFAF8F4)],
            ),
          ),
        ),
        title: ShaderMask(
          shaderCallback:
              (bounds) => LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF5C4D2D), Color(0xFFBF9F5E)],
              ).createShader(bounds),
          blendMode: BlendMode.srcIn,
          child: Text(
            'Shop',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              icon: CartBadge(useGradient: true),
              onPressed: () => Navigator.pushNamed(context, '/cart'),
            ),
          ),
        ],
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      backgroundColor: Colors.grey[100],
      body: productsAsync.when(
        data:
            (products) => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8,
              ),
              child: ListView.separated(
                itemCount: products.length,
                separatorBuilder: (_, __) => SizedBox(height: 12),
                itemBuilder:
                    (context, index) => ProductTile(product: products[index]),
              ),
            ),
        loading:
            () => Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.black87),
              ),
            ),
        error:
            (e, _) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 56, color: Colors.grey[400]),
                  SizedBox(height: 12),
                  Text(
                    'Failed to load products',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
