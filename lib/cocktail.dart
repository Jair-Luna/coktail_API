class Cocktail {
  final String strDrink;
  final String strDrinkThumb;

  Cocktail({required this.strDrink, required this.strDrinkThumb});

  factory Cocktail.fromJson(Map<String, dynamic> json) {
    return Cocktail(
      strDrink: json['strDrink'],
      strDrinkThumb: json['strDrinkThumb'],
    );
  }
}
