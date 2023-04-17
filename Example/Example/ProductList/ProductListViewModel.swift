//
//  ProductListViewModel.swift
//  Example
//
//  Created by Edgars Simanovskis on 17/4/23.
//

import Combine
import NimbleLoyalty

final class ProductListViewModel: ObservableObject {
    
    @Published var state: State = .idle
    @Published var products: [APIProduct] = []
    
    func loadProducts() {
        state = .loading
        NimbleLoyalty.shared.getProductList { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(products):
                self.products = products
                self.state = .loaded
            case let .failure(error):
                self.state = .error(error.localizedDescription)
            }
        }
    }
}

extension ProductListViewModel {
    
    enum State: Equatable {
        
        case idle, loaded, loading
        case error(String)
    }
}


