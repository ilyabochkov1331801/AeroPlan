//
//  MVVM.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 27.04.21.
//

import UIKit

public typealias ScreenTransition = () -> Void
public protocol ScreenTransitions { }

public protocol ViewModel {
    associatedtype Transitions: ScreenTransitions
    
    var transitions: Transitions { get set }
}

open class Screen<ScreenViewModel: ViewModel>: UIViewController, AlertViewer {
    var viewModel: ScreenViewModel
    
    var transitions: ScreenViewModel.Transitions {
        get { viewModel.transitions }
        set { viewModel.transitions = newValue }
    }
    
    init(viewModel: ScreenViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        arrangeView()
        setupView()
    }
    
    open func arrangeView() { }
    open func setupView() { }
}
