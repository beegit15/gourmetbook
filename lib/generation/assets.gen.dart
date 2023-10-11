/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/chat.svg
  SvgGenImage get chat => const SvgGenImage('assets/icons/chat.svg');

  /// File path: assets/icons/facebook.svg
  SvgGenImage get facebook => const SvgGenImage('assets/icons/facebook.svg');

  /// File path: assets/icons/google-plus.svg
  SvgGenImage get googlePlus =>
      const SvgGenImage('assets/icons/google-plus.svg');

  /// File path: assets/icons/login.svg
  SvgGenImage get login => const SvgGenImage('assets/icons/login.svg');

  /// File path: assets/icons/signup.svg
  SvgGenImage get signup => const SvgGenImage('assets/icons/signup.svg');

  /// File path: assets/icons/twitter.svg
  SvgGenImage get twitter => const SvgGenImage('assets/icons/twitter.svg');

  /// List of all assets
  List<SvgGenImage> get values =>
      [chat, facebook, googlePlus, login, signup, twitter];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/app_logo.png
  AssetGenImage get appLogo =>
      const AssetGenImage('assets/images/app_logo.png');

  /// File path: assets/images/cart.png
  AssetGenImage get cart => const AssetGenImage('assets/images/cart.png');

  /// File path: assets/images/delivery.png
  AssetGenImage get delivery =>
      const AssetGenImage('assets/images/delivery.png');

  /// File path: assets/images/login_bottom.png
  AssetGenImage get loginBottom =>
      const AssetGenImage('assets/images/login_bottom.png');

  /// File path: assets/images/main_bottom.png
  AssetGenImage get mainBottom =>
      const AssetGenImage('assets/images/main_bottom.png');

  /// File path: assets/images/main_top.png
  AssetGenImage get mainTop =>
      const AssetGenImage('assets/images/main_top.png');

  /// File path: assets/images/product.png
  AssetGenImage get product => const AssetGenImage('assets/images/product.png');

  /// File path: assets/images/rupee.png
  AssetGenImage get rupee => const AssetGenImage('assets/images/rupee.png');

  /// File path: assets/images/signup_top.png
  AssetGenImage get signupTop =>
      const AssetGenImage('assets/images/signup_top.png');

  /// File path: assets/images/store.png
  AssetGenImage get store => const AssetGenImage('assets/images/store.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        appLogo,
        cart,
        delivery,
        loginBottom,
        mainBottom,
        mainTop,
        product,
        rupee,
        signupTop,
        store
      ];
}

class $AssetsLangGen {
  const $AssetsLangGen();

  /// File path: assets/lang/en-US.json
  String get enUS => 'assets/lang/en-US.json';

  /// File path: assets/lang/tr-TR.json
  String get trTR => 'assets/lang/tr-TR.json';

  /// List of all assets
  List<String> get values => [enUS, trTR];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/ic_airbnb.svg
  SvgGenImage get icAirbnb => const SvgGenImage('assets/svg/ic_airbnb.svg');

  /// File path: assets/svg/ic_fav.svg
  SvgGenImage get icFav => const SvgGenImage('assets/svg/ic_fav.svg');

  /// File path: assets/svg/ic_filter.svg
  SvgGenImage get icFilter => const SvgGenImage('assets/svg/ic_filter.svg');

  /// File path: assets/svg/ic_heart.svg
  SvgGenImage get icHeart => const SvgGenImage('assets/svg/ic_heart.svg');

  /// File path: assets/svg/ic_inbox.svg
  SvgGenImage get icInbox => const SvgGenImage('assets/svg/ic_inbox.svg');

  /// File path: assets/svg/ic_location.svg
  SvgGenImage get icLocation => const SvgGenImage('assets/svg/ic_location.svg');

  /// File path: assets/svg/ic_map.svg
  SvgGenImage get icMap => const SvgGenImage('assets/svg/ic_map.svg');

  /// File path: assets/svg/ic_profile.svg
  SvgGenImage get icProfile => const SvgGenImage('assets/svg/ic_profile.svg');

  /// File path: assets/svg/ic_search.svg
  SvgGenImage get icSearch => const SvgGenImage('assets/svg/ic_search.svg');

  /// File path: assets/svg/ic_settings.svg
  SvgGenImage get icSettings => const SvgGenImage('assets/svg/ic_settings.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        icAirbnb,
        icFav,
        icFilter,
        icHeart,
        icInbox,
        icLocation,
        icMap,
        icProfile,
        icSearch,
        icSettings
      ];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLangGen lang = $AssetsLangGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
