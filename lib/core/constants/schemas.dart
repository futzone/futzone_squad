import 'dart:ui';

class Schemas {
  final Map<String, Map<String, List<int>>> schemas = {
    "4": {
      // 1 GK + 3
      "1-2": [1, 2],
      "2-1": [2, 1],
      "3": [3],
    },
    "5": {
      // 1 GK + 4
      "2-2": [2, 2],
      "1-3": [1, 3],
      "3-1": [3, 1],
      "1-1-2": [1, 1, 2],
      "2-1-1": [2, 1, 1],
    },
    "6": {
      // 1 GK + 5
      "2-3": [2, 3],
      "3-2": [3, 2],
      "1-2-2": [1, 2, 2],
      "2-1-2": [2, 1, 2],
      "1-4": [1, 4],
      "4-1": [4, 1],
    },
    "7": {
      // 1 GK + 6
      "3-3": [3, 3],
      "2-2-2": [2, 2, 2],
      "2-3-1": [2, 3, 1],
      "3-2-1": [3, 2, 1],
      "1-3-2": [1, 3, 2],
      "2-1-3": [2, 1, 3],
    },
    "8": {
      // 1 GK + 7
      "3-4": [3, 4],
      "4-3": [4, 3],
      "2-3-2": [2, 3, 2],
      "3-2-2": [3, 2, 2],
      "2-4-1": [2, 4, 1],
      "1-3-3": [1, 3, 3],
    },
    "9": {
      // 1 GK + 8
      "4-4": [4, 4],
      "3-3-2": [3, 3, 2],
      "3-4-1": [3, 4, 1],
      "2-4-2": [2, 4, 2],
      "4-3-1": [4, 3, 1],
      "2-3-3": [2, 3, 3],
      "1-4-3": [1, 4, 3],
      "3-2-3": [3, 2, 3],
    },
    "10": {
      // 1 GK + 9
      "4-4-1": [4, 4, 1],
      "3-4-2": [3, 4, 2],
      "4-3-2": [4, 3, 2],
      "2-4-3": [2, 4, 3],
      "3-3-3": [3, 3, 3],
      "1-4-4": [1, 4, 4],
      "2-3-4": [2, 3, 4],
      "4-2-3": [4, 2, 3],
    },
    "11": {
      // 1 GK + 10
      "4-4-2": [4, 4, 2],
      "4-3-3": [4, 3, 3],
      "3-5-2": [3, 5, 2],
      "3-4-3": [3, 4, 3],
      "5-3-2": [5, 3, 2],
      "4-5-1": [4, 5, 1],
      "5-4-1": [5, 4, 1],
      "4-2-3-1": [4, 2, 3, 1],
      "4-2-4": [4, 2, 4],
      "4-1-5": [4, 1, 5],
      "3-2-5": [3, 2, 5],
      "5-5": [5, 5],
      // "1-2-7": [1, 2, 7],
      // "2-2-6": [2, 2, 6],
    },
  };

  Map<String, List<int>> getSchemas(String count) {
    return schemas[count] ?? {};
  }

  List<Offset> generateOffsets(String count, String schema, double width, double height) {
    final List<int> formation = getSchemas(count)[schema] ?? [];
    if (formation.isEmpty) return [];

    List<Offset> offsets = [];
    double rowHeight = height / (formation.length + 1);

    const double playerWidth = 80;
    const double spaceBetween = 10;

    for (int i = 0; i < formation.length; i++) {
      int playersInRow = formation[i];
      double y = height - rowHeight * (i + 1);

      double totalRowWidth = playersInRow * playerWidth + (playersInRow - 1) * (playersInRow > 4 ? 0 : spaceBetween);
      double startX = (width - totalRowWidth) / 2;

      for (int j = 0; j < playersInRow; j++) {
        double x = startX + j * (playerWidth + (playersInRow > 4 ? 0 : spaceBetween));
        offsets.add(Offset(x, y - 60));
      }
    }

    return offsets;
  }
}
