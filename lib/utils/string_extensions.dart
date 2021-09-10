extension StringExtension on String {
  //Method To Convert a String into Camel Case Form.
  String capitalize() {
    var c = '';
    var a = this.toLowerCase().split(' ');

    for (String b in a) {
      if (b.length > 1) {
        c = c + b.substring(0, 1).toUpperCase() + b.substring(1) + ' ';
      } else {
        c = c + b.substring(0).toUpperCase();
      }
    }
    return c;
  }

  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  /// check if the string contains only numbers
  bool isNumeric() {
    return RegExp(r'^-?[0-9]+$').hasMatch(this);
  }

  // String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
  // String get allInCaps => this.toUpperCase();
  // String get capitalizeFirstofEach =>
  //     this.split(" ").map((str) => str.inCaps).join(" ");
}
