//
//  AddExpenseDropDownView.swift
//  dough-bros-ios
//
//  Created by Alan Yan on 2020-11-28.
//

import UIKit
import AlanYanHelpers

class AddExpenseDropDownView: UIView {

    private(set) var topButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(hex: 0x2C365A), for: .normal)
        button.titleLabel?.font = .customFont(ofSize: 14)
        return button
    }()
    
    private var lineView = UIView()
    
    private(set) var bottomButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(hex: 0x2C365A), for: .normal)
        button.titleLabel?.font = .customFont(ofSize: 14)
        button.clipsToBounds = true
        return button
    }()
    
    private(set) var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.down")
        imageView.tintColor = UIColor(hex: 0x2C365A)
        return imageView
    }()
    
    var viewState: State = .collapsed {
        didSet {
            updateView()
        }
    }
    
    override class var requiresConstraintBasedLayout: Bool { return true }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        updateView()
    }
    
    private func setupView() {
        topButton.setSuperview(self).addTop().addLeading().addTrailing().addHeight(withConstant: 40)
        
        lineView.setSuperview(self).addTop(anchor: topButton.bottomAnchor).addLeading(constant: 10).addTrailing(constant: -10).addHeight(withConstant: 1).setColor(UIColor.gray.withAlphaComponent(0.1))
        bottomButton.setSuperview(self).addTop(anchor: lineView.bottomAnchor).addLeading().addTrailing().addHeight(withConstant: 0)
        
        arrowImageView.setSuperview(self).addTrailing(constant: -15).addCenterY(anchor: topButton.centerYAnchor).addWidth(withConstant: 20).addHeight(withConstant: 20)
    }
    
    private func updateView() {
        if viewState == .collapsed {
            lineView.userDefinedConstraintDict["height"]?.constant = 0
        } else {
            lineView.userDefinedConstraintDict["height"]?.constant = 1
        }
        
        UIView.animate(withDuration: 0.5) { [self] in
            arrowImageView.alpha = viewState == .collapsed ? 1 : 0
            layoutIfNeeded()
        }
    }
    
    func updateSelectedState(to state: AddExpenseView.SelectedState) {
        UIView.performWithoutAnimation {
            topButton.setTitle(state.getTitle(), for: .normal)
            bottomButton.setTitle((state == .splitEqually ? AddExpenseView.SelectedState.customSplit : .splitEqually).getTitle(), for: .normal)
            layoutIfNeeded()
        }
    }
    
    enum State {
        case expanded
        case collapsed
    }
}
