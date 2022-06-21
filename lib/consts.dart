import 'package:flutter/material.dart';

//Basic class to stylize text and buttons
const Color violetColor = Color.fromARGB(255, 117, 47, 246);
const Color lightVioletColor = Color.fromARGB(255, 207, 189, 236);
const Color greyColor = Color.fromARGB(255, 37, 37, 37);
const Color whiteColor = Color(0xFFFFFFFF);

const TextStyle boldFont = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    fontFamily: 'Neue Plak Black',
    color: whiteColor);

const TextStyle boldFontBlack = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    fontFamily: 'Neue Plak Black',
    color: greyColor);

const TextStyle boldBigFont = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    fontFamily: 'Neue Plak Black',
    color: greyColor);

const TextStyle regularFont = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    fontFamily: 'Neue Plak Regular',
    color: whiteColor);

const TextStyle regularBlackFont = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    fontFamily: 'Neue Plak Regular',
    color: greyColor);

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
