import 'package:flutter_test/flutter_test.dart';
import 'package:samarretes/calculadora_samarretes.dart';

void main() {
  late CalculadoraSamarretes calc;

  setUp(() {
    calc = CalculadoraSamarretes();
  });

  // ===================================================================
  // calculaPreuSamarretes
  // ===================================================================
  group('calculaPreuSamarretes', () {
    test('1 samarreta petita = 7.99€', () {
      expect(calc.calculaPreuSamarretes(1, ShirtSize.small), closeTo(7.99, 0.01));
    });

    test('1 samarreta mitjana = 9.95€', () {
      expect(calc.calculaPreuSamarretes(1, ShirtSize.medium), closeTo(9.95, 0.01));
    });

    test('1 samarreta gran = 13.50€', () {
      expect(calc.calculaPreuSamarretes(1, ShirtSize.large), closeTo(13.50, 0.01));
    });

    test('10 samarretes petites = 79.90€', () {
      expect(calc.calculaPreuSamarretes(10, ShirtSize.small), closeTo(79.90, 0.01));
    });

    test('5 samarretes mitjanes = 49.75€', () {
      expect(calc.calculaPreuSamarretes(5, ShirtSize.medium), closeTo(49.75, 0.01));
    });

    test('10 samarretes grans = 135.00€', () {
      expect(calc.calculaPreuSamarretes(10, ShirtSize.large), closeTo(135.00, 0.01));
    });

    test('0 samarretes = 0.00€', () {
      expect(calc.calculaPreuSamarretes(0, ShirtSize.small), 0.0);
    });

    test('nombre negatiu = 0.00€', () {
      expect(calc.calculaPreuSamarretes(-5, ShirtSize.large), 0.0);
    });
  });

  // ===================================================================
  // calculaDescompte
  // ===================================================================
  group('calculaDescompte', () {
    test('sense descompte retorna 0', () {
      expect(calc.calculaDescompte(100.0, DiscountType.none), 0.0);
    });

    test('10% de 100€ = 10€', () {
      expect(calc.calculaDescompte(100.0, DiscountType.tenPercent), closeTo(10.0, 0.01));
    });

    test('10% de 79.90€ = 7.99€', () {
      expect(calc.calculaDescompte(79.90, DiscountType.tenPercent), closeTo(7.99, 0.01));
    });

    test('20€ descompte si preu > 100€ (150€ → 20€)', () {
      expect(calc.calculaDescompte(150.0, DiscountType.twentyEurosOver100), 20.0);
    });

    test('20€ descompte NO aplica si preu < 100€ (80€ → 0€)', () {
      expect(calc.calculaDescompte(80.0, DiscountType.twentyEurosOver100), 0.0);
    });

    test('20€ descompte NO aplica si preu = 100€ exactes', () {
      expect(calc.calculaDescompte(100.0, DiscountType.twentyEurosOver100), 0.0);
    });

    test('20€ descompte aplica si preu = 100.01€', () {
      expect(calc.calculaDescompte(100.01, DiscountType.twentyEurosOver100), 20.0);
    });

    test('preu 0 retorna 0 sempre', () {
      expect(calc.calculaDescompte(0, DiscountType.tenPercent), 0.0);
    });
  });

  // ===================================================================
  // preuDefinitiu
  // ===================================================================
  group('preuDefinitiu', () {
    test('10 grans sense descompte = 135.00€', () {
      expect(calc.preuDefinitiu(10, ShirtSize.large, DiscountType.none), closeTo(135.00, 0.01));
    });

    test('10 grans amb 10% = 121.50€', () {
      expect(calc.preuDefinitiu(10, ShirtSize.large, DiscountType.tenPercent), closeTo(121.50, 0.01));
    });

    test('10 grans amb 20€ (>100€) = 115.00€', () {
      expect(calc.preuDefinitiu(10, ShirtSize.large, DiscountType.twentyEurosOver100), closeTo(115.00, 0.01));
    });

    test('5 petites amb 20€ (<100€) = 39.95€ sense descompte', () {
      expect(calc.preuDefinitiu(5, ShirtSize.small, DiscountType.twentyEurosOver100), closeTo(39.95, 0.01));
    });

    test('1 mitjana amb 10% = 8.955€', () {
      expect(calc.preuDefinitiu(1, ShirtSize.medium, DiscountType.tenPercent), closeTo(8.955, 0.01));
    });

    test('0 samarretes = 0€ independentment del descompte', () {
      expect(calc.preuDefinitiu(0, ShirtSize.large, DiscountType.tenPercent), 0.0);
    });
  });
}
