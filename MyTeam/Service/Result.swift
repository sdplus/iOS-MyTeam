//
//  Result.swift
//  MyTeam
//
//  Created by Sofie De Plus on 19/01/2017.
//  Copyright © 2017 Sofie De Plus. All rights reserved.
//

enum Result<T> {
    
    case success(T)
    case failure(Service.Error)
}
