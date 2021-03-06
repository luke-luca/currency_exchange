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
        return 'πΊπΈ';
      case Currency.EUR:
        return 'πͺπΊ';
      case Currency.GBP:
        return 'π¬π§';
      case Currency.AUD:
        return 'π¦πΊ';
      case Currency.CAD:
        return 'π¨π¦';
      case Currency.CHF:
        return 'π¨π­';
      case Currency.CNY:
        return 'π¨π³';
      case Currency.DKK:
        return 'π©π°';
      case Currency.JPY:
        return 'π―π΅';
      case Currency.RUB:
        return 'π·πΊ';
      case Currency.PLN:
        return 'π΅π±';
    }
  }
}

extension CurrencySymbols on Currency {
  String get symbol {
    switch (this) {
      case Currency.USD:
        return '\$';
      case Currency.EUR:
        return 'β¬';
      case Currency.GBP:
        return 'Β£';
      case Currency.AUD:
        return 'A\$';
      case Currency.CAD:
        return 'C\$';
      case Currency.CHF:
        return 'Fr';
      case Currency.CNY:
        return 'Β₯';
      case Currency.DKK:
        return 'kr';
      case Currency.JPY:
        return 'Β₯';
      case Currency.RUB:
        return 'β½';
      case Currency.PLN:
        return 'zΕ';
    }
  }
}
