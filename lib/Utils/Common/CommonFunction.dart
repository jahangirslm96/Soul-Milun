class CommonFunction{

    String getInteractionType(int type){
    switch(type){
      case 1:
        return "Your Likes";

      case 2:
        return "Passed";

      case 3:
        return "Blocked";

      case 4:
        return "Visited You";

      case 5:
        return "Favourite";

      case 6:
        return "Liked You";

      case 7:
        return "Visited You";
       
      default:
        return "";
    }
  }
    
    int getIndexOf(List<dynamic> arrayToSearch, dynamic element) {
      return arrayToSearch.indexOf(element);
    }

    String formatHeightRange(Map<String, dynamic> element) {
    // double min = element["min"]!;
    // double max = element["max"]!;
    // return '${_formatHeight(min)} - ${_formatHeight(max)}';
    String min = element["min"]!.toStringAsFixed(1).replaceAll(".", "'");
    String max = element["max"]!.toStringAsFixed(1).replaceAll(".", "'");
    return "$min - $max";
  }

  String formatHeight(double value) {
    int feet = value.floor();
    int inches = ((value - feet) * 12).toInt(); // Change rounding to toInt()

    // Handle carryover to feet if inches exceed 12
    if (inches >= 12) {
      feet += inches ~/ 12;
      inches %= 12;
    }

    return '$feet\'$inches';
  }
}