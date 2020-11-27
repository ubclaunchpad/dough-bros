//
//  HomeView.swift
//  dough-bros-ios
//
//  Created by Alan Yan on 2020-10-09.
//

import UIKit


class SampleView: UIView {
    
    // MARK: - Subviews -
    private var middleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = " SAMPLE VC: Pay BACK $$ u 🤡"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private(set) var openLoginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle("Open Login", for: .normal)
        return button
    }()
    
    //MARK: - Initializers -
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    // REQUIRED implementation for loading views from cached storyboards since we implemented another init we need to cover the required inits, we will never use this method though
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    // MARK: - Setup -
    private func setupView() {
        backgroundColor = .white
        addSubview(middleLabel)
        addSubview(openLoginButton)
        
        NSLayoutConstraint.activate([
            middleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            middleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            openLoginButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            openLoginButton.topAnchor.constraint(equalTo: middleLabel.bottomAnchor, constant: 20)
        ])
    }
}
