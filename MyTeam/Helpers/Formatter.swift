//
//  Formatter.swift
//  MyTeam
//
//  Created by Sofie De Plus on 19/01/2017.
//  Copyright © 2017 Sofie De Plus. All rights reserved.
//
import UIKit

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd yyyy"
        return dateFormatter.string(from: self)
    }
}

extension String {
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.date(from: self)! // Veilig uitpakken indien er lege string is
    }
}
