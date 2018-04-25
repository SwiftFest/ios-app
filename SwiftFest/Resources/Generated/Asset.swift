// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSImage
  internal typealias AssetColorTypeAlias = NSColor
  internal typealias Image = NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  internal typealias AssetColorTypeAlias = UIColor
  internal typealias Image = UIImage
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

@available(*, deprecated, renamed: "ImageAsset")
internal typealias AssetType = ImageAsset

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  internal var image: Image {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else { fatalError("Unable to load image named \(name).") }
    return result
  }
}

internal struct ColorAsset {
  internal fileprivate(set) var name: String

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  internal var color: AssetColorTypeAlias {
    return AssetColorTypeAlias(asset: self)
  }
}

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal enum Colors {
    internal static let black = ColorAsset(name: "Black")
    internal static let darkOrange = ColorAsset(name: "DarkOrange")
    internal static let lightGray = ColorAsset(name: "LightGray")
    internal static let lightOrange = ColorAsset(name: "LightOrange")
  }
  internal enum Speakers {
    internal static let agnesVasarhelyi = ImageAsset(name: "AgnesVasarhelyi")
    internal static let alexBush = ImageAsset(name: "AlexBush")
    internal static let andresPineda = ImageAsset(name: "AndresPineda")
    internal static let andyyHope = ImageAsset(name: "AndyyHope")
    internal static let ayalSpitz = ImageAsset(name: "AyalSpitz")
    internal static let basBroek = ImageAsset(name: "BasBroek")
    internal static let craigClayton = ImageAsset(name: "CraigClayton")
    internal static let davidOhayon = ImageAsset(name: "DavidOhayon")
    internal static let ericaSadun = ImageAsset(name: "EricaSadun")
    internal static let garricNahapetian = ImageAsset(name: "GarricNahapetian")
    internal static let giorgioNatili = ImageAsset(name: "GiorgioNatili")
    internal static let harlanHaskins = ImageAsset(name: "HarlanHaskins")
    internal static let hungTruong = ImageAsset(name: "HungTruong")
    internal static let ishShabazz = ImageAsset(name: "IshShabazz")
    internal static let jeffKelley = ImageAsset(name: "JeffKelley")
    internal static let jeffOLeary = ImageAsset(name: "JeffOLeary")
    internal static let jonTaitBeason = ImageAsset(name: "Jon-TaitBeason")
    internal static let louFranco = ImageAsset(name: "LouFranco")
    internal static let lucyMonahan = ImageAsset(name: "LucyMonahan")
    internal static let marcyRegalado = ImageAsset(name: "MarcyRegalado")
    internal static let mattDias = ImageAsset(name: "MattDias")
    internal static let michaelHelmbrecht = ImageAsset(name: "MichaelHelmbrecht")
    internal static let neemSerra = ImageAsset(name: "NeemSerra")
    internal static let patButkiewicz = ImageAsset(name: "PatButkiewicz")
    internal static let robNapier = ImageAsset(name: "RobNapier")
    internal static let sarpErdag = ImageAsset(name: "SarpErdag")
    internal static let seanOlszewski = ImageAsset(name: "SeanOlszewski")
    internal static let susanBennett = ImageAsset(name: "SusanBennett")
    internal static let toddBurner = ImageAsset(name: "ToddBurner")
    internal static let zevEisenberg = ImageAsset(name: "ZevEisenberg")
    internal static let jamesheadshot = ImageAsset(name: "jamesheadshot")
  }
  internal enum Sponsors {
    internal static let linkedInLearning = ImageAsset(name: "Sponsors/LinkedInLearning")
    internal static let rueLaLa = ImageAsset(name: "Sponsors/RueLaLa")
    internal static let square = ImageAsset(name: "Sponsors/Square")
    internal static let tripAdvisor = ImageAsset(name: "Sponsors/TripAdvisor")
  }

  // swiftlint:disable trailing_comma
  internal static let allColors: [ColorAsset] = [
    Colors.black,
    Colors.darkOrange,
    Colors.lightGray,
    Colors.lightOrange,
  ]
  internal static let allImages: [ImageAsset] = [
    Speakers.agnesVasarhelyi,
    Speakers.alexBush,
    Speakers.andresPineda,
    Speakers.andyyHope,
    Speakers.ayalSpitz,
    Speakers.basBroek,
    Speakers.craigClayton,
    Speakers.davidOhayon,
    Speakers.ericaSadun,
    Speakers.garricNahapetian,
    Speakers.giorgioNatili,
    Speakers.harlanHaskins,
    Speakers.hungTruong,
    Speakers.ishShabazz,
    Speakers.jeffKelley,
    Speakers.jeffOLeary,
    Speakers.jonTaitBeason,
    Speakers.louFranco,
    Speakers.lucyMonahan,
    Speakers.marcyRegalado,
    Speakers.mattDias,
    Speakers.michaelHelmbrecht,
    Speakers.neemSerra,
    Speakers.patButkiewicz,
    Speakers.robNapier,
    Speakers.sarpErdag,
    Speakers.seanOlszewski,
    Speakers.susanBennett,
    Speakers.toddBurner,
    Speakers.zevEisenberg,
    Speakers.jamesheadshot,
    Sponsors.linkedInLearning,
    Sponsors.rueLaLa,
    Sponsors.square,
    Sponsors.tripAdvisor,
  ]
  // swiftlint:enable trailing_comma
  @available(*, deprecated, renamed: "allImages")
  internal static let allValues: [AssetType] = allImages
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

internal extension Image {
  @available(iOS 1.0, tvOS 1.0, watchOS 1.0, *)
  @available(OSX, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = Bundle(for: BundleToken.self)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal extension AssetColorTypeAlias {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

private final class BundleToken {}
