import Foundation

struct DefaultKeys {
    static let displayHighscore = "doubleHighscore"                 ///- ключ для рассчета рекорда
    static let dontdisplayHighscore = "intHighscore"                ///- ключ для отображаемого рекорда
    static let selectedTheme = "selectedTheme"                      ///- ключ для темы
    static let selectedPlayerColor = "selectedPlayerColor"          ///- ключ для цвета
    static let selectedEnemyColor = "selectedEnemyColor"            ///- ключ для цвета противника
    static let switchStateTheme = "switchStateTheme"                ///- ключ переключателя темы
    static let switchStateEnemyColor = "switchStateEnemyColor"      ///- ключ переключателя цвета врагов
}

class UserDefaultsManager {
    
    let defaults = UserDefaults.standard
    
    func setHighscore(with time: Int) {
        let oldHighscore = defaults.integer(forKey: DefaultKeys.dontdisplayHighscore)     ///- записанный результат рекорда (изначально 0)
        let newHighscore = time                                                     ///- значение времени секундомера
        let highscore = time.intToString()                                    ///- значение форматированного времени секундомера
        
        if newHighscore > oldHighscore {
            defaults.set(newHighscore, forKey: DefaultKeys.dontdisplayHighscore)
            defaults.set(highscore, forKey: DefaultKeys.displayHighscore)
        }
    }
    
    func getHighscore() -> String {
        if let time = defaults.value(forKey: DefaultKeys.displayHighscore) as? String {
            return time
        }
        return "00.000"
    }
    
    func checkDefaultAppearance() {
        if defaults.object(forKey: DefaultKeys.switchStateTheme) == nil {
            defaults.set(true, forKey: DefaultKeys.switchStateTheme)
        }
        if defaults.object(forKey: DefaultKeys.selectedPlayerColor) == nil {
            defaults.set(8, forKey: DefaultKeys.selectedPlayerColor)
        }
        if defaults.object(forKey: DefaultKeys.switchStateEnemyColor) == nil {
            defaults.set(false, forKey: DefaultKeys.switchStateEnemyColor)
        }
        if defaults.object(forKey: DefaultKeys.selectedEnemyColor) == nil {
            defaults.set(0, forKey: DefaultKeys.selectedEnemyColor)
        }
    }
    
}
