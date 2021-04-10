//
//  ParentExpenseViewController.swift
//  dough-bros-ios
//
//  Created by Wren Liang on 2021-03-31.
//

import Foundation
import UIKit
import Firebase
import FirebaseUI
import Charts

class ParentExpenseView: UIView {
    var parentExpenseObj: ParentGroupExpenseObj?
    var paymentObj: PaymentBothNamesObj? {
        didSet {
            populateUIWithData()
        }
    }
    
    private(set) var popupSubview: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        view.backgroundColor = UIColor(hexString: "#DEE8F4", alpha: 1.0)
        view.layer.opacity = 0.95
        return view
    }()
    
    private(set) var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = "Title Label"
        label.font = .customFont(ofSize: 18.0, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private(set) var expenseDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = "Description Label"
        label.font = .customFont(ofSize: 16.0, weight: .light)
        label.textColor = .darkGray
        return label
    }()
    
    private(set) var pieChart: PieChartView = {
        let chart = PieChartView()
        chart.drawHoleEnabled = false
        chart.rotationAngle = 90.0
        return chart
    }()
    
    private(set) var originalExpenseAmount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = "Original Expense Label"
        label.font = .customFont(ofSize: 16.0, weight: .light)
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        self.backgroundColor = .clear
        
        addSubview(popupSubview)
        addSubview(titleLabel)
        addSubview(expenseDescription)
        addSubview(pieChart)
        addSubview(originalExpenseAmount)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        /// popupSubview
        NSLayoutConstraint.activate([
            popupSubview.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0.0),
            popupSubview.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0.0),
            popupSubview.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            popupSubview.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8)
        ])
        
        /// titleText
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: popupSubview.topAnchor, constant: 20.0),
            titleLabel.leftAnchor.constraint(equalTo: popupSubview.leftAnchor, constant: 20.0),
            titleLabel.widthAnchor.constraint(equalTo: popupSubview.widthAnchor, constant: -40.0),
        ])
        
        /// expenseDescription
        NSLayoutConstraint.activate([
            expenseDescription.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0.0),
            expenseDescription.leftAnchor.constraint(equalTo: popupSubview.leftAnchor, constant: 20.0),
            expenseDescription.widthAnchor.constraint(equalTo: popupSubview.widthAnchor, constant: -40.0)
        ])
        
        /// pieChart
        pieChart.addTop(anchor: expenseDescription.bottomAnchor, constant: 20.0)
        pieChart.addHeight(withConstant: 250)
        pieChart.addCenterX(anchor: popupSubview.centerXAnchor, constant: 0.0)
        pieChart.addWidth(withConstant: 250)
        
        /// originalExpenseAmount
        NSLayoutConstraint.activate([
            originalExpenseAmount.topAnchor.constraint(equalTo: pieChart.bottomAnchor, constant: 20.0),
            originalExpenseAmount.leftAnchor.constraint(equalTo: popupSubview.leftAnchor, constant: 20.0),
            originalExpenseAmount.widthAnchor.constraint(equalTo: popupSubview.widthAnchor, constant: -40.0)
        ])
    }
    
    func populateUIWithData() {
        guard let payment = paymentObj else { return }
        let payerIsYou = payment.fk_sender_id == Auth.auth().currentUser?.uid
        titleLabel.text = generateOwesTitleFromPayment(payment)
        
        let expenseData = GroupExpenseEndpoints.getParentGroupExpenseByPaymentId(paymentId: "\(payment.payment_id)")
        if expenseData.count > 0 {
            parentExpenseObj = expenseData[0]
            
            let yourAmount = payment.amount
            let totalAmount = parentExpenseObj!.amount
            
            setChartData(yourAmount: yourAmount, totalAmount: totalAmount, yourLabel: payerIsYou ? "You" : payment.first_name_sender)
            expenseDescription.text = parentExpenseObj!.expense_name
            
            let userData = UserEndpoints.getUserByID(ID: parentExpenseObj!.fk_added_by_id)
            if (userData.count > 0) {
                let user = userData[0]
                
                let yourPercentage = getTwoDecimalPercentage(yourAmount: yourAmount, totalAmount: totalAmount)
                
                let text = payerIsYou ?
                    "Your $\(yourAmount) payment is \(yourPercentage)% of a $\(totalAmount) total paid by \(user.first_name) \(user.last_name)" :
                    "\(payment.first_name_sender)'s $\(yourAmount) payment is \(yourPercentage)% of a $\(totalAmount) total paid by \(user.first_name) \(user.last_name)"
                
                originalExpenseAmount.text = text
            }
        }
    }
    
    private func setChartData(yourAmount: Double, totalAmount: Double, yourLabel: String) {
        let yourRounded = getTwoDecimalPercentage(yourAmount: yourAmount, totalAmount: totalAmount)
        let groupRounded = 100.0 - yourRounded
        
        let entries = [
            PieChartDataEntry(value: yourRounded, label: yourLabel),
            PieChartDataEntry(value: groupRounded, label: "Others")
        ]
        
        let dataSet = PieChartDataSet(entries)
        dataSet.label = ""
        
        // Description
        dataSet.entryLabelColor = .black
        // Percentage
        dataSet.valueTextColor = .black
        // Pie slice colors
        dataSet.setColors(UIColor(hexString: "#FFFCDB", alpha: 1.0), UIColor(hexString: "#EE786C", alpha: 1.0))
        
        let data = PieChartData(dataSet: dataSet)
        pieChart.data = data
        pieChart.notifyDataSetChanged()
        
        pieChart.drawHoleEnabled = true
        pieChart.holeRadiusPercent = 0.25
        pieChart.transparentCircleRadiusPercent = 0.30
    }
    
    private func getTwoDecimalPercentage(yourAmount: Double, totalAmount: Double) -> Double {
        let yourPercentage = (yourAmount/totalAmount) * 100
        let yourRounded = (yourPercentage * 100).rounded() / 100
        return yourRounded
    }
}

class ParentExpenseViewController: UIViewController {
    private var parentExpenseView: ParentExpenseView {
        return self.view as! ParentExpenseView
    }
    
    var paymentObj: PaymentBothNamesObj?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let peView = ParentExpenseView()
        peView.paymentObj = paymentObj
        
        self.view = peView
    }
    
}



#if DEBUG
import SwiftUI

struct InfoVCRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // leave this empty
    }
    
    @available(iOS 13.0.0, *)
    func makeUIViewController(context: Context) -> UIViewController {
        ParentExpenseViewController()
    }
}

struct Preview: PreviewProvider {
    static var previews: some View {
       InfoVCRepresentable()
    }
}
#endif
