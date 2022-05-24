//
//  FetchQuoteResponse.swift
//  
//
//  Created by Vladislav Lisianskii on 23.05.2022.
//

import Foundation

struct FetchQuoteResponse: Decodable {
    let data: [String: CMCCoinDTO]
}
