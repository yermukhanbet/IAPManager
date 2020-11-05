import UIKit
import StoreKit

class IAPManager: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    private var products = [SKProduct]()
    private var productBeingPurchase: SKProduct?
    static let shared = IAPManager()
    enum Product: String, CaseIterable{
        case buyCoin = "com.whosfan.coins"
    }
    //Fetch Product objects from Apple
    public func fetchProducts(yourId: String){
        let request = SKProductsRequest(productIdentifiers: [yourId])
        request.delegate = self
        request.start()
    }
    //Prompt a product payment transaction
    public func purchase(product: SKProduct){
        guard SKPaymentQueue.canMakePayments() else{
            print("can not make payments")
            //MARK:Show UI user does not have payment card
            return
        }
        productBeingPurchase = product
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(payment)
    }
    //Observe the transaction state
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach({ transaction in
            switch transaction.transactionState{
            case .purchasing:
                print("purchasing")
                break
            case .purchased:
                print("purchased")
                SKPaymentQueue.default().finishTransaction(transaction)
                handlePurchase()
                break
            case .restored:
                break
            case .failed:
                print("failed")
                SKPaymentQueue.default().finishTransaction(transaction)
                break
            case .deferred:
                print("deferred")
                break
            @unknown default:
                break
            }
        })
    }
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        purchase(product: response.products.first!)
    }
    func request(_ request: SKRequest, didFailWithError error: Error) {
        guard request is SKProductsRequest else{
            return
        }
        //MARK: Show UI
        print("Product fwtch request failed")
    }
    func handlePurchase(){
    }
}
