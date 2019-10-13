//
//  APIRequest.swift
//  CGIA
//
//  Created by Pedro Giuliano Farina on 09/10/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation

public enum HttpMethods: String {
    case get = "GET"
    case post = "POST"
}

public enum TaskAnswer<T> {
    case result(T)
    case error(Error)
}

public class APIRequests {
    private init() {
    }

    private static func createRequest(url: String) -> NSMutableURLRequest? {
        guard let URL = URL(string: url) else {
            return nil
        }
        let request = NSMutableURLRequest(url: URL)
        request.httpMethod = HttpMethods.get.rawValue
        return request
    }

    public static func getRequest(url: String, completion: @escaping (TaskAnswer<Any>) -> Void) {
        guard let request = createRequest(url: url) else {
            completion(TaskAnswer.error(NotURLError(title: nil, description: "Couldn't parse argument to URL")))
            return
        }

        createTask(request: request as URLRequest, completion: completion).resume()
    }

    public static func getRequest<T: Codable>(url: String, decodableType: T.Type, completion: @escaping (TaskAnswer<Any>) -> Void ) {
        guard let request = createRequest(url: url) else {
            completion(TaskAnswer.error(NotURLError(title: nil, description: "Couldn't parse argument to URL")))
            return
        }

        createTask(request: request as URLRequest, decodableType: decodableType, completion: completion).resume()
    }

    public static func createTask(request: URLRequest, completion: @escaping (TaskAnswer<Any>) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(TaskAnswer.result([:]))
                return
            }
            do {
                //A resposta chegou
                let response = try JSONSerialization.jsonObject(with: data, options: [])
                //completion(TaskAnswer.result(response))
                if let response = response as? [[String: Any]] {
                    completion(TaskAnswer.result(response))
                }
            } catch let error as NSError {
                // Houve um erro na comunicao com o servidor
                completion(TaskAnswer.error(error))
            }
        }
        return task
    }

    public static func createTask<T: Codable>(request: URLRequest, decodableType: T.Type, completion: @escaping (TaskAnswer<Any>) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(TaskAnswer.result([:]))
                return
            }
            do {
                //A resposta chegou
                let response = try JSONDecoder().decode(decodableType, from: data)
                completion(TaskAnswer.result(response))
            } catch let error as NSError {
                // Houve um erro na conversão de tipo ou comunicaçao com servidor
                completion(TaskAnswer.error(error))
            }
        }
        return task
    }

}
