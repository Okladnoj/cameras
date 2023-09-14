#ifndef FLUTTER_PLUGIN_CAMERAS_PLUGIN_H_
#define FLUTTER_PLUGIN_CAMERAS_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace cameras {

class CamerasPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  CamerasPlugin();

  virtual ~CamerasPlugin();

  // Disallow copy and assign.
  CamerasPlugin(const CamerasPlugin&) = delete;
  CamerasPlugin& operator=(const CamerasPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace cameras

#endif  // FLUTTER_PLUGIN_CAMERAS_PLUGIN_H_
