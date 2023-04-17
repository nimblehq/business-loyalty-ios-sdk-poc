//
//  ProductRepositoryProtocol.swift
//  
//
//  Created by Edgars Simanovskis on 17/4/23.
//

import Foundation

protocol ProductRepositoryProtocol: AnyObject {

    func getProductList(_ completion: @escaping RequestCompletion<APIProductList>)
    func getProductDetail(code: String, _ completion: @escaping RequestCompletion<APIProduct>)
}
