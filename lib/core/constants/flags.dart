import 'package:icons_plus/icons_plus.dart';

class FlagsDatabase {
  List<Map<String, String>> all = [
    {Flags.uzbekistan: "Oʻzbekiston"},
    {Flags.kazakhstan: "Qozogʻiston"},
    {Flags.portugal: "Portugaliya"},
    {Flags.chile: "Chili"},
    {Flags.china: "Xitoy"},
    {Flags.uruguay: "Urugvay"},
    {Flags.united_states_of_america: "Amerika Qoʻshma Shtatlari"},
    {Flags.england: "Angliya"},
    {Flags.germany: "Germaniya"},
    {Flags.spain: "Ispaniya"},
    {Flags.morocco: "Marokash"},
    {Flags.niger: "Niger"},
    {Flags.african: "Afrika"},
  ];

  String getName(path) {
    final country = all.where((el) => el.keys.firstOrNull == path);
    return country.firstOrNull?.values.firstOrNull ?? '';
  }
}
