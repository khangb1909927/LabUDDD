import 'package:flutter/foundation.dart';
class Product {
  final String? id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final ValueNotifier<bool> _isFavorite;


  Product({
    this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    isFavortie = false,
  }) : _isFavorite = ValueNotifier(isFavortie);

  set isFavorite(bool newValue) {
    _isFavorite.value = newValue;
  }

  bool get isFavorite {
    return _isFavorite.value;
  }

  ValueNotifier<bool> get isFavorriteListenable {
    return _isFavorite;
  }
  Product copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    String? imageUrl,
    bool? isFavortie,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      //isFavortie: isFavortie ?? this.isFavortie,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  static Product fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      imageUrl: json['imageUrl'],
    );
  }
}