//
//  AppStoreViewModel.swift
//  PhysiologyQuiz
//
//  Created by Federico Ciardi on 04/10/23.
//

import Combine
import StoreKit

public enum StoreError: Error {
    case failedVerification
}

let REMOVE_ADS_PRODUCT_ID = "remove_ads"

final class AppStoreViewModel: ObservableObject {
    @Published private(set) var adRemovalProduct: Product?
    @Published private(set) var didRemoveAds = false
    
    private var updateListenerTask: Task<Void, Error>?
    
    init() {
        updateListenerTask = listenForTransactions()
        
        Task {
            await requestProducts()
            
            await updateCustomerProductStatus()
        }
    }
    
    deinit {
        updateListenerTask?.cancel()
    }
    
    private func listenForTransactions() -> Task<Void, Error> {
        return Task(priority: .background) {
            for await result in Transaction.updates {
                do {
                    let transaction = try self.checkVerified(result)
                    
                    await self.updateCustomerProductStatus()
                    
                    await transaction.finish()
                } catch { }
            }
        }
    }
    
    @MainActor
    private func requestProducts() async {
        adRemovalProduct = try? await Product.products(for: [REMOVE_ADS_PRODUCT_ID]).first
    }
    
    @MainActor
    private func updateCustomerProductStatus() async {
        var didRemoveAds = false

        for await result in Transaction.currentEntitlements {
            do {
                let transaction = try checkVerified(result)
                
                if transaction.productID == REMOVE_ADS_PRODUCT_ID {
                    didRemoveAds = true
                }
            } catch { }
        }
        
        self.didRemoveAds = didRemoveAds
    }
    
    func purchaseAdRemoval() async throws -> Transaction? {
        let result = try await adRemovalProduct?.purchase()
        
        switch result {
        case .success(let verification):
            let transaction = try checkVerified(verification)
            
            await updateCustomerProductStatus()
            
            await transaction.finish()
            
            return transaction
        case .userCancelled, .pending:
            return nil
        default:
            return nil
        }
    }
    
    func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        //Check whether the JWS passes StoreKit verification.
        switch result {
        case .unverified:
            //StoreKit parses the JWS, but it fails verification.
            throw StoreError.failedVerification
        case .verified(let safe):
            //The result is verified. Return the unwrapped value.
            return safe
        }
    }
}
