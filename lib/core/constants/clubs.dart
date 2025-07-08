import 'package:icons_plus/icons_plus.dart';

class ClubsDatabase {
  List<Map<String, String>> all = [
    {Brands.real_madrid: "Real Madrid"},
    {Brands.barcelona_fc: "Barcelona"},
    {Brands.manchester_united: "Manchester United"},
    {Brands.manchester_city_fc: "Manchester City"},
    {Brands.liverpool_fc: "Liverpool"},
    {Brands.arsenal_fc: "Arsenal"},
    {Brands.chelsea_fc: "Chelsea"},
    {Brands.galatasaray_sk: "Galatasaray"},
  ];


  String getName(path) {
    final country = all.where((el) => el.keys.firstOrNull == path);
    return country.firstOrNull?.values.firstOrNull ?? '';
  }
}
