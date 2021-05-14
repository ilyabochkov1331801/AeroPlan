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
        setupBinding()
    }
    
    open func arrangeView() { }
    open func setupView() { }
    open func setupBinding() { }
}

extension Screen {
    var showError: (AppError) -> Void {
        return { [weak self] error in // swiftlint:disable:this implicit_return
            self?.alertCoordinator.showError(error: error)
        }
    }
}
