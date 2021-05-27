//
//  KeyboardTracker.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 27.05.21.
//

import UIKit

public class KeyboardTracker: NSObject {
    public private(set) var isTracking = false
    public private(set) var isKeyboardHidden = true
    
    private var notificationCenter: NotificationCenter
    private var trackNotificationHandler: TrackNotificationClosure
    private var lastNotification: Notification?

    public init(trackNotification: @escaping KeyboardTracker.TrackNotificationClosure, notificationCenter: NotificationCenter = .default) {
        self.trackNotificationHandler = trackNotification
        self.notificationCenter = notificationCenter

        super.init()
        
        registerForNotifications()
    }

    deinit {
        notificationCenter.removeObserver(self)
    }
}

// MARK: - Public API
public extension KeyboardTracker {
    typealias TrackNotificationClosure = (_ notification: KeyboardTracker.Notification) -> Void

    func startTracking() {
        isTracking = true

        guard let lastNotification = lastNotification else { return }
        trackNotification(lastNotification)
    }

    func stopTracking() {
        isTracking = false
    }
}

// MARK: - Private
private extension KeyboardTracker {
    @objc func keyboardWillShow(_ notification: NSNotification) { trackNotification(notification) }
    @objc func keyboardDidShow(_ notification: NSNotification) { trackNotification(notification) }
    @objc func keyboardWillChangeFrame(_ notification: NSNotification) { trackNotification(notification) }
    @objc func keyboardDidChangeFrame(_ notification: NSNotification) { trackNotification(notification) }
    @objc func keyboardWillHide(_ notification: NSNotification) { trackNotification(notification) }
    @objc func keyboardDidHide(_ notification: NSNotification) { trackNotification(notification) }
    
    func trackNotification(_ notification: NSNotification) {
        guard let keyboardNotification = Notification(from: notification) else { return }

        lastNotification = keyboardNotification
        switch keyboardNotification.event {
        case .didHide:
            isKeyboardHidden = true
        case .didShow:
            isKeyboardHidden = false
        default:
            break
        }

        trackNotification(keyboardNotification)
    }

    func trackNotification(_ notification: KeyboardTracker.Notification) {
        guard notification.isForCurrentApp && isTracking else { return }
        trackNotificationHandler(notification)
    }

    func registerForNotifications() {
        notificationCenter.addObserver(self,
                                       selector: #selector(KeyboardTracker.keyboardWillShow(_:)),
                                       name: UIResponder.keyboardWillShowNotification,
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(KeyboardTracker.keyboardDidShow(_:)),
                                       name: UIResponder.keyboardDidShowNotification,
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(KeyboardTracker.keyboardWillHide(_:)),
                                       name: UIResponder.keyboardWillHideNotification,
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(KeyboardTracker.keyboardDidHide(_:)),
                                       name: UIResponder.keyboardDidHideNotification,
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(KeyboardTracker.keyboardWillChangeFrame(_:)),
                                       name: UIResponder.keyboardWillChangeFrameNotification,
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(KeyboardTracker.keyboardDidChangeFrame(_:)),
                                       name: UIResponder.keyboardDidChangeFrameNotification,
                                       object: nil)
    }
}
