//
//  SIMD4+Ext.swift
//  CarsVision
//
//  Created by Narek Aslanyan on 27.11.24.
//

import Foundation

extension SIMD4 {
  
  var xyz: SIMD3<Scalar> {
    self[SIMD3(0, 1, 2)]
  }
  
}
