//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap { Locale(identifier: $0) } ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map { Locale(identifier: $0) }
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 1 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.color` struct is generated, and contains static references to 4 colors.
  struct color {
    /// Color `BlackHaze`.
    static let blackHaze = Rswift.ColorResource(bundle: R.hostingBundle, name: "BlackHaze")
    /// Color `Black`.
    static let black = Rswift.ColorResource(bundle: R.hostingBundle, name: "Black")
    /// Color `Vermilion`.
    static let vermilion = Rswift.ColorResource(bundle: R.hostingBundle, name: "Vermilion")
    /// Color `White`.
    static let white = Rswift.ColorResource(bundle: R.hostingBundle, name: "White")

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "Black", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func black(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.black, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "BlackHaze", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func blackHaze(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.blackHaze, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "Vermilion", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func vermilion(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.vermilion, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "White", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func white(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.white, compatibleWith: traitCollection)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "Black", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func black(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.black.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "BlackHaze", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func blackHaze(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.blackHaze.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "Vermilion", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func vermilion(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.vermilion.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "White", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func white(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.white.name)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 0 images.
  struct image {
    /// This `R.image.icons` struct is generated, and contains static references to 5 images.
    struct icons {
      /// Image `AppLogo`.
      static let appLogo = Rswift.ImageResource(bundle: R.hostingBundle, name: "Icons/AppLogo")
      /// Image `BackArrow`.
      static let backArrow = Rswift.ImageResource(bundle: R.hostingBundle, name: "Icons/BackArrow")
      /// Image `Google`.
      static let google = Rswift.ImageResource(bundle: R.hostingBundle, name: "Icons/Google")
      /// Image `HorizontalSeparator`.
      static let horizontalSeparator = Rswift.ImageResource(bundle: R.hostingBundle, name: "Icons/HorizontalSeparator")
      /// Image `SecuritySwitcher`.
      static let securitySwitcher = Rswift.ImageResource(bundle: R.hostingBundle, name: "Icons/SecuritySwitcher")

      #if os(iOS) || os(tvOS)
      /// `UIImage(named: "AppLogo", bundle: ..., traitCollection: ...)`
      static func appLogo(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
        return UIKit.UIImage(resource: R.image.icons.appLogo, compatibleWith: traitCollection)
      }
      #endif

      #if os(iOS) || os(tvOS)
      /// `UIImage(named: "BackArrow", bundle: ..., traitCollection: ...)`
      static func backArrow(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
        return UIKit.UIImage(resource: R.image.icons.backArrow, compatibleWith: traitCollection)
      }
      #endif

      #if os(iOS) || os(tvOS)
      /// `UIImage(named: "Google", bundle: ..., traitCollection: ...)`
      static func google(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
        return UIKit.UIImage(resource: R.image.icons.google, compatibleWith: traitCollection)
      }
      #endif

      #if os(iOS) || os(tvOS)
      /// `UIImage(named: "HorizontalSeparator", bundle: ..., traitCollection: ...)`
      static func horizontalSeparator(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
        return UIKit.UIImage(resource: R.image.icons.horizontalSeparator, compatibleWith: traitCollection)
      }
      #endif

      #if os(iOS) || os(tvOS)
      /// `UIImage(named: "SecuritySwitcher", bundle: ..., traitCollection: ...)`
      static func securitySwitcher(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
        return UIKit.UIImage(resource: R.image.icons.securitySwitcher, compatibleWith: traitCollection)
      }
      #endif

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  /// This `R.string` struct is generated, and contains static references to 1 localization tables.
  struct string {
    /// This `R.string.localizable` struct is generated, and contains static references to 20 localization keys.
    struct localizable {
      /// Value: AeroPlan | Travel
      static let appTitle = Rswift.StringResource(key: "appTitle", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: AeroPlan’s terms of conditions
      static let termsOfConditionsLink = Rswift.StringResource(key: "termsOfConditionsLink", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Already registered?
      static let createAccountAlreadyRegistered = Rswift.StringResource(key: "createAccountAlreadyRegistered", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Already registered?
      static let welcomeScreenAlreadyRegistered = Rswift.StringResource(key: "welcomeScreenAlreadyRegistered", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: By creating an account you sign and agree to AeroPlan’s terms of conditions
      static let termsOfConditionsText = Rswift.StringResource(key: "termsOfConditionsText", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Create account
      static let createAccountCreateAccount = Rswift.StringResource(key: "createAccountCreateAccount", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Create account
      static let signInCreateAccout = Rswift.StringResource(key: "signInCreateAccout", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Email
      static let createAccountEmailPlaceholder = Rswift.StringResource(key: "createAccountEmailPlaceholder", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Forgot password?
      static let signInForgotPassword = Rswift.StringResource(key: "signInForgotPassword", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Log in
      static let signInScreenLogin = Rswift.StringResource(key: "signInScreenLogin", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Log in with Google Account
      static let signInLogInWithGoogle = Rswift.StringResource(key: "signInLogInWithGoogle", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: New to AeroPlan?
      static let signInNewUser = Rswift.StringResource(key: "signInNewUser", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Password
      static let createAccountPasswordPlaceholder = Rswift.StringResource(key: "createAccountPasswordPlaceholder", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Password
      static let signInPasswordPlaceholder = Rswift.StringResource(key: "signInPasswordPlaceholder", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Sign in
      static let createAccountSignIn = Rswift.StringResource(key: "createAccountSignIn", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Sign in
      static let welcomeScreenSignIn = Rswift.StringResource(key: "welcomeScreenSignIn", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Start adventure
      static let welcomeScreenStartAdventure = Rswift.StringResource(key: "welcomeScreenStartAdventure", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Travel
      static let appTitleHighlighted = Rswift.StringResource(key: "appTitleHighlighted", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Username
      static let createAccountUsernamePlaceholder = Rswift.StringResource(key: "createAccountUsernamePlaceholder", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Username
      static let signInUsernamePlaceholder = Rswift.StringResource(key: "signInUsernamePlaceholder", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)

      /// Value: AeroPlan | Travel
      static func appTitle(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("appTitle", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "appTitle"
        }

        return NSLocalizedString("appTitle", bundle: bundle, comment: "")
      }

      /// Value: AeroPlan’s terms of conditions
      static func termsOfConditionsLink(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("termsOfConditionsLink", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "termsOfConditionsLink"
        }

        return NSLocalizedString("termsOfConditionsLink", bundle: bundle, comment: "")
      }

      /// Value: Already registered?
      static func createAccountAlreadyRegistered(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("createAccountAlreadyRegistered", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "createAccountAlreadyRegistered"
        }

        return NSLocalizedString("createAccountAlreadyRegistered", bundle: bundle, comment: "")
      }

      /// Value: Already registered?
      static func welcomeScreenAlreadyRegistered(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("welcomeScreenAlreadyRegistered", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "welcomeScreenAlreadyRegistered"
        }

        return NSLocalizedString("welcomeScreenAlreadyRegistered", bundle: bundle, comment: "")
      }

      /// Value: By creating an account you sign and agree to AeroPlan’s terms of conditions
      static func termsOfConditionsText(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("termsOfConditionsText", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "termsOfConditionsText"
        }

        return NSLocalizedString("termsOfConditionsText", bundle: bundle, comment: "")
      }

      /// Value: Create account
      static func createAccountCreateAccount(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("createAccountCreateAccount", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "createAccountCreateAccount"
        }

        return NSLocalizedString("createAccountCreateAccount", bundle: bundle, comment: "")
      }

      /// Value: Create account
      static func signInCreateAccout(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("signInCreateAccout", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "signInCreateAccout"
        }

        return NSLocalizedString("signInCreateAccout", bundle: bundle, comment: "")
      }

      /// Value: Email
      static func createAccountEmailPlaceholder(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("createAccountEmailPlaceholder", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "createAccountEmailPlaceholder"
        }

        return NSLocalizedString("createAccountEmailPlaceholder", bundle: bundle, comment: "")
      }

      /// Value: Forgot password?
      static func signInForgotPassword(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("signInForgotPassword", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "signInForgotPassword"
        }

        return NSLocalizedString("signInForgotPassword", bundle: bundle, comment: "")
      }

      /// Value: Log in
      static func signInScreenLogin(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("signInScreenLogin", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "signInScreenLogin"
        }

        return NSLocalizedString("signInScreenLogin", bundle: bundle, comment: "")
      }

      /// Value: Log in with Google Account
      static func signInLogInWithGoogle(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("signInLogInWithGoogle", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "signInLogInWithGoogle"
        }

        return NSLocalizedString("signInLogInWithGoogle", bundle: bundle, comment: "")
      }

      /// Value: New to AeroPlan?
      static func signInNewUser(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("signInNewUser", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "signInNewUser"
        }

        return NSLocalizedString("signInNewUser", bundle: bundle, comment: "")
      }

      /// Value: Password
      static func createAccountPasswordPlaceholder(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("createAccountPasswordPlaceholder", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "createAccountPasswordPlaceholder"
        }

        return NSLocalizedString("createAccountPasswordPlaceholder", bundle: bundle, comment: "")
      }

      /// Value: Password
      static func signInPasswordPlaceholder(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("signInPasswordPlaceholder", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "signInPasswordPlaceholder"
        }

        return NSLocalizedString("signInPasswordPlaceholder", bundle: bundle, comment: "")
      }

      /// Value: Sign in
      static func createAccountSignIn(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("createAccountSignIn", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "createAccountSignIn"
        }

        return NSLocalizedString("createAccountSignIn", bundle: bundle, comment: "")
      }

      /// Value: Sign in
      static func welcomeScreenSignIn(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("welcomeScreenSignIn", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "welcomeScreenSignIn"
        }

        return NSLocalizedString("welcomeScreenSignIn", bundle: bundle, comment: "")
      }

      /// Value: Start adventure
      static func welcomeScreenStartAdventure(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("welcomeScreenStartAdventure", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "welcomeScreenStartAdventure"
        }

        return NSLocalizedString("welcomeScreenStartAdventure", bundle: bundle, comment: "")
      }

      /// Value: Travel
      static func appTitleHighlighted(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("appTitleHighlighted", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "appTitleHighlighted"
        }

        return NSLocalizedString("appTitleHighlighted", bundle: bundle, comment: "")
      }

      /// Value: Username
      static func createAccountUsernamePlaceholder(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("createAccountUsernamePlaceholder", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "createAccountUsernamePlaceholder"
        }

        return NSLocalizedString("createAccountUsernamePlaceholder", bundle: bundle, comment: "")
      }

      /// Value: Username
      static func signInUsernamePlaceholder(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("signInUsernamePlaceholder", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "signInUsernamePlaceholder"
        }

        return NSLocalizedString("signInUsernamePlaceholder", bundle: bundle, comment: "")
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}
