//
//  URLSessionHTTPClient.swift
//  TinyCore
//
//  Created by Roy Hsu on 23/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - URLSessionHTTPClient

public final class URLSessionHTTPClient {

    public final let session: URLSession

    public init(session: URLSession = .shared) { self.session = session }

}

// MARK: - HTTPClient

extension URLSessionHTTPClient: HTTPClient {

    public final func data(
        in context: Context,
        with request: URLRequest
    )
    -> Promise<HTTPResult> {

        return Promise(in: context) { fulfill, reject, _ in

            let dataTask = self.session.dataTask(
                with: request,
                completionHandler: { data, response, error in

                    if let error = error {

                        reject(error)

                        return

                    }

                    guard
                        let response = response as? HTTPURLResponse
                    else {

                        let error: HTTPError = .invalidResponse

                        reject(error)

                        return

                    }

                    let data = data ?? Data()

                    let result = HTTPResult(
                        response: response,
                        data: data
                    )

                    fulfill(result)

                }
            )

            dataTask.resume()

        }

    }

}
