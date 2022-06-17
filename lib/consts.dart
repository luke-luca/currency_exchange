import 'package:flutter/material.dart';

const Color violetColor = Color.fromARGB(255, 117, 47, 246);
const Color lightVioletColor = Color.fromARGB(255, 207, 189, 236);
const Color greyColor = Color.fromARGB(255, 37, 37, 37);
const Color whiteColor = Color(0xFFFFFFFF);
const TextStyle boldFont = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    fontFamily: 'Neue Plak Black',
    color: whiteColor);
final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
  primary: violetColor,
  minimumSize: const Size(160, 48),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
  ),
);

const InputDecoration inputDecoration = InputDecoration(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(16)),
  ),
  contentPadding: EdgeInsets.symmetric(horizontal: 16),
);
