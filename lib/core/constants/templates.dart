import 'package:flutter/material.dart';

class Template {
  final String path;
  final Color color;

  Template({required this.path, required this.color});

  static List<Template> values = [
    Template(path: 'assets/images/0_bronze.png', color: Colors.black),
    Template(path: 'assets/images/0_silver.png', color: Colors.black),
    Template(path: 'assets/images/1_bronze.png', color: Colors.black),
    Template(path: 'assets/images/1_silver.png', color: Colors.black),
    Template(path: 'assets/images/11_team_of_the_season.png', color: Colors.white),
    Template(path: 'assets/images/75_shapeshifters.png', color: Colors.white),
    Template(path: 'assets/images/77_shapeshifter_hero.png', color: Colors.white),
    Template(path: 'assets/images/127_tots_champions.png', color: Colors.white),
    Template(path: 'assets/images/144_fut_immortals_icon.png', color: Colors.black),
    Template(path: 'assets/images/145_fut_immortals_hero.png', color: Colors.white),
    Template(path: 'assets/images/178_tots_evo_2.png', color: Colors.white),
    Template(path: 'assets/images/1111_prime_hero.png', color: Colors.white),
  ];
}
