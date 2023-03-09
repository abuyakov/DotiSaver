import Foundation
import UIKit

class ColorController: UITableViewController {
    
    static let identifier = "ColorController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setupUI()
    }
    
    func setupUI() {
        title = "Player color"
        navigationItem.largeTitleDisplayMode = .never
        tableView.backgroundColor = .background
        tableView.allowsMultipleSelection = false
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 0...13):
            self.didSelectColor(value: indexPath.row, color: .wb, index: indexPath)
        default:
            return
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .view
        cell.tintColor = .label
        cell.selectionStyle = .none
        switch (indexPath.section, indexPath.row) {
        case (0, 0...13):
            self.willSelectedColor(value: indexPath.row, cell: cell)
        default:
            return
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func didSelectColor(value: Int, color: Colors, index: IndexPath) {
        UIFeedbackGenerator.impactOccurred(.selectionChanged)
        AppearanceManager.shared.playercolor = Colors(rawValue: value) ?? color
        view.window?.tintColor = AppearanceManager.shared.playercolor.getColorStyle()
        let cell = tableView.cellForRow(at: index)
        cell?.accessoryType = .checkmark
    }
    
    func willSelectedColor(value: Int, cell: UITableViewCell) {
        if AppearanceManager.shared.playercolor.rawValue == value {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
    
}
