import Foundation

class LanguageManager {
    
    static let share = LanguageManager()
    private init() {}
    
    private let languageKey = "selectedLanguage"
    
    // Lấy ngôn ngữ hiện tại
    var currentLanguage: String {
        return UserDefaults.standard.string(forKey: languageKey)
            ?? Locale.preferredLanguages.first
            ?? "en"
    }
    
    // Lưu ngôn ngữ được chọn
    func setLanguage(_ code: String) {
        UserDefaults.standard.set(code, forKey: languageKey)
        UserDefaults.standard.set([code], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
    
    // Kiểm tra đã từng chọn chưa
    var hasSelectedLanguage: Bool {
        return UserDefaults.standard.string(forKey: languageKey) != nil
    }
}
