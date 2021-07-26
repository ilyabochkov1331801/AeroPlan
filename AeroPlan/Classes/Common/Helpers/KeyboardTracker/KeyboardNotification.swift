//
//  KeyboardNotification.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 27.05.21.
//

import UIKit

public extension KeyboardTracker {
    /// An object containing the key animation properties from NSNotification
    struct Notification {

        // MARK: - Properties

        /// The event that triggered the transition
        public let event: Event

        /// The animation length the keyboards transition
        public let timeInterval: TimeInterval

        /// The animation properties of the keyboards transition
        public let animationOptions: UIView.AnimationOptions

        /// iPad supports split-screen apps, this indicates if the notification was for the current app
        public let isForCurrentApp: Bool

        /// The keyboards frame at the start of its transition
        public var startFrame: CGRect
        
        /// The keyboards frame at the beginning of its transition
        public var endFrame: CGRect
        
        /// Requires that the `NSNotification` is based on a `UIKeyboard...` event
        ///
        /// - Parameter notification: `KeyboardNotification`
        public init?(from notification: NSNotification) {
            guard notification.event != .unknown else { return nil }
            self.event = notification.event
            self.timeInterval = notification.timeInterval ?? 0.25
            self.animationOptions = notification.animationOptions
            self.isForCurrentApp = notification.isForCurrentApp ?? true
            self.startFrame = notification.startFrame ?? .zero
            self.endFrame = notification.endFrame ?? .zero
        }
    }
}

private extension NSNotification {
    var event: KeyboardTracker.Event {
        switch name {
        case UIResponder.keyboardWillShowNotification:
            return .willShow
        case UIResponder.keyboardDidShowNotification:
            return .didShow
        case UIResponder.keyboardWillHideNotification:
            return .willHide
        case UIResponder.keyboardDidHideNotification:
            return .didHide
        case UIResponder.keyboardWillChangeFrameNotification:
            return .willChangeFrame
        case UIResponder.keyboardDidChangeFrameNotification:
            return .didChangeFrame
        default:
            return .unknown
        }
    }

    var timeInterval: TimeInterval? {
        guard let value = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber else { return nil }
        return TimeInterval(truncating: value)
    }

    var animationCurve: UIView.AnimationCurve? {
        guard let index = (userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.intValue else { return nil }
        guard index >= 0 && index <= 3 else { return .linear }
        return UIView.AnimationCurve(rawValue: index) ?? .linear
    }

    var animationOptions: UIView.AnimationOptions {
        guard let curve = animationCurve else { return [] }
        switch curve {
        case .easeIn:
            return .curveEaseIn
        case .easeOut:
            return .curveEaseOut
        case .easeInOut:
            return .curveEaseInOut
        case .linear:
            return .curveLinear
        @unknown default:
            return .curveLinear
        }
    }

    var startFrame: CGRect? {
        (userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
    }

    var endFrame: CGRect? {
        (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
    }

    var isForCurrentApp: Bool? {
        (userInfo?[UIResponder.keyboardIsLocalUserInfoKey] as? NSNumber)?.boolValue
    }
}
