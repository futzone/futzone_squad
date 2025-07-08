import 'package:flutter/material.dart';

enum DeviceType { mobile, tablet, desktop }

DeviceType getDeviceType(BuildContext context) {
  final double width = MediaQuery.of(context).size.width;

  if (width >= 1200) {
    return DeviceType.desktop;
  } else if (width >= 600) {
    return DeviceType.tablet;
  } else {
    return DeviceType.mobile;
  }
}

extension DeviceTypeGetter on BuildContext {
  DeviceType _deviceType() => getDeviceType(this);

  bool get isTablet => _deviceType() == DeviceType.tablet;

  bool get isMobile => _deviceType() == DeviceType.mobile;

  bool get isDesktop => _deviceType() == DeviceType.desktop;
}
