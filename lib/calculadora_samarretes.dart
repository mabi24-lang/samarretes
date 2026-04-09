/// Model de la calculadora de samarretes.
/// Conté la lògica de negoci per calcular preus i descomptes.

enum ShirtSize { small, medium, large }

enum DiscountType { none, tenPercent, twentyEurosOver100 }

class CalculadoraSamarretes {
  static const Map<ShirtSize, double> preus = {
    ShirtSize.small: 7.99,
    ShirtSize.medium: 9.95,
    ShirtSize.large: 13.50,
  };

  /// Calcula el preu total sense descomptes.
  double calculaPreuSamarretes(int numero, ShirtSize talla) {
    if (numero <= 0) return 0;
    return numero * preus[talla]!;
  }

  /// Calcula l'import del descompte a restar.
  double calculaDescompte(double preu, DiscountType tipusDescompte) {
    if (preu <= 0) return 0;
    switch (tipusDescompte) {
      case DiscountType.none:
        return 0;
      case DiscountType.tenPercent:
        return preu * 0.10;
      case DiscountType.twentyEurosOver100:
        return preu > 100 ? 20.0 : 0.0;
    }
  }

  /// Calcula el preu definitiu aplicant el descompte.
  double preuDefinitiu(int numero, ShirtSize talla, DiscountType descompte) {
    final preu = calculaPreuSamarretes(numero, talla);
    final desc = calculaDescompte(preu, descompte);
    return preu - desc;
  }
}