//
//  MultipartRequestModel.swift
//  BITAlert
//
//  Created by Bane Manojlovic on 9/4/19.
//  Copyright © 2019 Bane Manojlovic. All rights reserved.
//
import Foundation
import Alamofire

protocol MultipartRequestModel {
    func createMultipart(multipartFormData: MultipartFormData)
}
