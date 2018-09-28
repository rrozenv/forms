//
//  CBMConfirmationViewController.swift
//  FormLibrary
//
//  Created by Robert Rozenvasser on 9/27/18.
//  Copyright © 2018 Cluk Labs. All rights reserved.
//

import Foundation
import UIKit

final class CBMConfirmationViewController: UIViewController {
    
    struct UIConfig {
        let image: UIImage?
        let topLabelText: String?
        let bottomLabelText: String?
    }
    
    private let imageView = UIImageView()
    private let topLabel = UILabel()
    private let bottomLabel = UILabel()
    private var timer: Timer!
    
    // MARK: Timer Completed Closure
    var timerCompleted: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTimer()
        setupGeneralUIProperties()
        setupConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
    
    // MARK: Public Interface
    func configureUI(with config: UIConfig) {
        imageView.image = config.image
        topLabel.text = config.topLabelText
        bottomLabel.text = config.bottomLabelText
    }
    
    private func setupGeneralUIProperties() {
        topLabel.numberOfLines = 0
        topLabel.textAlignment = .center
        bottomLabel.textAlignment = .center
        bottomLabel.numberOfLines = 0
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .red
    }
    
    // MARK: Timer Action
    @objc func timerDidComplete() {
        timerCompleted?()
    }
    
}

extension CBMConfirmationViewController {
    
    private func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(timerDidComplete), userInfo: nil, repeats: true)
    }
    
    private func setupConstraints() {
        let labelsStackView = UIStackView(arrangedSubviews: [topLabel, bottomLabel])
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 2.0
        labelsStackView.distribution = .equalSpacing
        
        imageView.anchor(widthConstant: 100, heightConstant: 100)
        
        let containerStackView = UIStackView(arrangedSubviews: [imageView, labelsStackView])
        containerStackView.axis = .vertical
        containerStackView.spacing = 10.0
        containerStackView.alignment = .center
        containerStackView.distribution = .fill
        
        view.addSubview(containerStackView)
        containerStackView.anchorCenterSuperview()
        containerStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
    }
    
}
