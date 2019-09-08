// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
  /// No internet
  internal static let alertMessageNoInternet = L10n.tr("Localizable", "alert_message_no_internet")
  /// Error
  internal static let alertTitleError = L10n.tr("Localizable", "alert_title_error")
  /// No internet
  internal static let alertTitleNoInternet = L10n.tr("Localizable", "alert_title_no_internet")
  /// Cancel
  internal static let buttonTitleCancel = L10n.tr("Localizable", "button_title_cancel")
  /// Settings
  internal static let buttonTitleSettings = L10n.tr("Localizable", "button_title_settings")
  /// Try again
  internal static let buttonTitleTryAgain = L10n.tr("Localizable", "button_title_try_again")
  /// Alerts
  internal static let titleLabelAlerts = L10n.tr("Localizable", "title_label_alerts")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
