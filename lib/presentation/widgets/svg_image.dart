import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as flutter_svg;
import 'package:vector_graphics/vector_graphics.dart';

class SvgImage extends StatelessWidget {
  final String assetName;
  final Color? color;
  final double? width;
  final double? height;

  const SvgImage({
    super.key,
    required this.assetName,
    this.color,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return flutter_svg.SvgPicture(
      AssetBytesLoader(assetName),
      colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      width: width,
      height: height,
    );
  }
}
