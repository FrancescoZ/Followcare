//
//  OperatorExtension.swift
//  Follocare
//
//  Created by Francesco Zanoli on 06/12/2017.
//  Copyright © 2017 Francesco Zanoli. All rights reserved.
//

infix operator ??=: AssignmentPrecedence

func ??= <T>(lhs: inout T?, rhs: T?) {
    guard let rhs = rhs else {
        return
    }
    
    lhs = rhs
}
