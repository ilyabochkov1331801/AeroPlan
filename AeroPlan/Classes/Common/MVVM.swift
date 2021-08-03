//
//  MVVM.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 27.04.21.
//

import RxCocoa
import RxSwift
import UIKit

typealias ScreenTransition = () -> Void
protocol ScreenTransitions { }

protocol ViewModel: AnyObject, EventsHandler {
    associatedtype Transitions: ScreenTransitions
    
    var transitions: Transitions { get set }
    var activity: Driver<Bool> { get }
}

extension Reactive where Base: ViewModel {
    var errors: Binder<AppError> {
        Binder(base) { viewModel, error in
            viewModel.showError(error)
        }
    }
}

class Screen<ScreenViewModel: ViewModel>: UIViewController {
    let disposeBag = DisposeBag()
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
        viewModel.activity
            .do(onNext: { [weak self] isActive in
                self?.activityIndicator.isHidden = !isActive
                self?.view.isUserInteractionEnabled = !isActive
            })
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
    }
}
