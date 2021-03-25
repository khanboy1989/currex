// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Plist Files

// swiftlint:disable identifier_name line_length type_body_length
internal enum PlistFiles {
  private static let _document = PlistDocument(path: "Info.plist")

  internal static let apiBaseURL: String = _document["ApiBaseURL"]
  internal static let cfBundleDevelopmentRegion: String = _document["CFBundleDevelopmentRegion"]
  internal static let cfBundleExecutable: String = _document["CFBundleExecutable"]
  internal static let cfBundleIdentifier: String = _document["CFBundleIdentifier"]
  internal static let cfBundleInfoDictionaryVersion: String = _document["CFBundleInfoDictionaryVersion"]
  internal static let cfBundleName: String = _document["CFBundleName"]
  internal static let cfBundlePackageType: String = _document["CFBundlePackageType"]
  internal static let cfBundleShortVersionString: String = _document["CFBundleShortVersionString"]
  internal static let cfBundleVersion: String = _document["CFBundleVersion"]
  internal static let lsRequiresIPhoneOS: Bool = _document["LSRequiresIPhoneOS"]
  internal static let uiApplicationSceneManifest: [String: Any] = _document["UIApplicationSceneManifest"]
  internal static let uiApplicationSupportsIndirectInputEvents: Bool = _document["UIApplicationSupportsIndirectInputEvents"]
  internal static let uiLaunchStoryboardName: String = _document["UILaunchStoryboardName"]
  internal static let uiRequiredDeviceCapabilities: [String] = _document["UIRequiredDeviceCapabilities"]
  internal static let uiStatusBarStyle: String = _document["UIStatusBarStyle"]
  internal static let uiSupportedInterfaceOrientations: [String] = _document["UISupportedInterfaceOrientations"]
  internal static let uiSupportedInterfaceOrientationsIpad: [String] = _document["UISupportedInterfaceOrientations~ipad"]
  internal static let uiViewControllerBasedStatusBarAppearance: Bool = _document["UIViewControllerBasedStatusBarAppearance"]
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

private func arrayFromPlist<T>(at path: String) -> [T] {
  let bundle = BundleToken.bundle
  guard let url = bundle.url(forResource: path, withExtension: nil),
    let data = NSArray(contentsOf: url) as? [T] else {
    fatalError("Unable to load PLIST at path: \(path)")
  }
  return data
}

private struct PlistDocument {
  let data: [String: Any]

  init(path: String) {
    let bundle = BundleToken.bundle
    guard let url = bundle.url(forResource: path, withExtension: nil),
      let data = NSDictionary(contentsOf: url) as? [String: Any] else {
        fatalError("Unable to load PLIST at path: \(path)")
    }
    self.data = data
  }

  subscript<T>(key: String) -> T {
    guard let result = data[key] as? T else {
      fatalError("Property '\(key)' is not of type \(T.self)")
    }
    return result
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    Bundle(for: BundleToken.self)
  }()
}
// swiftlint:enable convenience_type
