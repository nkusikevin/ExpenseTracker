import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconMapping {
  static final Map<String, IconData> _iconMap = {
    'house': FontAwesomeIcons.house,
    'car': FontAwesomeIcons.car,
    'plane': FontAwesomeIcons.plane,
    'burger': FontAwesomeIcons.burger,
    'mug-saucer': FontAwesomeIcons.mugSaucer,
    'shirt': FontAwesomeIcons.shirt,
    'gift': FontAwesomeIcons.gift,
    'gamepad': FontAwesomeIcons.gamepad,
    'dog': FontAwesomeIcons.dog,
    'cat': FontAwesomeIcons.cat,
    'book': FontAwesomeIcons.book,
    'music': FontAwesomeIcons.music,
    'film': FontAwesomeIcons.film,
    'paintbrush': FontAwesomeIcons.paintbrush,
    'camera': FontAwesomeIcons.camera,
    'question': FontAwesomeIcons.question,
  };

  static IconData getIcon(String iconName) {
    return _iconMap[iconName] ?? FontAwesomeIcons.question;
  }

  static String getIconName(IconData icon) {
    return _iconMap.entries
        .firstWhere((entry) => entry.value == icon,
            orElse: () => MapEntry('question', FontAwesomeIcons.question))
        .key;
  }

  static List<MapEntry<String, IconData>> getAllIcons() {
    return _iconMap.entries.toList();
  }
}
