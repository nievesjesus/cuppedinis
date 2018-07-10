//
//  ViewController.swift
//  Cuppedinis
//
//  Created by Jesus Nieves on 7/7/18.
//  Copyright © 2018 Jesus Nieves. All rights reserved.
//

import UIKit
import TTGSnackbar

class MainViewController: BaseViewController {
    
    
    @IBOutlet weak var numViewContainer: UIView!
    var paymentModel: PaymentModelController!
    
    lazy var containerView: UIView = { [unowned self] in
        let containerView = UIView()
        containerView.layer.borderColor = UIColor.clear.cgColor
        containerView.layer.borderWidth = 1
        self.numViewContainer.addSubview(containerView)
        self.numViewContainer.backgroundColor = UIColor.clear
        containerView.constrainToEdges()
        return containerView
        }()
    
    lazy var textField: UITextField = { [unowned self] in
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .right
        textField.textColor = UIColor.white
        textField.font = .systemFont(ofSize: 40)
        textField.placeholder = "0".currency()
        textField.isEnabled = false
        self.containerView.addSubview(textField)
        return textField
        }()
    
    lazy var numPad: NumPad = { [unowned self] in
        let numPad = DefaultNumPad()
        numPad.delegate = self
        numPad.translatesAutoresizingMaskIntoConstraints = false
        numPad.backgroundColor = self.borderColor
        self.containerView.addSubview(numPad)
        return numPad
        }()
    
    let borderColor = UIColor.clear
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let views: [String : Any] = ["textField": textField, "numPad": numPad]
        containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[textField]-20-|", options: [], metrics: nil, views: views))
        containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[numPad]|", options: [], metrics: nil, views: views))
        containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[textField(==120)][numPad]|", options: [], metrics: nil, views: views))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        numPad.invalidateLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let pm = paymentModel {
            if pm.payment.completed == true {
                let message = "Monto: \(pm.payment.amount), \nMedio de pago: \(pm.payment.paymentMethodName), \nBanco: \(pm.payment.issuerName), \nCuotas: \(pm.payment.payerCostDescription)"
                let alert = UIAlertController(title: "Haz completado el proceso de pago", message: message, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { action in
                    self.paymentModel = PaymentModelController()
                    self.textField.text = nil
                }))
                self.present(alert, animated: true)
            }
        }
    }
    @IBAction func nextPressed(_ sender: Any) {
        
        if (textField.text == nil || textField.text == "") {
            let snackbar = TTGSnackbar(message: "Debe ingresar un monto para continuar", duration: .middle)
            snackbar.backgroundColor = UIColor.pinkishRed
            snackbar.show()
            return
        }
        paymentModel = PaymentModelController()
        paymentModel.payment.amount = textField.text!
        paymentModel.payment.amountValue = (textField.text?.fromCurrency())!

        
        let NavigationController = AppStoryboard.Payment.instance.instantiateViewController(withIdentifier: "PaymentNavigation") as! UINavigationController
        let viewController = AppStoryboard.Payment.instance.instantiateViewController(withIdentifier: "PaymentMethodsViewController") as! PaymentMethodsViewController
        viewController.paymentModel = paymentModel
        NavigationController.addChildViewController(viewController)
        self.present(NavigationController, animated: true, completion: nil)
    }
    
}

extension MainViewController: NumPadDelegate {
    
    func numPad(_ numPad: NumPad, itemTapped item: Item, atPosition position: Position) {
        switch (position.row, position.column) {
        case (3, 2):
            textField.text = nil
        default:
            let item = numPad.item(for: position)!
            let string = textField.text!.sanitized() + item.title!
            if Int(string) == 0 {
                textField.text = nil
            } else {
                textField.text = string.currency()
            }
        }
    }
    
}

