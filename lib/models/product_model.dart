import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductModel with ChangeNotifier {
  final String productId;
  final String productTitle;
  final String productPrice;
  final String productCategory;
  final String productDescription;
  final String productImage;
  final String productQuantity;
  final Timestamp? createdAt;

  ProductModel({
    required this.productId,
    required this.productTitle,
    required this.productPrice,
    required this.productCategory,
    required this.productDescription,
    required this.productImage,
    required this.productQuantity,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productTitle': productTitle,
      'productPrice': productPrice,
      'productCategory': productCategory,
      'productDescription': productDescription,
      'productImage': productImage,
      'productQuantity': productQuantity,
      'createdAt': createdAt?.toDate().toIso8601String(),
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['productId'],
      productTitle: map['productTitle'],
      productPrice: map['productPrice'].toDouble(),
      productCategory: map['productCategory'],
      productDescription: map['productDescription'],
      productImage: map['productImage'],
      productQuantity: map['productQuantity'],
      createdAt: map['createdAt'] != null ? Timestamp.fromDate(DateTime.parse(map['createdAt'])) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source));
  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return ProductModel(
      productId: data['productId'], //doc.get("productId"),
      productTitle: data['productTitle'],
      productPrice: data['productPrice'],
      productCategory: data['productCategory'],
      productDescription: data['productDescription'],
      productImage: data['productImage'],
      productQuantity: data['productQuantity'],
      createdAt: data['createdAt'],
    );
  }
}
