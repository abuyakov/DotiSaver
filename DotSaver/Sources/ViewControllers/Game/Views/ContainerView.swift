import Foundation
import UIKit

class ContainerView: UIView {
    
    let infoView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 18
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Dot Saver"
        label.font = .rounded(ofSize: 34, weight: .bold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Tap on the screen to move the dot,\nstay away from the squares."
        label.font = .rounded(ofSize: 15, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let secondsLabel: UILabel = {
        let label = UILabel()
        label.text = "00.000 seconds"
        label.font = .rounded(ofSize: 20, weight: .medium)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let settingsButton: UIButton = {
        var container = AttributeContainer ()
        container.font = .systemFont(ofSize: 17, weight: .semibold)
        
        var config = UIButton.Configuration.filled ()
        config.cornerStyle = .large
        config.attributedTitle = AttributedString("Settings", attributes: container)
        config.baseBackgroundColor = .label
        config.baseForegroundColor = .systemBackground
        config.titleAlignment = .center
//        config.image = UIImage (systemName: "gear.circle.fill",
//                                 withConfiguration: UIImage.SymbolConfiguration (pointSize: 17))
//        config.imagePlacement = .leading
//        config.imagePadding = 5
        
        let button = UIButton()
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        internalInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func internalInit() {
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(infoView)
        
        infoView.addSubview(nameLabel)
        infoView.addSubview(infoLabel)
        infoView.addSubview(secondsLabel)
        infoView.addSubview(settingsButton)
        
        setupConstraint()
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: topAnchor),
            infoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            infoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            infoView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
            nameLabel.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -20),
            nameLabel.bottomAnchor.constraint(equalTo: infoLabel.topAnchor, constant: -10),
            
//            infoLabel.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 20),
            infoLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 20),
            infoLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -20),
            infoLabel.bottomAnchor.constraint(equalTo: secondsLabel.topAnchor, constant: -10),
            
            secondsLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 20),
            secondsLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -20),
            secondsLabel.bottomAnchor.constraint(equalTo: settingsButton.topAnchor, constant: -20),
            
//            settingsButton.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 20),
            settingsButton.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 20),
            settingsButton.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -20),
            settingsButton.bottomAnchor.constraint(equalTo: infoView.bottomAnchor, constant: -20),
            settingsButton.heightAnchor.constraint(equalToConstant: 54)
        ])
    }
    
    
    
}
