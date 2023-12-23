//
//  Strings+localisations.swift
//  five.minutes.math.drills
//
//  Created by Quantmis on 23/12/2023.
//

import Foundation
extension String {

    func localized(_ language: Language) -> String {
        let path = Bundle.main.path(forResource: language.rawValue, ofType: "lproj")
        let bundle: Bundle
        if let path = path {
            bundle = Bundle(path: path) ?? .main
        } else {
            bundle = .main
        }
        return localized(bundle: bundle, tableName: "Localizable")
    }

    func localized(_ language: Language, args: CVarArg...) -> String {
        let path = Bundle.main.path(forResource: language.rawValue, ofType: "lproj")
        let bundle: Bundle
        if let path = path {
            bundle = Bundle(path: path) ?? .main
        } else {
            bundle = .main
        }
        let format = localized(bundle: bundle, tableName: "Localizable")
        return String(format: format, arguments: args)
    }

    private func localized(bundle: Bundle, tableName: String) -> String {
        return NSLocalizedString(self, tableName: tableName, bundle: bundle, value: "", comment: "")
    }
}
