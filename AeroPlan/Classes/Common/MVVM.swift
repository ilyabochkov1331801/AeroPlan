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
    var errorOccurred: ((AppError) -> Void)? { get set }
    var activity: ((Bool) -> Void)? { get set }
}

open class Screen<ScreenViewModel: ViewModel>: UIViewController, AlertViewer {
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
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
    
    func arrangeView() {
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func setupView() {
        activityIndicator.isHidden = true
    }
    
    func setupBinding() {
        viewModel.errorOccurred = showError
        viewModel.activity = { [weak self] in $0 ? self?.startActivity() : self?.endActivity() }
    }
    
    func startActivity() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
    }
    
    func endActivity() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        view.isUserInteractionEnabled = true
    }
}

extension Screen {
    var showError: (AppError) -> Void {
        return { [weak self] error in // swiftlint:disable:this implicit_return
            self?.alertCoordinator.showError(error: error)
        }
    }
}
