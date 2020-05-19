//
//  AddRadiosNavigationItem.swift
//  Pods
//
//  Created by Guillermo Andrés Sáenz Urday on 5/10/20.
//

import UIKit
import RxSwift
import RxCocoa
import WaqayKit
import PATools

class AddRadiosRootNavigationItem: UINavigationItem {
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    private unowned var viewModel: AddRadiosViewModel!
    
    private let disposeBag = DisposeBag()
    
    public func inject(viewModel: AddRadiosViewModel) {
        self.viewModel = viewModel
        
        bindViewModelToViews()
        setup()
    }

    private func setup() {
        title = viewModel.title()
    }
}

extension AddRadiosRootNavigationItem {
    @IBAction func doDoneAction(_ sender: Any) {
        viewModel.didFinishAddingRadios()
    }
}

// MARK: - Dynamic behavior
private extension AddRadiosRootNavigationItem {

  func bindViewModelToViews() {
    bindViewModelToDoneButton()
  }

  func bindViewModelToDoneButton() {
    viewModel
      .doneButtonEnabled
      .asDriver(onErrorJustReturn: true)
      .drive(doneBarButton.rx.isEnabled)
      .disposed(by: disposeBag)
  }
}

