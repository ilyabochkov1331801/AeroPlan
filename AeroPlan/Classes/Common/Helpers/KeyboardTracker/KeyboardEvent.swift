//
//  KeyboardEvent.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 27.05.21.
//

public extension KeyboardTracker {
    /// Keyboard events that can happen. Translates directly to `UIKeyboard` notifications from UIKit.
    enum Event {

        /// Event raised by UIKit's `.UIKeyboardWillShow`.
        case willShow

        /// Event raised by UIKit's `.UIKeyboardDidShow`.
        case didShow

        /// Event raised by UIKit's `.UIKeyboardWillShow`.
        case willHide

        /// Event raised by UIKit's `.UIKeyboardDidHide`.
        case didHide

        /// Event raised by UIKit's `.UIKeyboardWillChangeFrame`.
        case willChangeFrame

        /// Event raised by UIKit's `.UIKeyboardDidChangeFrame`.
        case didChangeFrame
        
        /// Non-keyboard based event raised by UIKit
        case unknown
    }
}
