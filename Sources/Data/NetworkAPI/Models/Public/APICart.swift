//
//  APICart.swift
//  NimbleLoyalty
//
//  Created by Edgars Simanovskis on 19/4/23.
//

import Foundation

public struct APICart: Decodable, Hashable {

    public var id: String
    public var organizationId: String?
    public var userId: String?
    public var status: String?
    public var currency: String?
    public var subtotalPrice: String?
    public var finalPrice: String?
    public var shipmentCost: String?
    public var createdAt: String?
    public var updatedAt: String?
    public var orderLineItems: [APIOrderLineItem]?

    public static func == (lhs: APICart, rhs: APICart) -> Bool {
        lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    
}

// MARK: Mock data

extension APICart {
    public static var sampleCart: APICart? {
        let sampleData = """
{
    "id": "7424f7b0-f2fe-4239-ba1d-a8590ae2f930",
    "organization_id": "62ccda8c-2812-44df-8930-87d7226490c7",
    "user_id": "125c4b1c-446e-4e1a-91df-d80d0840a461",
    "status": "cart",
    "currency": "USD",
    "subtotal_price": "50.0",
    "final_price": "60.0",
    "shipment_cost": "10.0",
    "created_at": "2023-04-18T04:19:15.698Z",
    "updated_at": "2023-04-18T04:19:15.698Z",
    "order_line_items": [
        {
            "id": "79a0a987-0fc6-4032-a2fc-37c1815d9f33",
            "organization_id": "62ccda8c-2812-44df-8930-87d7226490c7",
            "user_id": "125c4b1c-446e-4e1a-91df-d80d0840a461",
            "product_id": "015e2f95-4d39-4e7d-addf-162cbf018db7",
            "price": "60.0",
            "discount": "0.0",
            "tax": "0.0",
            "final_price": "60.0",
            "net_price": "0.0",
            "quantity": 1,
            "status": null,
            "created_at": "2023-04-18T04:23:49.066Z",
            "updated_at": "2023-04-18T04:23:49.066Z",
            "order_id": "7424f7b0-f2fe-4239-ba1d-a8590ae2f930",
            "product": {
                "id": "015e2f95-4d39-4e7d-addf-162cbf018db7",
                "organization_id": "45affa24-1c47-4043-89a3-439ddf264312",
                "name": "Royal Chocolate Cake",
                "sku": "cake_royal_chocolate",
                "description": "Enrobed in an outer laye of dark chocolate with hints of toasted hazelnuts on a base of crispy feuilletine. Weight : 500 g",
                "image": {
                    "cdn_url": "https://ucarecdn.com/8f9140a9-a935-431a-9332-9ae1b37d7c6f/",
                    "uuid": "8f9140a9-a935-431a-9332-9ae1b37d7c6f"
                },
                "price": "29.9",
                "display_price": "29.9",
                "created_at": "2023-03-29T05:08:48.095Z",
                "updated_at": "2023-04-03T08:49:40.336Z",
                "image_url": "https://ucarecdn.com/8f9140a9-a935-431a-9332-9ae1b37d7c6f/"
            }
        },
        {
            "id": "79a0a987-0fc6-4032-a2fc-37c1815d9f34",
            "organization_id": "62ccda8c-2812-44df-8930-87d7226490c7",
            "user_id": "125c4b1c-446e-4e1a-91df-d80d0840a461",
            "product_id": "015e2f95-4d39-4e7d-addf-162cbf018db7",
            "price": "60.0",
            "discount": "0.0",
            "tax": "0.0",
            "final_price": "60.0",
            "net_price": "0.0",
            "quantity": 3,
            "status": null,
            "created_at": "2023-04-18T04:23:49.066Z",
            "updated_at": "2023-04-18T04:23:49.066Z",
            "order_id": "7424f7b0-f2fe-4239-ba1d-a8590ae2f930",
            "product": {
                "id": "015e2f95-4d39-4e7d-addf-162cbf018db7",
                "organization_id": "45affa24-1c47-4043-89a3-439ddf264312",
                "name": "Royal Chocolate Cake",
                "sku": "cake_royal_chocolate",
                "description": "Enrobed in an outer laye of dark chocolate with hints of toasted hazelnuts on a base of crispy feuilletine. Weight : 500 g",
                "image": {
                    "cdn_url": "https://ucarecdn.com/8f9140a9-a935-431a-9332-9ae1b37d7c6f/",
                    "uuid": "8f9140a9-a935-431a-9332-9ae1b37d7c6f"
                },
                "price": "29.9",
                "display_price": "29.9",
                "created_at": "2023-03-29T05:08:48.095Z",
                "updated_at": "2023-04-03T08:49:40.336Z",
                "image_url": "https://ucarecdn.com/8f9140a9-a935-431a-9332-9ae1b37d7c6f/"
            }
        }
    ]
}
""".data(using: .utf8)!
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let cart = try? decoder.decode(APICart.self, from: sampleData)
        return cart
    }
}
