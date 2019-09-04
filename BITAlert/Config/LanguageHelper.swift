//
//  LanguageHelper.swift
//  BITAlert
//
//  Created by Bane Manojlovic on 9/4/19.
//  Copyright © 2019 Bane Manojlovic. All rights reserved.
//

import Foundation

class LanguageHelper {
    
    // MARK: - Properties
    static var languageArray: [String] {
        return ["EN", "SV"]
    }
    
    // MARK: - Methods
    static func getLanguage() -> String {
        let prefferedLanguages = Locale.preferredLanguages
        for language in prefferedLanguages {
            if let lang = language.split(separator: "-").first,
                languageArray.contains(String(lang).uppercased()) {
                return String(lang).uppercased()
            }
        }
        return "EN"
    }
}
