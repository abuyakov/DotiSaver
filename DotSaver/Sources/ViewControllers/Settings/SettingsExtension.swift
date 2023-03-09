import Foundation
import UIKit

extension SettingsController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch (indexPath.section, indexPath.row) {
        case (1, 0...1):
            self.didSelectTheme(value: indexPath.row + 1, theme: .light, index: indexPath)
        case (2,0):
            let storyboard = UIStoryboard(name: "Settings", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: ColorController.identifier)
            navigationController?.pushViewController(viewController, animated: true)
        default:
            return
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .view
        cell.tintColor = .label
        switch (indexPath.section, indexPath.row) {
        case (1, 0...1):
            self.willSelectedTheme(value: indexPath.row + 1, cell: cell)
        case (2, 0):
            cell.selectionStyle = .default
        default:
            cell.selectionStyle = .none
            return
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return tableView.setHeaderFooterView(typeView: .header, text: "Theme")
        case 2:
            return tableView.setHeaderFooterView(typeView: .header, text: "Player Color")
        case 3:
            return tableView.setHeaderFooterView(typeView: .header, text: "Enemy Color")
        default:
            return UIView()
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return tableView.setHeaderFooterView(typeView: .footer, text: "When the switch is turned on, the appearance of the system repeats.")
        case 1:
            return tableView.setHeaderFooterView(typeView: .footer, text: "The selected appearance will be used. The system appearance is ignored.")
        case 2:
            return tableView.setHeaderFooterView(typeView: .footer, text: "Choose the color you like.")
        case 3:
            return tableView.setHeaderFooterView(typeView: .footer, text: "If the switch turned on, the enemies will be random colors. If turned off, enemies will be white or black dependigs on the theme of the application.")
        default:
            return UIView()
        }
    }
    
}
