import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let sceneWindow = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: sceneWindow)
        self.window?.rootViewController = GameController()
        self.window?.makeKeyAndVisible()
        self.window?.overrideUserInterfaceStyle = AppearanceManager.shared.theme.getUserInterfaceStyle()
        self.window?.tintColor = AppearanceManager.shared.playercolor.getColorStyle()
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }


}

