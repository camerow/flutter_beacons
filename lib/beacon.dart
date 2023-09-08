import 'package:flutter/widgets.dart';
import 'beacons.g.dart';

enum BeaconSymbolType {
  Crypto,
  Exchange,
  Currency,
  Equity,
}

const Map<BeaconSymbolType, String> _symbolTypeToPrefix = {
  BeaconSymbolType.Crypto: 'sym',
  BeaconSymbolType.Exchange: 'exc',
  BeaconSymbolType.Currency: 'cur',
  BeaconSymbolType.Equity: 'eqt',
};

/// A simple extension class on [Icon] that maps a [String] from the Cryptowatch
/// API and returns an Icon.
///
/// Accepts all the same named arguments as [Icon].
class Beacon extends Icon {
  /// Optional Flutter key.
  final Key? key;

  /// Override default [Icon] color.
  final Color? color;

  /// Override default `size` of `16`.
  final double? size;

  /// Semantic label as per [Icon].
  final String? semanticLabel;

  /// [TextDirection] override as per [Icon]
  final TextDirection textDirection;

  /// A check for the existence of an actual [Beacon] rather than the
  /// default fallback.
  ///
  /// Beacons always have something to render, this checks
  /// whether or not there is a [Beacon] for the name specifically and not a
  /// default.
  static bool exists({
    required String name,
    BeaconSymbolType symbolType = BeaconSymbolType.Crypto,
    bool symbol = true,
  }) {
    return Beacons.icons.containsKey(
        '${_symbolTypeToPrefix[symbolType]}-${name.toLowerCase()}${symbol ? '-s' : ''}');
  }

  /// Creates a Cryptowatch Beacon icon using a [String] symobl representing
  /// one of:
  /// a. A cryptocurrency (eg. `btc`, `eth`, `doge`),
  /// b. An exchange (eg. `kraken`, `binance`),
  /// c. A currency (eg. `usd`, `jpy`, `euro`).
  Beacon(
    /// A string representing a crypto/exchange/currency. See [Beacons] `icons` map
    /// for options. Optionally you can reference any of the static properties in
    /// [Beacons] and pass that to [Icon] eg `Icon(Beacons.sym_btc)`
    String name, {
    this.key,
    this.color,
    bool symbol = true,
    this.size,
    this.semanticLabel,
    this.textDirection = TextDirection.ltr,
    BeaconSymbolType symbolType = BeaconSymbolType.Crypto,
  }) : super(
          Beacons.icons.containsKey(
                  '${_symbolTypeToPrefix[symbolType]}-${name.toLowerCase()}${symbol ? '-s' : ''}')
              ? Beacons.icons[
                  '${_symbolTypeToPrefix[symbolType]}-${name.toLowerCase()}${symbol ? '-s' : ''}']
              : symbol
                  ? Beacons.sym_default
                  : Beacons.sym_default_s,
          key: key,
          size: size,
          color: color,
          semanticLabel: semanticLabel,
          textDirection: textDirection,
        );

  /// Creates a Cryptowatch `Beacon` symobl representing
  /// a cryptocurrency (eg. `btc`, `eth`, `doge`).
  Beacon.crypto(
    /// A string representing a crypto. See [Beacons] `icons` map
    /// for options. Cryptos are represented under `sym-{slug}` and `sym-{slug}-s`.
    String name, {
    this.key,
    this.color,
    bool symbol = true,
    this.size,
    this.semanticLabel,
    this.textDirection = TextDirection.ltr,
  }) : super(
          Beacons.icons.containsKey(
                  '${_symbolTypeToPrefix[BeaconSymbolType.Crypto]}-${name.toLowerCase()}${symbol ? '-s' : ''}')
              ? Beacons.icons[
                  '${_symbolTypeToPrefix[BeaconSymbolType.Crypto]}-${name.toLowerCase()}${symbol ? '-s' : ''}']
              : symbol
                  ? Beacons.sym_default
                  : Beacons.sym_default_s,
          key: key,
          size: size,
          color: color,
          semanticLabel: semanticLabel,
          textDirection: textDirection,
        );

  /// A [Beacon] constructor to show supported currency symbols (eg. `usd`, `aud`, `jpy`)
  /// that will fallback to the default `currency` icon.
  Beacon.currency(
    String name, {
    this.key,
    this.color,
    bool symbol = true,
    this.size,
    this.semanticLabel,
    this.textDirection = TextDirection.ltr,
  }) : super(
          Beacons.icons.containsKey(
                  '${_symbolTypeToPrefix[BeaconSymbolType.Currency]}-${name.toLowerCase()}${symbol ? '-s' : ''}')
              ? Beacons.icons[
                  '${_symbolTypeToPrefix[BeaconSymbolType.Currency]}-${name.toLowerCase()}${symbol ? '-s' : ''}']
              : symbol
                  ? Beacons.cur_default
                  : Beacons.cur_default_s,
          key: key,
          size: size,
          color: color,
          semanticLabel: semanticLabel,
          textDirection: textDirection,
        );

  /// A [Beacon] constructor to show exchange symbols (eg. `kraken`, `ftx`, `coinbasepro`)
  ///  that will fallback to the default `exchange` icon.
  Beacon.exchange(
    String name, {
    this.key,
    this.color,
    bool symbol = true,
    this.size,
    this.semanticLabel,
    this.textDirection = TextDirection.ltr,
  }) : super(
          Beacons.icons.containsKey(
                  '${_symbolTypeToPrefix[BeaconSymbolType.Exchange]}-${name.toLowerCase()}${symbol ? '-s' : ''}')
              ? Beacons.icons[
                  '${_symbolTypeToPrefix[BeaconSymbolType.Exchange]}-${name.toLowerCase()}${symbol ? '-s' : ''}']
              : symbol
                  ? Beacons.exc_default
                  : Beacons.exc_default_s,
          key: key,
          size: size,
          color: color,
          semanticLabel: semanticLabel,
          textDirection: textDirection,
        );

  /// Creates a Cryptowatch `Beacon` symobl representing
  /// a cryptocurrency (eg. `btc`, `eth`, `doge`).
  Beacon.equity(
    /// A string representing a crypto. See [Beacons] `icons` map
    /// for options. Cryptos are represented under `sym-{slug}` and `sym-{slug}-s`.
    String name, {
    this.key,
    this.color,
    bool symbol = true,
    this.size,
    this.semanticLabel,
    this.textDirection = TextDirection.ltr,
  }) : super(
          Beacons.icons.containsKey(
                  '${_symbolTypeToPrefix[BeaconSymbolType.Equity]}-${name.toLowerCase()}${symbol ? '-s' : ''}')
              ? Beacons.icons[
                  '${_symbolTypeToPrefix[BeaconSymbolType.Equity]}-${name.toLowerCase()}${symbol ? '-s' : ''}']
              : symbol
                  ? Beacons.sym_default
                  : Beacons.sym_default_s,
          key: key,
          size: size,
          color: color,
          semanticLabel: semanticLabel,
          textDirection: textDirection,
        );

  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);

    double iconSize = size ?? iconTheme.size ?? 16;

    return Icon(
      icon,
      size: iconSize,
      color: color ?? iconTheme.color,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
    );
  }
}
