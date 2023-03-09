import Foundation
import UIKit

extension UITableView {
    
    enum HeaderFooterType {
        case header
        case footer
    }
    
    func setHeaderFooterView(typeView: HeaderFooterType, text: String) -> UITableViewHeaderFooterView {
        let view = UITableViewHeaderFooterView()
        
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        
        switch typeView {
        case .header:
            label.text = text.uppercased()
            
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
                label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
                label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
                label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8)
            ])
        case .footer:
            label.text = text
            
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: view.topAnchor, constant: 7),
                label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
                label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
                label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12)
            ])
        }
        return view
    }
    
}
