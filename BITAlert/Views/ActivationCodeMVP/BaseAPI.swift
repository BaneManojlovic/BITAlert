//
//  BaseAPI.swift
//  BITAlert
//
//  Created by Bane Manojlovic on 9/4/19.
//  Copyright © 2019 Bane Manojlovic. All rights reserved.
//

import Foundation
import Alamofire

enum APIError: Error {
    case noInternet
    case unauthorized
    case requestCanceled
    case unknown(reason: String?)
    case requestResponse(reason: String, errorCode: Int?)
}

class BaseAPI {
    
    /// API success block.
    typealias APIRequestSuccess<DataType> = (_ data: DataType) -> Void
    
    /// API failure block.
    typealias APIRequestFailure = (_ error: APIError) -> Void
    
    typealias APIRequestBlock = (Request?) -> Void
    
    var baseURL: URL?
    private var requests = Set<Request>()
    
    var sessionManager: SessionManager = {
        let sessionManager: SessionManager = {
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
            configuration.timeoutIntervalForRequest = 10
            return SessionManager(configuration: configuration)
        }()
        return sessionManager
    }()
    
    init(baseURL: String) {
        self.baseURL = URL(string: baseURL)
    }
    
    init() {
        
        self.baseURL = URL(string: Constants.baseURL)!
    }
    
    // swiftlint:disable function_parameter_count
    @discardableResult
    func sendRequest<ResponseDataType: Decodable>(
        endpoint: String,
        method: HTTPMethod,
        parameters: Parameters?,
        encoding: ParameterEncoding,
        headers: HTTPHeaders? = nil,
        success: @escaping APIRequestSuccess<ResponseDataType>,
        failure: @escaping APIRequestFailure) -> Request? {
        
        guard let url = URL(string: endpoint, relativeTo: baseURL) else { return nil }
        
        let request = sessionManager
            .request(url,
                     method: method,
                     parameters: parameters,
                     encoding: encoding,
                     headers: headers)
        return makeRequest(request, success: success, failure: failure)
    }
    // swiftlint:enable function_parameter_count
    
    private func makeRequest<ResponseDataType>(
        _ request: DataRequest,
        success: @escaping APIRequestSuccess<ResponseDataType>,
        failure: @escaping APIRequestFailure) -> Request?
        where ResponseDataType: Decodable {
            
            request
                .validate(statusCode: 200..<300)
                .responseJSON(completionHandler: { [weak self] (response) in
                    self?.logToConsole(response: response)
                })
                .responseData(completionHandler: { [weak self] response in
                    self?.completionHandler(request: request, response: response, success: success, failure: failure)
                })
            requests.insert(request)
            return request
    }
    
    @discardableResult
    func sendPOSTRequest<RequestDataType: Encodable, ResponseDataType: Decodable>(
        endpoint: String,
        model: RequestDataType,
        headers: HTTPHeaders? = nil,
        success: @escaping APIRequestSuccess<ResponseDataType>,
        failure: @escaping APIRequestFailure) -> Request? {
        
        guard let url = URL(string: endpoint, relativeTo: baseURL) else { return nil }
        
        guard let request = sessionManager.postRequest(url, parameters: model,
                                                       headers: headers)
            else { failure(.unknown(reason: nil)); return nil }
        
        return makeRequest(request, success: success, failure: failure)
    }
    
    func sendPUTRequest<RequestDataType, ResponseDataType>(
        endpoint: String,
        model: RequestDataType,
        headers: HTTPHeaders? = nil,
        success: @escaping (ResponseDataType) -> Void,
        failure: @escaping BaseAPI.APIRequestFailure) -> Request?
        where RequestDataType: Encodable, ResponseDataType: Decodable {
            guard let url = URL(string: endpoint, relativeTo: baseURL) else { return nil }
            guard let request = sessionManager.putRequest(url, parameters: model,
                                                          headers: headers)
                else { failure(.unknown(reason: nil)); return nil }
            return self.makeRequest(request, success: success, failure: failure)
    }
    
    private func completionHandler<ResponseDataType: Decodable>(
        request: Request? = nil,
        response: DataResponse<Data>,
        success: @escaping APIRequestSuccess<ResponseDataType>,
        failure: @escaping APIRequestFailure) {
        
        defer {
            if let request = request {
                requests.remove(request)
            }
        }
        
        switch response.result {
        case let .success(responseData):
            do {
                let defaultResponse = try JSONDecoder().decode(ResponseDataType.self,
                                                               from: responseData)
                
                success(defaultResponse)
                
            } catch {
                debugPrint(error)
                debugPrint(error.localizedDescription)
                
                do {
                    let errorResponse = try JSONDecoder().decode(ErrorResponse.self,
                                                                 from: responseData)
                    
                    failure(.unknown(reason: errorResponse.resourceerror?.message ?? ""))
                    
                } catch {
                    debugPrint(error)
                    debugPrint(error.localizedDescription)
                    
                    failure(.unknown(reason: "An error has occurred, please try again later."))
                }
                
            }
        case let .failure(error):
            if let internetError = error as? URLError, internetError.code == URLError.Code.notConnectedToInternet {
                failure (.noInternet)
            } else if let requestCanceledError = response.error as? URLError,
                requestCanceledError.code == URLError.Code.cancelled {
                
                failure(.requestCanceled)
            } else {
                do {
                    let errorResponse = try JSONDecoder().decode(
                        ErrorResponse.self, from: response.data ?? Data())
                    let apiError = APIError.unknown(reason: errorResponse.resourceerror?.message ?? "")
                    failure(apiError)
                    
                } catch {
                    debugPrint(error)
                    debugPrint(error.localizedDescription)
                    
                    failure(.unknown(reason: nil))
                }
            }
        }
    }
    func sendPOSTMultipartRequest<ResponseDataType: Decodable>(
        endpoint: String,
        multipart: MultipartRequestModel,
        headers: HTTPHeaders? = nil,
        uploadStarted: APIRequestBlock? = nil,
        success: @escaping APIRequestSuccess<ResponseDataType>,
        failure: @escaping APIRequestFailure) {
        
        guard let url = URL(string: endpoint, relativeTo: baseURL) else { return }
        
        sessionManager.upload(
            multipartFormData: multipart.createMultipart(multipartFormData:),
            usingThreshold: UInt64(),
            to: url,
            method: .post,
            headers: headers,
            encodingCompletion: { (encodingResult) in
                switch encodingResult {
                case .success(let upload, _, _):
                    uploadStarted?(upload)
                    upload
                        .validate(statusCode: 200..<300)
                        .responseJSON(completionHandler: { [weak self] (response) in
                            self?.logToConsole(response: response)
                        })
                        .responseData(completionHandler: { [weak self] response in
                            self?.completionHandler(request: nil, response: response,
                                                    success: success, failure: failure)
                        })
                case let .failure(encodingError):
                    failure(.unknown(reason: encodingError.localizedDescription))
                }
        })
    }
    
    private func logToConsole(response: DataResponse<Any>) {
        // Log Request
        if let urlRequest = response.request?.urlRequest {
            debugPrint("---------- REQUEST ----------")
            if let absoluteString = urlRequest.url?.absoluteString {
                debugPrint("URL: \(absoluteString)")
            }
            if let headers = urlRequest.allHTTPHeaderFields {
                debugPrint("HEADERS: \(headers)")
            }
            if let httpBody = urlRequest.httpBody {
                do {
                    debugPrint("PARAMETERS")
                    let json = try JSONSerialization.jsonObject(with: httpBody, options: .allowFragments)
                    debugPrint(json)
                } catch { }
            }
        }
        
        // Log Response
        if let result = response.result.value {
            debugPrint("---------- RESPONSE ----------")
            debugPrint(result)
        }
        if response.error != nil {
            debugPrint("---------- RESPONSE ----------")
            do {
                let errorResponse = try JSONDecoder().decode(
                    ErrorResponse.self, from: response.data ?? Data())
                let apiError = APIError.unknown(reason: errorResponse.resourceerror?.message ?? "")
                debugPrint(apiError)
                
            } catch {
                debugPrint(error)
                debugPrint(error.localizedDescription)
            }
        }
    }
    deinit {
        requests.forEach({ $0.cancel() })
    }
}

extension Request: Equatable, Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(request)
    }
    //    public var hashValue: Int {
    //        return request?.hashValue ?? 0
    //    }
    
    public static func == (lhs: Request, rhs: Request) -> Bool {
        return lhs.request == rhs.request
    }
}

extension SessionManager {
    
    @discardableResult
    public func postRequest<P: Encodable>(
        _ url: URLConvertible,
        parameters: P,
        headers: HTTPHeaders? = nil)
        -> DataRequest? {
            
            var originalRequest: URLRequest?
            
            do {
                originalRequest = try URLRequest(url: url, method: .post, headers: headers)
                let encodedURLRequest = try encode(originalRequest!, with: parameters)
                return request(encodedURLRequest)
            } catch {
                return nil
            }
    }
    
    @discardableResult
    public func putRequest<P: Encodable>(
        _ url: URLConvertible,
        parameters: P,
        headers: HTTPHeaders? = nil)
        -> DataRequest? {
            var originalRequest: URLRequest?
            do {
                originalRequest = try URLRequest(url: url, method: .put, headers: headers)
                let encodedURLRequest = try encode(originalRequest!, with: parameters)
                return request(encodedURLRequest)
            } catch {
                return nil
            }
    }
}

private func encode<P: Encodable>(_ urlRequest: URLRequestConvertible, with parameters: P?) throws -> URLRequest {
    var urlRequest = try urlRequest.asURLRequest()
    guard let parameters = parameters else { return urlRequest }
    let encoder = JSONEncoder()
    do {
        let data = try encoder.encode(parameters)
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        if urlRequest.value(forHTTPHeaderField: "Accept") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        }
        
        urlRequest.httpBody = data
    } catch {
        throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
    }
    return urlRequest
}
