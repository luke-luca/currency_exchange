// ignore_for_file: constant_identifier_names

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
