// import 'package:flutter/material.dart';
//
// class Product {
//   final int id;
//   final String title, description, materialType, color, quantity, location, phone, subcounty;
//   final List<String> images;
//   final List<Color> colors;
//   final double rating, price;
//   final bool isFavourite, isPopular;
//
//   Product({
//     required this.materialType,
//     required this.color,
//     required this.phone,
//     required this.quantity,
//     required this.location,
//     required this.id,
//     required this.images,
//     required this.colors,
//     this.rating = 0.0,
//     this.isFavourite = false,
//     this.isPopular = false,
//     required this.title,
//     required this.price,
//     required this.description,
//     required this.subcounty,
//   });
// }
//
// // Our demo Products

// List<Product> demoProducts = [
//   Product(
//     id: 1,
//     images: [
//       "assets/images/wood.png",
//       "assets/images/wood1.png",
//       "assets/images/wood2.png",
//       //"assets/images/ps4_console_white_4.png",
//     ],
//     colors: [
//       Color(0xFFF6625E),
//       Color(0xFF836DB8),
//       Color(0xFFDECB9C),
//       Colors.white,
//     ],
//     title: "Organics",
//     price: 64.99,
//     description: description,
//     rating: 4.8,
//     isFavourite: true,
//     isPopular: true,
//     materialType: 'Saw Dust',
//     color: 'Brown',
//     quantity: '20',
//     location: 'Mombasa',
//     subcounty: 'Kisauni',
//     phone: '0710234567',
//   ),
//   // Product(
//   //   id: 2,
//   //   images: [
//   //     "assets/images/metal1.png",
//   //     "assets/images/metal2.png",
//   //     "assets/images/metal3.png",
//   //   ],
//   //   colors: [
//   //     Color(0xFFF6625E),
//   //     Color(0xFF836DB8),
//   //     Color(0xFFDECB9C),
//   //     Colors.white,
//   //   ],
//   //   title: "Metals",
//   //   price: 50.50,
//   //   description: description,
//   //   rating: 4.1,
//   //   isPopular: true,
//   //   materialType: 'Heavy',
//   //   color: 'Sliver',
//   //   quantity: '50',
//   //   location: 'Mombasa',
//   //   subcounty: 'Bamburi',
//   //   phone: '0711294565',
//   // ),
//   // Product(
//   //   id: 3,
//   //   images: [
//   //     "assets/images/plastics1.png",
//   //     "assets/images/plastics2.png",
//   //     "assets/images/plastics3.png",
//   //   ],
//   //   colors: [
//   //     Color(0xFFF6625E),
//   //     Color(0xFF836DB8),
//   //     Color(0xFFDECB9C),
//   //     Colors.white,
//   //   ],
//   //   title: "Plastics",
//   //   price: 36.55,
//   //   description: description,
//   //   rating: 4.1,
//   //   isFavourite: true,
//   //   isPopular: true,
//   //   materialType: 'PET',
//   //   color: 'Transparent',
//   //   quantity: '100',
//   //   location: 'Mombasa',
//   //   subcounty: 'Nyali',
//   //   phone: '0719234507',
//   // ),
//   // Product(
//   //   id: 4,
//   //   images: [
//   //     "assets/images/broken1.png",
//   //     "assets/images/broken2.png",
//   //     "assets/images/broken3.png",
//   //   ],
//   //   colors: [
//   //     Color(0xFFF6625E),
//   //     Color(0xFF836DB8),
//   //     Color(0xFFDECB9C),
//   //     Colors.white,
//   //   ],
//   //   title: "Glass",
//   //   price: 20.20,
//   //   description: description,
//   //   rating: 4.1,
//   //   isFavourite: true,
//   //   isPopular: true,
//   //   materialType: 'Broken Glass',
//   //   color: 'Transparent',
//   //   quantity: '160',
//   //   location: 'Mombasa',
//   //   subcounty: 'Mkomani',
//   //   phone: '0799234567',
//   // ),
//   // Product(
//   //   id: 5,
//   //   images: [
//   //     "assets/images/wood.png",
//   //     "assets/images/wood1.png",
//   //     "assets/images/wood2.png",
//   //     //"assets/images/ps4_console_white_4.png",
//   //   ],
//   //   colors: [
//   //     Color(0xFFF6625E),
//   //     Color(0xFF836DB8),
//   //     Color(0xFFDECB9C),
//   //     Colors.white,
//   //   ],
//   //   title: "Organics",
//   //   price: 64.99,
//   //   description: description,
//   //   rating: 4.8,
//   //   isFavourite: true,
//   //   isPopular: true,
//   //   materialType: 'Saw Dust',
//   //   color: 'Brown',
//   //   quantity: '220',
//   //   location: 'Mombasa',
//   //   subcounty: 'Kisauni',
//   //   phone: '0723451067',
//   // ),
//   // Product(
//   //   id: 6,
//   //   images: [
//   //     "assets/images/metal1.png",
//   //     "assets/images/metal2.png",
//   //     "assets/images/metal3.png",
//   //   ],
//   //   colors: [
//   //     Color(0xFFF6625E),
//   //     Color(0xFF836DB8),
//   //     Color(0xFFDECB9C),
//   //     Colors.white,
//   //   ],
//   //   title: "Metals",
//   //   price: 50.5,
//   //   description: description,
//   //   rating: 4.1,
//   //   isPopular: true,
//   //   materialType: 'Heavy',
//   //   color: 'Sliver',
//   //   quantity: '150',
//   //   location: 'Mombasa',
//   //   subcounty: 'Bamburi',
//   //   phone: '0729451165',
//   // ),
//   // Product(
//   //   id: 7,
//   //   images: [
//   //     "assets/images/plastics1.png",
//   //     "assets/images/plastics2.png",
//   //     "assets/images/plastics3.png",
//   //   ],
//   //   colors: [
//   //     Color(0xFFF6625E),
//   //     Color(0xFF836DB8),
//   //     Color(0xFFDECB9C),
//   //     Colors.white,
//   //   ],
//   //   title: "Plastics",
//   //   price: 36.55,
//   //   description: description,
//   //   rating: 4.1,
//   //   isFavourite: true,
//   //   isPopular: true,
//   //   materialType: 'PET',
//   //   color: 'Transparent',
//   //   quantity: '10',
//   //   location: 'Mombasa',
//   //   subcounty: 'Nyali',
//   //   phone: '0723419507',
//   // ),
//   // Product(
//   //   id: 8,
//   //   images: [
//   //     "assets/images/broken1.png",
//   //     "assets/images/broken2.png",
//   //     "assets/images/broken3.png",
//   //   ],
//   //   colors: [
//   //     Color(0xFFF6625E),
//   //     Color(0xFF836DB8),
//   //     Color(0xFFDECB9C),
//   //     Colors.white,
//   //   ],
//   //   title: "Glass",
//   //   price: 20.20,
//   //   description: description,
//   //   rating: 4.1,
//   //   isFavourite: true,
//   //   isPopular: true,
//   //   materialType: 'Broken Glass',
//   //   color: 'Transparent',
//   //   quantity: '180',
//   //   location: 'Mombasa',
//   //   subcounty: 'Mkomani',
//   //   phone: '0792394567',
//   // ),
// ];
//
// // Our demo Products
//
// List<Product> demoCategories = [
//   Product(
//     id: 1,
//     images: [
//       "assets/images/wood.png",
//       "assets/images/wood1.png",
//       "assets/images/wood2.png",
//       //"assets/images/ps4_console_white_4.png",
//     ],
//     colors: [
//       Color(0xFFF6625E),
//       Color(0xFF836DB8),
//       Color(0xFFDECB9C),
//       Colors.white,
//     ],
//     title: "Organics",
//     price: 64.99,
//     description: description,
//     rating: 4.8,
//     isFavourite: true,
//     isPopular: true,
//     materialType: 'Saw Dust',
//     color: 'Brown',
//     quantity: '20',
//     location: 'Mombasa',
//     subcounty: 'Kisauni',
//     phone: '0710234567',
//   ),
//   Product(
//     id: 2,
//     images: [
//       "assets/images/metal1.png",
//       "assets/images/metal2.png",
//       "assets/images/metal3.png",
//     ],
//     colors: [
//       Color(0xFFF6625E),
//       Color(0xFF836DB8),
//       Color(0xFFDECB9C),
//       Colors.white,
//     ],
//     title: "Metals",
//     price: 50.5,
//     description: description,
//     rating: 4.1,
//     isPopular: true,
//     materialType: 'Heavy',
//     color: 'Sliver',
//     quantity: '50',
//     location: 'Mombasa',
//     subcounty: 'Bamburi',
//     phone: '0711294565',
//   ),
//   Product(
//     id: 3,
//     images: [
//       "assets/images/plastics1.png",
//       "assets/images/plastics2.png",
//       "assets/images/plastics3.png",
//     ],
//     colors: [
//       Color(0xFFF6625E),
//       Color(0xFF836DB8),
//       Color(0xFFDECB9C),
//       Colors.white,
//     ],
//     title: "Plastics",
//     price: 36.55,
//     description: description,
//     rating: 4.1,
//     isFavourite: true,
//     isPopular: true,
//     materialType: 'PET',
//     color: 'Transparent',
//     quantity: '100',
//     location: 'Mombasa',
//     subcounty: 'Nyali',
//     phone: '0719234507',
//   ),
//   Product(
//     id: 4,
//     images: [
//       "assets/images/broken1.png",
//       "assets/images/broken2.png",
//       "assets/images/broken3.png",
//     ],
//     colors: [
//       Color(0xFFF6625E),
//       Color(0xFF836DB8),
//       Color(0xFFDECB9C),
//       Colors.white,
//     ],
//     title: "Glass",
//     price: 20.20,
//     description: description,
//     rating: 4.1,
//     isFavourite: true,
//     materialType: 'Broken Glass',
//     color: 'Transparent',
//     quantity: '160',
//     location: 'Mombasa',
//     subcounty: 'Mkomani',
//     phone: '0799234567',
//   ),
// ];
//
// const String description =
//     "This section will contain details description of the product …";