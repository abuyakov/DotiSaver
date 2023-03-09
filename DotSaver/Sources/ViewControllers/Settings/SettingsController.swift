import UIKit

class SettingsController: UITableViewController {

    @IBOutlet weak var colorImageView: UIImageView!
    @IBOutlet weak var colorValueLabel: UILabel!
    @IBOutlet weak var themeSwitch: UISwitch!
    @IBOutlet weak var enemySwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        view.backgroundColor = .background
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.backButtonDisplayMode = .minimal
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(hideControlller))
        
        tableView.allowsMultipleSelection = false
        
        colorValueLabel.text = AppearanceManager.shared.playercolor.descriptions()
        colorImageView.tintColor = AppearanceManager.shared.playercolor.getColorStyle()
        
        themeSwitch.isOn = UserDefaults.standard.bool(forKey: DefaultKeys.switchStateTheme)
        enemySwitch.isOn = UserDefaults.standard.bool(forKey: DefaultKeys.switchStateEnemyColor)
        
        debugPrint("Current: \(AppearanceManager.shared.theme.descriptions()) + \(AppearanceManager.shared.playercolor.descriptions())")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        colorValueLabel.text = AppearanceManager.shared.playercolor.descriptions()
        colorImageView.tintColor = AppearanceManager.shared.playercolor.getColorStyle()
    }

    @objc func hideControlller() {
        self.dismiss(animated: true)
    }
    
    @IBAction func switchThemeValueChanged(sender: UISwitch) {
        if themeSwitch.isOn {
            UserDefaults.standard.set(true, forKey: DefaultKeys.switchStateTheme)
            AppearanceManager.shared.theme = Themes(rawValue: 0) ?? .auto
            view.window?.overrideUserInterfaceStyle = AppearanceManager.shared.theme.getUserInterfaceStyle()
        } else {
            UserDefaults.standard.set(false, forKey: DefaultKeys.switchStateTheme)
            AppearanceManager.shared.theme = Themes(rawValue: 1) ?? .light
            view.window?.overrideUserInterfaceStyle = AppearanceManager.shared.theme.getUserInterfaceStyle()
        }
        tableView.reloadData()
    }
    
    @IBAction func switchEnemyValueChanged(sender: UISwitch) {
        if enemySwitch.isOn {
            UserDefaults.standard.set(true, forKey: DefaultKeys.switchStateEnemyColor)
            AppearanceManager.shared.enemycolor = Colors(rawValue: 14) ?? .random
        } else {
            UserDefaults.standard.set(false, forKey: DefaultKeys.switchStateEnemyColor)
            AppearanceManager.shared.enemycolor = Colors(rawValue: 0) ?? .wb
        }
    }
    
    func didSelectTheme(value: Int, theme: Themes, index: IndexPath) {
        UIFeedbackGenerator.impactOccurred(.selectionChanged)
        AppearanceManager.shared.theme = Themes(rawValue: value) ?? theme
        view.window?.overrideUserInterfaceStyle = AppearanceManager.shared.theme.getUserInterfaceStyle()
        let cell = tableView.cellForRow(at: index)
        cell?.selectionStyle = .none
        cell?.accessoryType = .checkmark
        
        themeSwitch.isOn = false
        UserDefaults.standard.set(false, forKey: DefaultKeys.switchStateTheme)
    }
    
    func willSelectedTheme(value: Int, cell: UITableViewCell) {
        if AppearanceManager.shared.theme.rawValue == value {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
    
    


}
