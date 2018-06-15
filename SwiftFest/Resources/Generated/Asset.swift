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
    internal static let blackHighlighted = ColorAsset(name: "BlackHighlighted")
    internal static let codeBackground = ColorAsset(name: "CodeBackground")
    internal static let codeForeground = ColorAsset(name: "CodeForeground")
    internal static let darkOrange = ColorAsset(name: "DarkOrange")
    internal static let lightGray = ColorAsset(name: "LightGray")
    internal static let lightOrange = ColorAsset(name: "LightOrange")
    internal static let mediumGray = ColorAsset(name: "MediumGray")
    internal static let white = ColorAsset(name: "White")
  }
  internal enum Icons {
    internal static let agendaSelected = ImageAsset(name: "agenda selected")
    internal static let agenda = ImageAsset(name: "agenda")
    internal static let backIcon = ImageAsset(name: "backIcon")
    internal static let infoIcon = ImageAsset(name: "infoIcon")
    internal static let profileIcon = ImageAsset(name: "profileIcon")
    internal static let sponsorIcon = ImageAsset(name: "sponsorIcon")
    internal static let team = ImageAsset(name: "team")
  }
  internal enum SocialIcons {
    internal static let facebook = ImageAsset(name: "facebook")
    internal static let github = ImageAsset(name: "github")
    internal static let linkedin = ImageAsset(name: "linkedin")
    internal static let site = ImageAsset(name: "site")
    internal static let twitter = ImageAsset(name: "twitter")
  }
  internal enum Speakers {
    internal static let agisTsaraboulidis = ImageAsset(name: "AgisTsaraboulidis")
    internal static let agnesVasarhelyi = ImageAsset(name: "AgnesVasarhelyi")
    internal static let alexBush = ImageAsset(name: "AlexBush")
    internal static let alexanderLash = ImageAsset(name: "AlexanderLash")
    internal static let alexandreaMellen = ImageAsset(name: "AlexandreaMellen")
    internal static let aliciaCarr = ImageAsset(name: "AliciaCarr")
    internal static let andresPineda = ImageAsset(name: "AndresPineda")
    internal static let andyyHope = ImageAsset(name: "AndyyHope")
    internal static let ariRoshko = ImageAsset(name: "AriRoshko")
    internal static let arthurSabintsev = ImageAsset(name: "ArthurSabintsev")
    internal static let ayalSpitz = ImageAsset(name: "AyalSpitz")
    internal static let barbaraMenicucci = ImageAsset(name: "BarbaraMenicucci")
    internal static let barbaraVanaki = ImageAsset(name: "BarbaraVanaki")
    internal static let bradSmith = ImageAsset(name: "BradSmith")
    internal static let bryanRyczek = ImageAsset(name: "BryanRyczek")
    internal static let chrisBuonocore = ImageAsset(name: "ChrisBuonocore")
    internal static let craigClayton = ImageAsset(name: "CraigClayton")
    internal static let dakotaKim = ImageAsset(name: "DakotaKim")
    internal static let davidOhayon = ImageAsset(name: "DavidOhayon")
    internal static let davidOkun = ImageAsset(name: "DavidOkun")
    internal static let garricNahapetian = ImageAsset(name: "GarricNahapetian")
    internal static let giorgioNatili = ImageAsset(name: "GiorgioNatili")
    internal static let glenYi = ImageAsset(name: "GlenYi")
    internal static let hariGanesan = ImageAsset(name: "HariGanesan")
    internal static let harlanHaskins = ImageAsset(name: "HarlanHaskins")
    internal static let hungTruong = ImageAsset(name: "HungTruong")
    internal static let ishShabazz = ImageAsset(name: "IshShabazz")
    internal static let jamesGraham = ImageAsset(name: "JamesGraham")
    internal static let jeffKelley = ImageAsset(name: "JeffKelley")
    internal static let jeffOLeary = ImageAsset(name: "JeffOLeary")
    internal static let jonTaitBeason = ImageAsset(name: "Jon-TaitBeason")
    internal static let joseTaveras = ImageAsset(name: "JoseTaveras")
    internal static let joshuaGreene = ImageAsset(name: "JoshuaGreene")
    internal static let louFranco = ImageAsset(name: "LouFranco")
    internal static let lucyMonahan = ImageAsset(name: "LucyMonahan")
    internal static let luisAlberto = ImageAsset(name: "LuisAlberto")
    internal static let marcyRegalado = ImageAsset(name: "MarcyRegalado")
    internal static let martinMitrevski = ImageAsset(name: "MartinMitrevski")
    internal static let mattDias = ImageAsset(name: "MattDias")
    internal static let mehrnooshSameki = ImageAsset(name: "MehrnooshSameki")
    internal static let michaelHelmbrecht = ImageAsset(name: "MichaelHelmbrecht")
    internal static let mythriShenoy = ImageAsset(name: "MythriShenoy")
    internal static let neemSerra = ImageAsset(name: "NeemSerra")
    internal static let patButkiewicz = ImageAsset(name: "PatButkiewicz")
    internal static let paulBruce = ImageAsset(name: "PaulBruce")
    internal static let rayDeck = ImageAsset(name: "RayDeck")
    internal static let robNapier = ImageAsset(name: "RobNapier")
    internal static let sarpErdag = ImageAsset(name: "SarpErdag")
    internal static let seanOlszewski = ImageAsset(name: "SeanOlszewski")
    internal static let susanBennett = ImageAsset(name: "SusanBennett")
    internal static let toddBurner = ImageAsset(name: "ToddBurner")
    internal static let yohannaRamirez = ImageAsset(name: "YohannaRamirez")
    internal static let zevEisenberg = ImageAsset(name: "ZevEisenberg")
  }
  internal enum Sponsors {
    internal static let chewy = ImageAsset(name: "Sponsors/Chewy")
    internal static let intrepid = ImageAsset(name: "Sponsors/Intrepid")
    internal static let linkedInLearning = ImageAsset(name: "Sponsors/LinkedInLearning")
    internal static let rueLaLa = ImageAsset(name: "Sponsors/RueLaLa")
    internal static let square = ImageAsset(name: "Sponsors/Square")
    internal static let tripAdvisor = ImageAsset(name: "Sponsors/TripAdvisor")
    internal static let wayfair = ImageAsset(name: "Sponsors/Wayfair")
  }
  internal static let tabSelected = ImageAsset(name: "Tab Selected")
  internal static let tabUnselected = ImageAsset(name: "Tab Unselected")
  internal static let logo = ImageAsset(name: "logo")

  // swiftlint:disable trailing_comma
  internal static let allColors: [ColorAsset] = [
    Colors.black,
    Colors.blackHighlighted,
    Colors.codeBackground,
    Colors.codeForeground,
    Colors.darkOrange,
    Colors.lightGray,
    Colors.lightOrange,
    Colors.mediumGray,
    Colors.white,
  ]
  internal static let allImages: [ImageAsset] = [
    Icons.agendaSelected,
    Icons.agenda,
    Icons.backIcon,
    Icons.infoIcon,
    Icons.profileIcon,
    Icons.sponsorIcon,
    Icons.team,
    SocialIcons.facebook,
    SocialIcons.github,
    SocialIcons.linkedin,
    SocialIcons.site,
    SocialIcons.twitter,
    Speakers.agisTsaraboulidis,
    Speakers.agnesVasarhelyi,
    Speakers.alexBush,
    Speakers.alexanderLash,
    Speakers.alexandreaMellen,
    Speakers.aliciaCarr,
    Speakers.andresPineda,
    Speakers.andyyHope,
    Speakers.ariRoshko,
    Speakers.arthurSabintsev,
    Speakers.ayalSpitz,
    Speakers.barbaraMenicucci,
    Speakers.barbaraVanaki,
    Speakers.bradSmith,
    Speakers.bryanRyczek,
    Speakers.chrisBuonocore,
    Speakers.craigClayton,
    Speakers.dakotaKim,
    Speakers.davidOhayon,
    Speakers.davidOkun,
    Speakers.garricNahapetian,
    Speakers.giorgioNatili,
    Speakers.glenYi,
    Speakers.hariGanesan,
    Speakers.harlanHaskins,
    Speakers.hungTruong,
    Speakers.ishShabazz,
    Speakers.jamesGraham,
    Speakers.jeffKelley,
    Speakers.jeffOLeary,
    Speakers.jonTaitBeason,
    Speakers.joseTaveras,
    Speakers.joshuaGreene,
    Speakers.louFranco,
    Speakers.lucyMonahan,
    Speakers.luisAlberto,
    Speakers.marcyRegalado,
    Speakers.martinMitrevski,
    Speakers.mattDias,
    Speakers.mehrnooshSameki,
    Speakers.michaelHelmbrecht,
    Speakers.mythriShenoy,
    Speakers.neemSerra,
    Speakers.patButkiewicz,
    Speakers.paulBruce,
    Speakers.rayDeck,
    Speakers.robNapier,
    Speakers.sarpErdag,
    Speakers.seanOlszewski,
    Speakers.susanBennett,
    Speakers.toddBurner,
    Speakers.yohannaRamirez,
    Speakers.zevEisenberg,
    Sponsors.chewy,
    Sponsors.intrepid,
    Sponsors.linkedInLearning,
    Sponsors.rueLaLa,
    Sponsors.square,
    Sponsors.tripAdvisor,
    Sponsors.wayfair,
    tabSelected,
    tabUnselected,
    logo,
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
