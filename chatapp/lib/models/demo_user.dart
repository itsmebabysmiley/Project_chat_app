import 'package:flutter/material.dart';

const users = [
  userGordon,
  userSalvatore,
  userSacha,
];

const userGordon = DemoUser(
  id: 'gordon',
  name: 'Gordon Hayes',
  image:
      'https://pbs.twimg.com/profile_images/1262058845192335360/Ys_-zu6W_400x400.jpg',
  phone: '08495311520',
);

const userSalvatore = DemoUser(
  id: 'salvatore',
  name: 'Salvatore Giordano',
  image:
      'https://pbs.twimg.com/profile_images/1252869649349238787/cKVPSIyG_400x400.jpg',
  phone: '08495311520',
);

const userSacha = DemoUser(
  id: 'sacha',
  name: 'Sacha Arbonel',
  image:
      'https://pbs.twimg.com/profile_images/1199684106193375232/IxA9XLuN_400x400.jpg',
  phone: '08495311520',
);

@immutable
class DemoUser {
  final String id;
  final String name;
  final String image;
  final String phone;

  const DemoUser(
      {required this.id,
      required this.name,
      required this.image,
      required this.phone});
}
