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
protocol ScreenTransitions {
    init()
}

class ViewModel<Transitions: ScreenTransitions>: EventsHandler {    
    var transitions = Transitions()
    
    let activitySubject = PublishRelay<Bool>()
    var activity: Driver<Bool> {
        activitySubject
            .asDriver(onErrorJustReturn: false)
    }
    
    var error: Binder<AppError> {
        Binder(self) { base, error in
            base.handleError(error)
        }
    }
}

class Screen<Transitions: ScreenTransitions, ScreenViewModel: ViewModel<Transitions>>: UIViewController {
    private let activityIndicator = UIActivityIndicatorView(style: .large)

    let disposeBag = DisposeBag()
    
    var viewModel: ScreenViewModel
    
    var transitions: Transitions {
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
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.activity
            .map { !$0 }
            .drive(activityIndicator.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.activity
            .map { !$0 }
            .drive(view.rx.isUserInteractionEnabled)
            .disposed(by: disposeBag)
    }
}
