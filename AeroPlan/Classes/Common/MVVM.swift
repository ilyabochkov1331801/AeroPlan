//
//  MVVM.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 27.04.21.
//

import UIKit

typealias ScreenTransition = () -> Void
protocol ScreenTransitions { }

protocol ViewModel {
    associatedtype Transitions: ScreenTransitions
    
    var transitions: Transitions { get set }
}

protocol Screen: AlertViewer {
    associatedtype ScreenViewModel: ViewModel
    
    var viewModel: ScreenViewModel { get set }
}
