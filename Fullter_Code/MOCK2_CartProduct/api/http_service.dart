import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:untitled2/MOCK2_CartProduct/model/cart.dart';
import 'package:untitled2/MOCK2_CartProduct/model/detail_order.dart';
import 'package:untitled2/MOCK2_CartProduct/model/product.dart';

class HttpService{

  static const String urlGetProducts = 'http://10.0.2.2:8080/api/v2/products?';
  static const String urlGetProduct = 'http://10.0.2.2:8080/api/v2/products/';
  static const String token = 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsInJvbGUiOiJBRE1JTiIsImlhdCI6MTcyMTkwOTkyMSwiZXhwIjoxNzIxOTExNzIxfQ.sSAliAC6BeSRIh9h2xkMTlu1V947ClbC9wrs4HuHK5s';

  static Future<List<Product>> getAllProducts(int page) async{
    const int limit = 3;
    final url = "${urlGetProducts}page=$page&limit=$limit";
    if (kDebugMode) {
      print(url);
    }
    final baseUrl = Uri.parse(url);
    final response = await http.get(baseUrl);

    if(response.statusCode == 200){
      List<Product> products = _parseProducts(utf8.decode(response.bodyBytes));
      return products;
    }
    throw Exception('Status code: ${response.statusCode}');
  }

  static List<Product> _parseProducts(String response){
    final jsonObject = jsonDecode(response);
    final List<dynamic> jsonResponse = jsonObject['content'];
    return jsonResponse.map<Product>((json) => Product.fromJson(json)).toList();
  }

  static Future<Product> getProduct(int id) async {
    final baseUrl = Uri.parse('$urlGetProduct$id');
    final response = await http.get(baseUrl);

    if (response.statusCode == 200) {
      Product product = _parseProduct(utf8.decode(response.bodyBytes));
      return product;
    } else {
      throw Exception('Failed to load product: Status code: ${response.statusCode}');
    }
  }

  static Product _parseProduct(String responseBody) {
    final Map<String, dynamic> json = jsonDecode(responseBody);
    return Product.fromJson(json);
  }


  static Future<void> createOrder(int total,List<Cart> carts) async {
    List<DetailOrder> orderCart = carts.map((cart) {
      return DetailOrder(
          productID: cart.productID,
          quantity: cart.quantity,
          unitPrice: cart.unitPrice
      );
    }).toList();
    // Convert orderCart to JSON
    List<Map<String, dynamic>> orderCartJson = orderCart.map((detail) => detail.toJson()).toList();
    // Get data from form

    final body = {
      "total": total,
      "paymentMethod": 1,
      "orderStatus": 1,
      "details": orderCartJson
    };


    const url = "http://10.0.2.2:8080/api/v2/orders";
    final uri = Uri.parse(url);
    try {
      final response = await http.post(
          uri,
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(body),
      );

      if (response.statusCode == 201) {
        if (kDebugMode) {
          print('Order created successfully.');
        }
      } else {
        if (kDebugMode) {
          print('Failed to create order. Status code: ${response.statusCode}');
          print('Response body: ${response.body}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('An error occurred: $e');
      }
    }
  }

}