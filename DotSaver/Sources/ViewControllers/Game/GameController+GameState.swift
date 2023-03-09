import Foundation
import UIKit

extension GameController {
    
    func prepareGame() {
        gameState = .ready
        
        removeEnemies()
        setupPlayer()
        
        timerLabel.fadeOut(0)
        playerView.fadeIn(0.7)
        highscoreLabel.fadeIn(0.7)
        infoLabel.fadeIn(0.7)
        settingsButton.fadeIn(0.7)
        highscoreLabel.text = "HIGHSCORE\n" + UserDefaultsManager().getHighscore()
        
        isAlertShow = false
        
        print("3:: \(UserDefaultsManager().getHighscore())")
    }
    
    func startGame() {
        gameState = .play
        
        startEnemyTimer()
        startDisplayLink()
        beginTime = 0
        
        timerLabel.fadeIn(0.5)
        highscoreLabel.fadeOut(0.5)
        infoLabel.fadeOut(0.5)
        settingsButton.fadeOut(0.5)
    }
    
    func stopGame() {
        UIFeedbackGenerator.impactOccurred(.notificationError)
        gameState = .stop
        
        stopDisplayLink()
        stopEnemyTimer()
        stopAnimators()
        
        timerLabel.fadeOut(0)
        playerView.fadeOut(3.0)
        enemyViews.forEach { $0.fadeOut(3.0) }
    }
    
    func gameOver() {
        stopGame()
        
        UserDefaultsManager().setHighscore(with: self.elapsedTime.timeIntervalToInt())
        
        if (isAlertShow == false) {
            showGameOverAlert()
            isAlertShow = true
        } else {
            return
        }
    }
    
    private func showGameOverAlert() {
        let highscore = elapsedTime.timeIntervalToInt().intToString()
        let alert = UIAlertController(title: "Game Over",
                                      message: highscore + " seconds",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { action in
            action.setValue(UIColor.label, forKey: "titleTextColor")
            self.prepareGame()
        }))
        self.present(alert, animated: true)
    }
    
    private func saveResult() {
        let highscore = elapsedTime.timeIntervalToInt()
        UserDefaultsManager().setHighscore(with: highscore)
    }
    
}
