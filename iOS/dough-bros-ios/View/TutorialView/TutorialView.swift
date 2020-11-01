//
//  TutorialView.swift
//  dough-bros-ios
//
//  Created by Carlos Georgescu on 2020-10-31.
//

import UIKit

class TutorialView: UIView {
    
    // MARK: - Subviews -
    private var backButton: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .yellow
        label.text = "Back"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    private var forwardButton: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .yellow
        label.text = "Forward"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    private var skipButton: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .yellow
        label.text = "Skip"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        addSubview(backButton)
        addSubview(skipButton)
        addSubview(forwardButton)
        
        NSLayoutConstraint.activate([
            backButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 20),
            forwardButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            backButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 40),
            backButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            skipButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 100),
            skipButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

