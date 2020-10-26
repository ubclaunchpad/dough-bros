//
//  GroupDetailsView.swift
//  dough-bros-ios
//
//  Created by Alan Yan on 2020-10-25.
//

import UIKit

class GroupDetailsView: UIView {

    // MARK: - Subviews -
    private var sampleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .orange
        label.text = "Groups Details View"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
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
        addSubview(sampleLabel)
        
        NSLayoutConstraint.activate([
            sampleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            sampleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
