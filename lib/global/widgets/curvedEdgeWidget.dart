

import 'package:ecommerce_app_client/Core/View/homeScreen/Widget/headerScreen/customCurved.dart';
import 'package:flutter/material.dart';

class CurvedEdgeWidget extends StatelessWidget {
  const CurvedEdgeWidget({
    super.key, required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: Customcurved(),
      child: child
    );
  }
}
