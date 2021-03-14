//
//  AddRadiosRootLoadingView.swift
//  Waqay
//
//  Created by Guillermo Sáenz on 5/16/20.
//

import UIKit
import PATools

public class AddRadioStationsRootLoadingView: NiblessView {
    
    private var hierarchyNotReady = true
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView.init(arrangedSubviews: [
            centerLabel,
            activityIndicator
        ])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16
        return stackView
    }()
    
    let centerLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.addRadioStations.loading()
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }()
    
    // MARK: Methods
    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
    }
    
    public override func didMoveToWindow() {
        super.didMoveToWindow()
        guard hierarchyNotReady else {
            return
        }
        constructHierarchy()
        activateConstraints()
        
        hierarchyNotReady = false
    }
    
    func constructHierarchy() {
        addSubview(mainStackView)
    }
    
    func activateConstraints() {
        activateConstraintsMainStackView()
    }
}

extension AddRadioStationsRootLoadingView {
    
    // MARK: Layout
    func activateConstraintsMainStackView() {
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        let centerX = mainStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let centerY = mainStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        NSLayoutConstraint.activate([centerX, centerY])
    }
}
