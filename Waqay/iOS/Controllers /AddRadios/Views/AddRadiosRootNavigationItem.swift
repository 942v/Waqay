//
//  AddRadiosNavigationItem.swift
//  Waqay
//
//  Created by Guillermo Andrés Sáenz Urday on 5/10/20.
//

import UIKit
import WaqayKit
import RxSwift

class AddRadiosRootNavigationItem: UINavigationItem {
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    private var viewModel: AddRadioStationsListViewModelInput!
    
    private let disposeBag = DisposeBag()
    
    public func inject(
        viewModel: AddRadioStationsListViewModelInput
    ) {
        self.viewModel = viewModel
        
        bindViewModelToViews()
        setup()
    }

    private func setup() {
        title = R.string.addRadioStations.title()
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

