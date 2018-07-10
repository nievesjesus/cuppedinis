//
//  PaymentMethodsViewController.swift
//  Cuppedinis
//
//  Created by Jesus Nieves on 7/7/18.
//  Copyright © 2018 Jesus Nieves. All rights reserved.
//

import UIKit
import TTGSnackbar
import NVActivityIndicatorView

class PaymentMethodsViewController: BaseViewController {

    @IBOutlet weak var lblAmount: UILabel!
    var paymentModel: PaymentModelController!
    @IBOutlet weak var collectionView: UICollectionView!
    var paymentMethods:[PaymentMethod]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func initView (){
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isOpaque = false
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes =  [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.title = "Selección de medio de pago"
        
        self.paymentMethods = [PaymentMethod]()
        
        self.collectionView.register(UINib(nibName: "CardCell", bundle: nil), forCellWithReuseIdentifier: "CardCell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView?.contentInset = UIEdgeInsets(top: 109, left: 0, bottom: 20, right: 0)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        layout.itemSize = CGSize(width: (self.view.bounds.size.width / 2) - 10, height: (self.view.bounds.size.width * 0.2866))
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 15
        self.collectionView!.collectionViewLayout = layout
        self.initData()
        
        let backIcon = UIBarButtonItem(image: UIImage(named: "back"), landscapeImagePhone: nil, style: .done, target: self, action: #selector(closePressed(_:)))
        self.navigationItem.leftBarButtonItems = [backIcon]

    }
    
    func initData (){
        
        lblAmount.text = self.paymentModel.payment.amount
        
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(self.activityData)
        
        Cuppedinis.getPaymentMethods(success: { (response) in
            self.paymentMethods = response
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
    
    @IBAction func closePressed (_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension PaymentMethodsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return paymentMethods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : CardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
        cell.methodView.backgroundColor = indexPath.row % 2 == 0 ? UIColor.cyberYellow : UIColor.gold
        cell.paymentMethod = self.paymentMethods[indexPath.row]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let paymentMethod = paymentMethods[indexPath.row]
        paymentModel.payment.paymentMethodId = paymentMethod.id!
        paymentModel.payment.paymentMethodName = paymentMethod.name!
        
        let viewController = AppStoryboard.Payment.instance.instantiateViewController(withIdentifier: "CardIssuerViewController") as! CardIssuerViewController
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
