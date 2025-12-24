// Platform-aware tracking service.
//
// Uses conditional imports to load web-specific implementation
// on web platform and stub on other platforms.
export 'tracking_stub.dart'
    if (dart.library.js_interop) 'tracking_web.dart';
