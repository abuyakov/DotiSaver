import UIKit

class GameController: UIViewController {
    
    static let identifier = "GameController"
    
    let containerView = ContainerView()
    
    var playerView = PlayerView()
    var playerAnimator: UIViewPropertyAnimator?
    let playerAnimationDuration = 5.0
    
    var enemyViews = [UIView]()
    var enemyAnimators = [UIViewPropertyAnimator]()
    var enemySpeed: CGFloat = 40
    var enemyTimer: Timer?
    
    var displayLink: CADisplayLink?
    var beginTime: TimeInterval = 0
    var elapsedTime: TimeInterval = 0
    
    var gameState: GameState = .ready
    
    var isAlertShow: Bool = false
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .quaternaryLabel
        label.textAlignment = .center
        label.font = .monospacedDigitSystemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Tap the screen to move the dot to avoid colliding with the squares."//\n\nTry to hold out as long as possible."
        label.font = .rounded(ofSize: 15, weight: .regular)
        label.textColor = .tertiaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let highscoreLabel: UILabel = {
        let label = UILabel()
        label.font = .rounded(ofSize: 24, weight: .bold)
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let settingsButton = UIButton()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraint()
        prepareGame()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSettingsButton()
    }
    
    func setupUI() {
        view.backgroundColor = .background
        view.addSubview(highscoreLabel)
        view.addSubview(timerLabel)
        view.addSubview(infoLabel)
        view.addSubview(settingsButton)
        
        
        settingsButton.addAction(UIAction(handler: { _ in
            UIFeedbackGenerator.impactOccurred(.soft)
            let storyboard = UIStoryboard(name: "Settings", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "SettingsController")
            let navController = UINavigationController(rootViewController: viewController)
            navController.modalTransitionStyle = .coverVertical
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true)
        }), for: .touchUpInside)
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 70),
            infoLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 60),
            infoLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -60),
            
            highscoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            highscoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            settingsButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            settingsButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            settingsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            settingsButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    func setupSettingsButton() {
        var container = AttributeContainer ()
        container.font = .systemFont(ofSize: 17, weight: .semibold)
        
        var config = UIButton.Configuration.filled ()
        config.cornerStyle = .capsule
        config.attributedTitle = AttributedString("Settings", attributes: container)
        config.titleAlignment = .center
        config.baseBackgroundColor = .tintColor
        
        ///если цвет игрока белый/черный то цвет текста на кнопке меняется напротивоположный
        if AppearanceManager.shared.playercolor.getColorStyle() == .label {
            config.baseForegroundColor = .systemBackground
        } else {
            config.baseForegroundColor = .white
        }
        
        settingsButton.configuration = config
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let touch = touches.first!
        
        if touch.view == view {
            if gameState == .ready {
                startGame()
            }
            let location = touch.location(in: view)
            movePlayer(to: location)
            moveEnemies(to: location)
            return
        }
    }
    
    func setupPlayer() {
        playerView.center = view.center
        view.addSubview(playerView)
    }
    
    func setupEnemy() {
        let enemyView = EnemyView()
        view.addSubview(enemyView)
        
        let screenEdge = ScreenEdge.init(rawValue: Int(arc4random_uniform(4)))
        let screenBounds = UIScreen.main.bounds
        var position: CGFloat = 0
        
        switch screenEdge! {
        case .left, .right:
            position = CGFloat(arc4random_uniform(UInt32(screenBounds.height)))
        case .top, .bottom:
            position = CGFloat(arc4random_uniform(UInt32(screenBounds.width)))
        }
        
        switch screenEdge! {
        case .left:
            enemyView.center = CGPoint(x: 0, y: position)
        case .right:
            enemyView.center = CGPoint(x: screenBounds.width, y: position)
        case .top:
            enemyView.center = CGPoint(x: position, y: screenBounds.height)
        case .bottom:
            enemyView.center = CGPoint(x: position, y: 0)
        }
        
        let duration = getEnemyDuration(enemyView: enemyView)
        let enemyAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) { [weak self] in
            if let strongSelf = self {
                enemyView.center = strongSelf.playerView.center
            }
        }
        
        enemyAnimator.startAnimation()
        enemyAnimators.append(enemyAnimator)
        enemyViews.append(enemyView)
    }
    
    func getEnemyDuration(enemyView: UIView) -> TimeInterval {
        let dx = playerView.center.x - enemyView.center.x
        let dy = playerView.center.y - enemyView.center.y
        return TimeInterval(sqrt(dx * dx + dy * dy) / enemySpeed)
    }
    
    //Генерация противника с рандомной позицией
    @objc func generateEnemy(timer: Timer) {
        increase()
        setupEnemy()
    }
    
    @objc func tick(sender: CADisplayLink) {
        checkCollision()
        updateCountUpTimer(timestamp: sender.timestamp)
    }
    
    func endTimer() {
        enemyTimer?.invalidate()
    }
    
    func increase() {
        endTimer()
        startEnemyTimer()
    }
    
    func startEnemyTimer() {
        let counter = LevelManager().increaseDifficulty(countTime: elapsedTime).displaySpeed
        enemySpeed = LevelManager().increaseDifficulty(countTime: elapsedTime).enemySpeed
        enemyTimer = Timer.scheduledTimer(timeInterval: counter,
                                          target: self,
                                          selector: #selector(generateEnemy(timer:)),
                                          userInfo: nil,
                                          repeats: true)
    }
    
    func stopEnemyTimer() {
        guard let enemyTimer = enemyTimer, enemyTimer.isValid else { return }
        enemyTimer.invalidate()
    }
    
    func startDisplayLink() {
        displayLink = CADisplayLink(target: self, selector: #selector(tick(sender:)))
        displayLink?.add(to: RunLoop.main, forMode: RunLoop.Mode.default)
    }
    
    func stopDisplayLink() {
        displayLink?.isPaused = true
        displayLink?.remove(from: RunLoop.main, forMode: RunLoop.Mode.default)
        displayLink = nil
    }
    
    func removeEnemies() {
        enemyViews.forEach { $0.removeFromSuperview() }
        enemyViews = []
    }
    
    func stopAnimators() {
        playerAnimator?.stopAnimation(true)
        playerAnimator = nil
        
        enemyAnimators.forEach { $0.stopAnimation(true) }
        enemyAnimators = []
    }
    
    func updateCountUpTimer(timestamp: TimeInterval) {
        if beginTime == 0 {
            beginTime = timestamp
        }
        elapsedTime = timestamp - beginTime
        timerLabel.text = elapsedTime.timeIntervalToInt().intToString()
    }

    
    func checkCollision() {
        enemyViews.forEach {
            guard let playerFrame = playerView.layer.presentation()?.frame,
                  let enemyFrame = $0.layer.presentation()?.frame,
                  playerFrame.intersects(enemyFrame) else { return }
            gameOver()
        }
    }
    
    func movePlayer(to touchLocation: CGPoint) {
        playerAnimator = UIViewPropertyAnimator(duration: playerAnimationDuration,
                                                dampingRatio: 0.5,
                                                animations: { [weak self] in
            self?.playerView.center = touchLocation
        })
        playerAnimator?.startAnimation()
    }
    
    func moveEnemies(to touchLocation: CGPoint) {
        for (index, enemyView) in enemyViews.enumerated() {
            let duration = getEnemyDuration(enemyView: enemyView)
            enemyAnimators[index] = UIViewPropertyAnimator(duration: duration,
                                                           curve: .linear,
                                                           animations: {
                enemyView.center = touchLocation
            })
            enemyAnimators[index].startAnimation()
        }
    }
    
    
}
