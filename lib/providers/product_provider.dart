import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

final productProvider = FutureProvider<List<Product>>((ref) async {
  final data = await rootBundle.loadString('assets/products.json');
  final List<dynamic> jsonResult = json.decode(data);
  return jsonResult.map((e) => Product.fromJson(e)).toList();
});
