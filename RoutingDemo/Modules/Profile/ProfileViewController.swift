import UIKit
import Photos
import Nivelir

final class ProfileViewController: UIViewController {

    let screenKey: ScreenKey
    let screenNavigator: ScreenNavigator

    private var profileView: ProfileView {
        view as! ProfileView
    }

    init(screenKey: ScreenKey, screenNavigator: ScreenNavigator) {
        self.screenKey = screenKey
        self.screenNavigator = screenNavigator

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func requestPhotosAccess(completion: @escaping (_ authorized: Bool) -> Void) {
        let handler: (PHAuthorizationStatus) -> Void = { _ in
            DispatchQueue.main.async {
                self.requestPhotosAccessIfNeeded(completion: completion)
            }
        }

        if #available(iOS 14, *) {
            PHPhotoLibrary.requestAuthorization(for: .readWrite, handler: handler)
        } else {
            PHPhotoLibrary.requestAuthorization(handler)
        }
    }

    private func requestPhotosAccessIfNeeded(completion: @escaping (_ authorized: Bool) -> Void) {
        let authorizationStatus: PHAuthorizationStatus

        if #available(iOS 14, *) {
            authorizationStatus = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        } else {
            authorizationStatus = PHPhotoLibrary.authorizationStatus()
        }

        switch authorizationStatus {
        case .authorized, .limited:
            completion(true)

        case .denied, .restricted:
            completion(false)

        case .notDetermined:
            requestPhotosAccess(completion: completion)

        @unknown default:
            completion(false)
        }
    }

    private func requestCameraAccess(completion: @escaping (_ authorized: Bool) -> Void) {
        AVCaptureDevice.requestAccess(for: .video) { _ in
            DispatchQueue.main.async {
                self.requestCameraAccessIfNeeded(completion: completion)
            }
        }
    }

    private func requestCameraAccessIfNeeded(completion: @escaping (_ authorized: Bool) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            completion(true)

        case .denied, .restricted:
            completion(false)

        case .notDetermined:
            requestCameraAccess(completion: completion)

        @unknown default:
            completion(false)
        }
    }

    private func requestAccessIfNeeded(
        sourceType: UIImagePickerController.SourceType,
        completion: @escaping (_ authorized: Bool) -> Void
    ) {
        switch sourceType {
        case .photoLibrary, .savedPhotosAlbum:
            requestPhotosAccessIfNeeded(completion: completion)

        case .camera:
            requestCameraAccessIfNeeded(completion: completion)

        @unknown default:
            fatalError()
        }
    }

    private func pickPhotoImageFromCamera() {
        requestAccessIfNeeded(sourceType: .camera) { [unowned self] authorized in
            guard authorized else {
                return self.present(UIAlertController.cameraPermissionRequired, animated: true)
            }

            guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                return self.present(UIAlertController.unavailableMediaSource, animated: true)
            }

            let imagePickerViewController = UIImagePickerController()

            imagePickerViewController.sourceType = .camera
            imagePickerViewController.delegate = self

            self.present(imagePickerViewController, animated: true)
        }
    }

    private func pickPhotoImageFromPhotoLibrary() {
        requestAccessIfNeeded(sourceType: .photoLibrary) { authorized in
            guard authorized else {
                return self.present(UIAlertController.cameraPermissionRequired, animated: true)
            }

            guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
                return self.present(UIAlertController.unavailableMediaSource, animated: true)
            }

            let imagePickerViewController = UIImagePickerController()

            imagePickerViewController.sourceType = .photoLibrary
            imagePickerViewController.delegate = self

            self.present(imagePickerViewController, animated: true)
        }
    }

    private func pickPhotoImage(sender: UIView) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        if let popoverController = actionSheet.popoverPresentationController {
            popoverController.sourceRect = CGRect(
                origin: CGPoint(x: sender.bounds.minX, y: sender.bounds.midY),
                size: .zero
            )

            popoverController.sourceView = sender
        }

        actionSheet.addAction(
            UIAlertAction(title: "Take Photo", style: .default, handler: { action in
                self.pickPhotoImageFromCamera()
            })
        )

        actionSheet.addAction(
            UIAlertAction(title: "Choose Photo", style: .default, handler: { action in
                self.pickPhotoImageFromPhotoLibrary()
            })
        )

        actionSheet.addAction(
            UIAlertAction(title: "Cancel", style: .cancel)
        )

        present(actionSheet, animated: true)
    }

    override func loadView() {
        view = ProfileView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        profileView.onPhotoTapped = { [unowned self] sender in
            self.pickPhotoImage(sender: sender)
        }
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        let editedImage = info[.editedImage] as? UIImage
        let originalImage = info[.originalImage] as? UIImage

        profileView.photoImage = editedImage ?? originalImage

        picker.dismiss(animated: true)
    }
}

extension UIAlertController {

    static let unavailableMediaSource: UIAlertController = {
        let alert = UIAlertController(
            title: "Error",
            message: """
                Your device does not support the selected media source.
                """,
            preferredStyle: .alert
        )

        alert.addAction(
            UIAlertAction(title: "OK", style: .default)
        )

        return alert
    }()

    static let cameraPermissionRequired: UIAlertController = {
        let alert = UIAlertController(
            title: "Permission Required",
            message: """
                The app needs permission to access your device's camera to take a photo. \
                Please go to Setting > Privacy > Camera, and enable Nivelir Example.
                """,
            preferredStyle: .alert
        )

        alert.addAction(
            UIAlertAction(title: "Not Now", style: .default)
        )

        alert.addAction(
            UIAlertAction(title: "Open Settings", style: .default, handler: { action in
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsURL)
                }
            })
        )

        return alert
    }()
}
