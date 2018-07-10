//
//  CardIssuerViewController.swift
//  Cuppedinis
//
//  Created by Jesus Nieves on 8/7/18.
//  Copyright © 2018 Jesus Nieves. All rights reserved.
//

import UIKit
import TTGSnackbar
import NVActivityIndicatorView

class CardIssuerViewController: BaseViewController {
    
    @IBOutlet weak var lblAmount: UILabel!
    var paymentModel: PaymentModelController!
    @IBOutlet weak var collectionView: UICollectionView!
    var issuers:[Issuer]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initView (){
        
        self.title = "Selección de banco"
        
        self.issuers = [Issuer]()
        
        self.collectionView.register(UINib(nibName: "PaymentMethodCell", bundle: nil), forCellWithReuseIdentifier: "PaymentMethodCell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView?.contentInset = UIEdgeInsets(top: 109, left: 10, bottom: 20, right: 10)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        layout.itemSize = CGSize(width: self.view.bounds.size.width, height: 76)
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        self.collectionView!.collectionViewLayout = layout
        self.initData()
        
        let backIcon = UIBarButtonItem(image: UIImage(named: "back"), landscapeImagePhone: nil, style: .done, target: self, action: #selector(backPressed(_:)))
        self.navigationItem.leftBarButtonItems = [backIcon]
    }
    
    func initData (){
        
        lblAmount.text = paymentModel.payment.amount
        
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(self.activityData)
        
        Cuppedinis.getCardIssuers(payment: paymentModel.payment, success: { (response) in
            self.issuers = response
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
    
    
}

extension CardIssuerViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return issuers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : PaymentMethodCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PaymentMethodCell", for: indexPath) as! PaymentMethodCell
        cell.methodView.backgroundColor = indexPath.row % 2 == 0 ? UIColor.azureBlue : UIColor.sapphireBlue
        cell.issuer = self.issuers[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let issuer = issuers[indexPath.row]
        paymentModel.payment.issuerId = issuer.id!
        paymentModel.payment.issuerName = issuer.name!
        
        let viewController = AppStoryboard.Payment.instance.instantiateViewController(withIdentifier: "InstallmentsViewController") as! InstallmentsViewController
        viewController.paymentModel = paymentModel
        
        let transition:CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        transition.subtype = kCATransitionFromBottom
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        self.navigationController?.pushViewController(viewController, animated: false)
    }
}
