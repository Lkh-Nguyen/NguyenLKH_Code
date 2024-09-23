import 'dart:collection';

import '../model/shoe.dart';

class ShoeData {
  static List<Shoe> shoes = [
    Shoe(
      id: "0",
      type: "Nike",
      price: 100,
      urlImage: "one.jpg",
      favor: false,
      sizes: [40, 41, 42, 43],
    ),
    Shoe(
      id: "1",
      type: "Nike",
      price: 200,
      urlImage: "two.jpg",
      favor: false,
      sizes: [40, 41, 42, 43],
    ),
    Shoe(
      id: "2",
      type: "Sneaker",
      price: 300,
      urlImage: "three.jpg",
      favor: false,
      sizes: [40, 41, 42, 43],
    ),
    Shoe(
      id: "3",
      type: "Sneaker",
      price: 400,
      urlImage: "five.jpg",
      favor: false,
      sizes: [40, 41, 42, 43],
    ),
    Shoe(
      id: "4",
      type: "Jordan",
      price: 500,
      urlImage: "six.jpg",
      favor: false,
      sizes: [40, 41, 42, 43],
    ),
    Shoe(
      id: "5",
      type: "Jordan",
      price: 600,
      urlImage: "seven.jpg",
      favor: false,
      sizes: [40, 41, 42, 43],
    ),
    Shoe(
      id: "6",
      type: "Football",
      price: 700,
      urlImage: "football1.jpg",
      favor: false,
      sizes: [40, 41, 42, 43],
    ),
    Shoe(
      id: "7",
      type: "Running",
      price: 800,
      urlImage: "running2.jpg",
      favor: false,
      sizes: [40, 41, 42, 43],
    ),
    Shoe(
      id: "8",
      type: "Air",
      price: 900,
      urlImage: "Air1.jpg",
      favor: false,
      sizes: [40, 41, 42, 43],
    ),
    Shoe(
      id: "9",
      type: "Air",
      price: 1000,
      urlImage: "Air2.jpg",
      favor: false,
      sizes: [40, 41, 42, 43],
    ),
  ];

  static List<String> typeShoes = [
    "All",
    "Nike",
    "Sneaker",
    "Jordan",
    "Football",
    "Running",
    "Air",
    "Adidas"
  ];
}
