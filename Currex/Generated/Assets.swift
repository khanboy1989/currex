// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal enum Colors {
    internal static let black = ColorAsset(name: "black")
    internal static let lightGray = ColorAsset(name: "lightGray")
    internal static let white = ColorAsset(name: "white")
  }
  internal enum Images {
    internal static let aud = ImageAsset(name: "AUD")
    internal static let bgn = ImageAsset(name: "BGN")
    internal static let brl = ImageAsset(name: "BRL")
    internal static let cad = ImageAsset(name: "CAD")
    internal static let chf = ImageAsset(name: "CHF")
    internal static let cny = ImageAsset(name: "CNY")
    internal static let czk = ImageAsset(name: "CZK")
    internal static let dkk = ImageAsset(name: "DKK")
    internal static let eur = ImageAsset(name: "EUR")
    internal static let gbp = ImageAsset(name: "GBP")
    internal static let hkd = ImageAsset(name: "HKD")
    internal static let hrk = ImageAsset(name: "HRK")
    internal static let huf = ImageAsset(name: "HUF")
    internal static let idr = ImageAsset(name: "IDR")
    internal static let ils = ImageAsset(name: "ILS")
    internal static let inr = ImageAsset(name: "INR")
    internal static let isk = ImageAsset(name: "ISK")
    internal static let jpy = ImageAsset(name: "JPY")
    internal static let krw = ImageAsset(name: "KRW")
    internal static let mxn = ImageAsset(name: "MXN")
    internal static let myr = ImageAsset(name: "MYR")
    internal static let nok = ImageAsset(name: "NOK")
    internal static let nzd = ImageAsset(name: "NZD")
    internal static let php = ImageAsset(name: "PHP")
    internal static let pln = ImageAsset(name: "PLN")
    internal static let ron = ImageAsset(name: "RON")
    internal static let rub = ImageAsset(name: "RUB")
    internal static let sek = ImageAsset(name: "SEK")
    internal static let sgd = ImageAsset(name: "SGD")
    internal static let thb = ImageAsset(name: "THB")
    internal static let `try` = ImageAsset(name: "TRY")
    internal static let usd = ImageAsset(name: "USD")
    internal static let zar = ImageAsset(name: "ZAR")
    internal static let `switch` = ImageAsset(name: "switch")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
}

internal extension ImageAsset.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    Bundle(for: BundleToken.self)
  }()
}
// swiftlint:enable convenience_type
