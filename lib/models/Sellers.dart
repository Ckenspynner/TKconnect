import 'package:flutter/material.dart';

class Seller {
  final int id;
  final String title, description;
  final List<String> images;
  final List<Color> colors;
  final double rating, price;
  final bool isFavourite, isPopular;

  Seller({
    required this.id,
    required this.images,
    required this.colors,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.price,
    required this.description,
  });
}

// Our demo Sellers

List<Seller> demoSellers = [
  Seller(
    id: 1,
    images: [
      "assets/images/wood.png",
      "assets/images/wood1.png",
      "assets/images/wood2.png",
      //"assets/images/ps4_console_white_4.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Processed Wood",
    price: 64.99,
    description: description,
    rating: 4.8,
    isFavourite: true,
    isPopular: true,
  ),
  Seller(
    id: 2,
    images: [
      "assets/images/metal1.png",
      "assets/images/metal2.png",
      "assets/images/metal3.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Metals",
    price: 50.5,
    description: description,
    rating: 4.1,
    isPopular: true,
  ),
  Seller(
    id: 3,
    images: [
      "assets/images/plastics1.png",
      "assets/images/plastics2.png",
      "assets/images/plastics3.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Plastics",
    price: 36.55,
    description: description,
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
  ),
  Seller(
    id: 4,
    images: [
      "assets/images/broken1.png",
      "assets/images/broken2.png",
      "assets/images/broken3.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Glass",
    price: 20.20,
    description: description,
    rating: 4.1,
    isFavourite: true,
  ),
];

const String description =
    "This section will contain details description of the Seller …";
