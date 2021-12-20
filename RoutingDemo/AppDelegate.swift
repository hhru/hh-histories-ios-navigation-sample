import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private func setupNavigationBarAppearance() {
        let appearance = UINavigationBar.appearance()

        #if os(iOS)
        appearance.prefersLargeTitles = true
        #endif

        appearance.tintColor = Colors.important
    }

    private func setupUserNotificationCenter() {
        let center = UNUserNotificationCenter.current()

        center.delegate = self

        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            print("requestAuthorization() -> granted: \(granted)")
            print("requestAuthorization() -> error: \(error as Any)")
        }
    }

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        setupNavigationBarAppearance()
        setupUserNotificationCenter()

        return true
    }

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        UISceneConfiguration(
            name: "Main",
            sessionRole: connectingSceneSession.role
        )
    }
}

// MARK: - UNUserNotificationCenterDelegate

extension AppDelegate: UNUserNotificationCenterDelegate {

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        defer {
            completionHandler()
        }

        let userInfo = response.notification.request.content.userInfo

        guard let roomID = userInfo["room_id"] as? Int, let chatID = userInfo["chat_id"] else {
            return
        }

        print("didReceive(roomID: \(roomID), chatID: \(chatID))")

        // Perform navigation to private room
        // with authorization check and open chat from list
    }
}
