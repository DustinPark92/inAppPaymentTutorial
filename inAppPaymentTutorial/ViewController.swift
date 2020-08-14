//
//  ViewController.swift
//  inAppPaymentTutorial
//
//  Created by Dustin on 2020/08/14.
//  Copyright © 2020 Dustin. All rights reserved.
//

import UIKit

//1.
import StoreKit

let reuseIdentifier = "TableViewCell"

class ViewController: UIViewController {
    
    var productIdentifiers : Set<String> = ["com.Dustin...."] //앱 정보에서 작성했던 데이터
    var product : SKProduct?
    var productsArray = Array<SKProduct>()
    var tableView = UITableView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, left:view.leftAnchor,bottom: view.bottomAnchor,right: view.rightAnchor)
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdetifier)
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
        
        
        
    }
    
    


}

//2. SKProductsRequestDelegate : 삼품 및 결제 요청
//SKPaymentTransactionObserver 업데이트 된 거래내역 받아보기.
extension ViewController : SKProductsRequestDelegate,SKPaymentTransactionObserver {
    func requestProductData()
    {
        if SKPaymentQueue.canMakePayments() {
            let request = SKProductsRequest(productIdentifiers:
                self.productIdentifiers as Set<String>)
            request.delegate = self // -> didReceive method 실행 => 3.
            request.start()
        } else {
            print("In-App Purchases Not Enabled")
        }
    }
    //구매가 승인이 되면 상품을 사용자에게 전솔, 거래내역을 큐에서 제거.
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        //구매가 승인되면 상품을 사용자에게 전송하고 거래내역(transaction) 을 큐에서 제거
        for transaction in transactions {
            
            switch transaction.transactionState {
                
            case SKPaymentTransactionState.purchased:
                print("Transaction Approved")
                print("Product Identifier: \(transaction.payment.productIdentifier)")
                // UserDefaults에 상품을 등록 -> SKPaymentQueue.default().finishTransaction(transaction)
                 
            case SKPaymentTransactionState.failed:
                print("Transaction Failed")
                SKPaymentQueue.default().finishTransaction(transaction)
            default:
                break
            }
        }
    }
    
    
    //3. inApp 결제의 정보 / 상품 리스트 출력
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let products = response.products
        
        if products.count > 0 {

            for i in products {

                self.product = i
                self.productsArray.append(product!)
                print("id", i.productIdentifier)
            }

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

        } else {
            print("no product found")
        }
    }
    
    func buyButtonClicked(sender : UIButton) {
        let payment = SKPayment(product: productsArray[sender.tag])
        SKPaymentQueue.default().add(payment)
    }
    
    
    
    
}


extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TableViewCell
        let data = productsArray[indexPath.row]
        
        cell.button.setTitle("아아ㅏㅇ", for: .normal)
        
        return cell
    }
    
    
}

