// ignore_for_file: constant_identifier_names
//Class of currency to retrive data
enum Currency {
  USD,
  EUR,
  GBP,
  AUD,
  CAD,
  CHF,
  CNY,
  DKK,
  JPY,
  RUB,
  PLN,
}

extension Flags on Currency {
  String get flag {
    switch (this) {
      case Currency.USD:
        return '🇺🇸';
      case Currency.EUR:
        return '🇪🇺';
      case Currency.GBP:
        return '🇬🇧';
      case Currency.AUD:
        return '🇦🇺';
      case Currency.CAD:
        return '🇨🇦';
      case Currency.CHF:
        return '🇨🇭';
      case Currency.CNY:
        return '🇨🇳';
      case Currency.DKK:
        return '🇩🇰';
      case Currency.JPY:
        return '🇯🇵';
      case Currency.RUB:
        return '🇷🇺';
      case Currency.PLN:
        return '🇵🇱';
    }
  }
}

extension CurrencySymbols on Currency {
  String get symbol {
    switch (this) {
      case Currency.USD:
        return '\$';
      case Currency.EUR:
        return '€';
      case Currency.GBP:
        return '£';
      case Currency.AUD:
        return 'A\$';
      case Currency.CAD:
        return 'C\$';
      case Currency.CHF:
        return 'Fr';
      case Currency.CNY:
        return '¥';
      case Currency.DKK:
        return 'kr';
      case Currency.JPY:
        return '¥';
      case Currency.RUB:
        return '₽';
      case Currency.PLN:
        return 'zł';
    }
  }
}
