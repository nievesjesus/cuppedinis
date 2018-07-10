//
//  InstallmentsViewController.swift
//  Cuppedinis
//
//  Created by Jesus Nieves on 8/7/18.
//  Copyright © 2018 Jesus Nieves. All rights reserved.
//

import UIKit
import TTGSnackbar
import NVActivityIndicatorView

class InstallmentsViewController: BaseViewController {
    
    @IBOutlet weak var lblBank: UILabel!
    @IBOutlet weak var lblMethod: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    var paymentModel: PaymentModelController!
    @IBOutlet weak var collectionView: UICollectionView!
    var payerCosts:[payerCost]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initView (){
        
        self.payerCosts = [payerCost]()
        
        self.collectionView.register(UINib(nibName: "InstallmentCell", bundle: nil), forCellWithReuseIdentifier: "InstallmentCell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView?.backgroundColor = UIColor.clear
        self.collectionView?.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        layout.itemSize = CGSize(width: 140, height: 140)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        self.collectionView!.collectionViewLayout = layout
        
        let backIcon = UIBarButtonItem(image: UIImage(named: "back"), landscapeImagePhone: nil, style: .done, target: self, action: #selector(backPressed(_:)))
        self.navigationItem.leftBarButtonItems = [backIcon]
        
        
        self.initData()
    }
    
    func initData (){
        
        lblBank.text = paymentModel.payment.issuerName
        lblAmount.text = paymentModel.payment.amount
        lblMethod.text = paymentModel.payment.paymentMethodName
        
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(self.activityData)
        
        Cuppedinis.getInstallments(payment: paymentModel.payment, success: { (response) in
            self.payerCosts = response[0].payerCosts
            self.collectionView.reloadData()
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        }, error: { (error) in
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            let snackbar = TTGSnackbar(message: "Ha ocurrido un error obteniendo el contenido", duration: .middle)
            snackbar.backgroundColor = UIColor.pinkishRed
            snackbar.show()
        }, failure: { (error) in
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            let snackbar = TTGSnackbar(message: "No se ha podido conectar al servidor", duration: .middle)
            snackbar.backgroundColor = UIColor.pinkishRed
            snackbar.show()
        })
    }
    
    @IBAction func backPressed (_ sender: Any) {
        
        let transition:CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        transition.subtype = kCATransitionFromBottom
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func finishPressed(_ sender: Any) {
        
        if self.paymentModel.payment.payerCostDescription == "" {
            let snackbar = TTGSnackbar(message: "Por favor seleccione una cuota", duration: .middle)
            snackbar.backgroundColor = UIColor.pinkishRed
            snackbar.show()
            return
        }
        
        self.paymentModel.payment.completed = true
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
}

extension InstallmentsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return payerCosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : InstallmentCell = collectionView.dequeueReusableCell(withReuseIdentifier: "InstallmentCell", for: indexPath) as! InstallmentCell
        let payer = self.payerCosts[indexPath.row]
        cell.payerCost = payer
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let payer = self.payerCosts[indexPath.row]
        self.paymentModel.payment.payerCostDescription = payer.recommendedMessage!

    }
}
