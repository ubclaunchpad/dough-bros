//
//  PayConfirmationView.swift
//  dough-bros-ios
//
//  Created by Harin Wu on 2020-11-27.
//

import UIKit

class PayConfirmationView: UIView {
    
    private(set) var backButton: UIButton = {
        let back = UIButton(type: .system)
        back.translatesAutoresizingMaskIntoConstraints = false
        back.contentHorizontalAlignment = .fill
        back.contentVerticalAlignment = .fill
        back.imageView?.contentMode = .scaleAspectFit
        back.setImage(UIImage(named: "BackButton"), for: .normal)
        back.tintColor = .black
        return back
    }()
    
    private(set) var nextButton: UIButton = {
        let back = UIButton()
        back.translatesAutoresizingMaskIntoConstraints = false
        back.contentHorizontalAlignment = .fill
        back.contentVerticalAlignment = .fill
        back.imageView?.contentMode = .scaleAspectFit
        back.setImage(UIImage(named: "NextButton"), for: .normal)
        back.tintColor = .black
        return back
    }()
    
    private(set) var userImageFrom: UIImageView = {
        let image = UIImage(named: "SampleImage.png")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        imageView.contentMode = .center
        return imageView
    }()
    
    private(set) var toArrow: UIImageView = {
        let image = UIImage(named: "Arrow.png")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.contentMode = .center
        return imageView
    }()
    
    private(set) var userImageTo: UIImageView = {
        let image = UIImage(named: "SampleImage.png")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        imageView.contentMode = .center
        return imageView
    }()

    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Gary paid you"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private(set) var debtAmount: UITextField = {
        let amount = UITextField()
        amount.translatesAutoresizingMaskIntoConstraints = false
        amount.keyboardType = .decimalPad
        amount.placeholder = "$10"
        amount.textColor = .black
        amount.font = UIFont.systemFont(ofSize: 30)
        amount.textAlignment = .center
        return amount
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
        
        addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            backButton.widthAnchor.constraint(equalToConstant: 20),
            backButton.heightAnchor.constraint(equalToConstant: 20),
            backButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 20)
        ])
        
        addSubview(toArrow)
        NSLayoutConstraint.activate([
            toArrow.centerXAnchor.constraint(equalTo: centerXAnchor),
            toArrow.centerYAnchor.constraint(equalTo: topAnchor, constant: 200)
        ])
        addSubview(userImageFrom)
        NSLayoutConstraint.activate([
            userImageFrom.rightAnchor.constraint(equalTo: toArrow.leftAnchor, constant: -20),
            userImageFrom.centerYAnchor.constraint(equalTo: toArrow.centerYAnchor),
            userImageFrom.widthAnchor.constraint(equalToConstant: 100),
            userImageFrom.heightAnchor.constraint(equalToConstant: 100)
        ])
        addSubview(userImageTo)
        NSLayoutConstraint.activate([
            userImageTo.leftAnchor.constraint(equalTo: toArrow.rightAnchor, constant: 20),
            userImageTo.centerYAnchor.constraint(equalTo: toArrow.centerYAnchor),
            userImageTo.widthAnchor.constraint(equalToConstant: 100),
            userImageTo.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: userImageFrom.bottomAnchor, constant: 30)
        ])
        
        addSubview(debtAmount)
        NSLayoutConstraint.activate([
            debtAmount.centerXAnchor.constraint(equalTo: centerXAnchor),
            debtAmount.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30)
        ])
        
        addSubview(nextButton)
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: debtAmount.bottomAnchor, constant: 100),
            nextButton.widthAnchor.constraint(equalToConstant: 50),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(lowerKeyboard))
        tapGesture.cancelsTouchesInView = false
        addGestureRecognizer(tapGesture)
    }

    @objc func lowerKeyboard() {
        endEditing(true)
    }

}
