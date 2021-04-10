//
//  HeaderFactory.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 10/04/2021.
//

enum HeaderFactory {
    
    case apiDefault
    
    var dictionary: Headers {
        switch self {
        case .apiDefault:
            return ["x-apikey": "795ad45e4dc222bc0e5bd1c163bb885e3635e"]
        }
    }
    
}
