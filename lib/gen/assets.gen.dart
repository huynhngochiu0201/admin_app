/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/add-image-photo-icon.svg
  String get addImagePhotoIcon => 'assets/icons/add-image-photo-icon.svg';

  /// File path: assets/icons/add-video.svg
  String get addVideo => 'assets/icons/add-video.svg';

  /// File path: assets/icons/affiliate-marketing-icon.svg
  String get affiliateMarketingIcon =>
      'assets/icons/affiliate-marketing-icon.svg';

  /// File path: assets/icons/box-package-icon.svg
  String get boxPackageIcon => 'assets/icons/box-package-icon.svg';

  /// File path: assets/icons/delete.svg
  String get delete => 'assets/icons/delete.svg';

  /// File path: assets/icons/ic_back.svg
  String get icBack => 'assets/icons/ic_back.svg';

  /// File path: assets/icons/menu_vector.svg
  String get menuVector => 'assets/icons/menu_vector.svg';

  /// File path: assets/icons/menu_vector_border.svg
  String get menuVectorBorder => 'assets/icons/menu_vector_border.svg';

  /// File path: assets/icons/noun-add-product-6282309.svg
  String get nounAddProduct6282309 =>
      'assets/icons/noun-add-product-6282309.svg';

  /// File path: assets/icons/package-add-icon.svg
  String get packageAddIcon => 'assets/icons/package-add-icon.svg';

  /// File path: assets/icons/receipt-us-dollar-icon.svg
  String get receiptUsDollarIcon => 'assets/icons/receipt-us-dollar-icon.svg';

  /// File path: assets/icons/search.svg
  String get search => 'assets/icons/search.svg';

  /// File path: assets/icons/services-icon.svg
  String get servicesIcon => 'assets/icons/services-icon.svg';

  /// File path: assets/icons/store-15.svg
  String get store15 => 'assets/icons/store-15.svg';

  /// File path: assets/icons/text-document-add-icon.svg
  String get textDocumentAddIcon => 'assets/icons/text-document-add-icon.svg';

  /// List of all assets
  List<String> get values => [
        addImagePhotoIcon,
        addVideo,
        affiliateMarketingIcon,
        boxPackageIcon,
        delete,
        icBack,
        menuVector,
        menuVectorBorder,
        nounAddProduct6282309,
        packageAddIcon,
        receiptUsDollarIcon,
        search,
        servicesIcon,
        store15,
        textDocumentAddIcon
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/Autocarlogo.png
  AssetGenImage get autocarlogo =>
      const AssetGenImage('assets/images/Autocarlogo.png');

  /// File path: assets/images/auto_1.jpeg
  AssetGenImage get auto1 => const AssetGenImage('assets/images/auto_1.jpeg');

  /// File path: assets/images/auto_2.jpeg
  AssetGenImage get auto2 => const AssetGenImage('assets/images/auto_2.jpeg');

  /// File path: assets/images/auto_3.jpeg
  AssetGenImage get auto3 => const AssetGenImage('assets/images/auto_3.jpeg');

  /// File path: assets/images/auto_4.jpeg
  AssetGenImage get auto4 => const AssetGenImage('assets/images/auto_4.jpeg');

  /// File path: assets/images/auto_5.jpeg
  AssetGenImage get auto5 => const AssetGenImage('assets/images/auto_5.jpeg');

  /// File path: assets/images/background.jpg
  AssetGenImage get background =>
      const AssetGenImage('assets/images/background.jpg');

  /// File path: assets/images/backgrounddone.png
  AssetGenImage get backgrounddone =>
      const AssetGenImage('assets/images/backgrounddone.png');

  /// File path: assets/images/carrescue1.png
  AssetGenImage get carrescue1 =>
      const AssetGenImage('assets/images/carrescue1.png');

  /// File path: assets/images/carrescue10.png
  AssetGenImage get carrescue10 =>
      const AssetGenImage('assets/images/carrescue10.png');

  /// File path: assets/images/carrescue2.png
  AssetGenImage get carrescue2 =>
      const AssetGenImage('assets/images/carrescue2.png');

  /// File path: assets/images/carrescue8.png
  AssetGenImage get carrescue8 =>
      const AssetGenImage('assets/images/carrescue8.png');

  /// File path: assets/images/carrescue9.png
  AssetGenImage get carrescue9 =>
      const AssetGenImage('assets/images/carrescue9.png');

  /// File path: assets/images/chungaotu.jpg
  AssetGenImage get chungaotu =>
      const AssetGenImage('assets/images/chungaotu.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [
        autocarlogo,
        auto1,
        auto2,
        auto3,
        auto4,
        auto5,
        background,
        backgrounddone,
        carrescue1,
        carrescue10,
        carrescue2,
        carrescue8,
        carrescue9,
        chungaotu
      ];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

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
