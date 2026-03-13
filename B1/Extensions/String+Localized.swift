//
//  String+Localized.swift
//  B1
//
//  Created by Đinh Văn Phi on 13/3/26.
//

import Foundation

extension String {
    var localized: String {
        let languageCode = LanguageManager.share.currentLanguage
        print(" languageCode = \(languageCode)")
        print(" key = \(self)")
        
        guard let path = Bundle.main.path(
                  forResource: languageCode,
                  ofType: "lproj"),
              let bundle = Bundle(path: path)
        else {
            print("Không tìm thấy bundle cho \(languageCode)")
            
            guard let enPath = Bundle.main.path(forResource: "en", ofType: "lproj"),
                  let enBundle = Bundle(path: enPath) else {
                return NSLocalizedString(self, bundle: .main, comment: "")
            }
            return NSLocalizedString(self, bundle: enBundle, comment: "")
        }
        
        let result = NSLocalizedString(self, bundle: bundle, comment: "")
        print(" result = \(result)")
        return result
    }
}
