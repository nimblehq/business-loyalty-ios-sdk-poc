//
//  CartViewModel.swift
//  Example
//
//  Created by Edgars Simanovskis on 20/4/23.
//

import Combine
import NimbleLoyalty

final class CartViewModel: ObservableObject {
    
    @Published var state: State = .idle
    @Published var cart: APICart?
    
    func loadCart() {
        state = .loading
//        NimbleLoyalty.shared.getCartDetails { [weak self] result in
//            guard let self = self else { return }
//
//            switch result {
//            case let .success(cart):
//                self.cart = cart
//                self.state = .loaded
//            case let .failure(error):
//                self.state = .error(error.localizedDescription)
//            }
//        }
        self.cart = APICart.sampleCart
        self.state = .loaded
    }
}

extension CartViewModel {
    
    enum State: Equatable {
        
        case idle, loaded, loading
        case error(String)
    }
}
