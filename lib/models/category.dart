import 'package:flutter/material.dart';

enum Categories {
  vegetables,
  fruit,
  meat,
  dairy,
  carbs,
  sweets,
  spices,
  convenience,
  hygiene,
  other,
}

// // extension CategoryExtension on String {
// //   Categories toCategory() {
// //     switch (toLowerCase()) {
// //       case 'fruit':
// //         return Categories.fruit;
// //       case 'vegetable':
// //         return Categories.vegetables;
// //       case 'dairy':
// //         return Categories.dairy;
// //       case 'meat':
// //         return Categories.meat;
// //       case 'carbs':
// //         return Categories.carbs;
// //       case 'sweets':
// //         return Categories.sweets;
// //       case 'spices':
// //         return Categories.spices;
// //       case 'convenience':
// //         return Categories.convenience;
// //       case 'hygiene':
// //         return Categories.hygiene;
// //       default:
// //         return Categories.other;
// //     }
//   }
// }

// extension CategoryStringExtension on Category {
//   String get value {
//     switch (this) {
//       case Category.fruit:
//         return 'Fruit';
//       case Category.vegetable:
//         return 'Vegetable';
//       case Category.dairy:
//         return 'Dairy';
//       case Category.meat:
//         return 'Meat';
//       case Category.other:
//         return 'Other';
//     }
//   }
// }

class Category {
  const Category(this.title, this.color);
  final String title;
  final Color color;
}
