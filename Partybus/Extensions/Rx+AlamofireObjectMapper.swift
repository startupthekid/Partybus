//
//  Rx+AlamofireObjectMapper.swift
//  Partybus
//
//  Created by Brendan Conron on 11/16/16.
//  Copyright © 2016 Swoopy Studios. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import RxSwift

extension Observable where Element: DataRequest {

    func responseObject<T: ImmutableMappable>() -> Observable<T> {
        return flatMap { (request: DataRequest) -> Observable<T> in
            return request.rx_responseObject()
        }
    }

    func responseArray<T: ImmutableMappable>() -> Observable<[T]> {
        return flatMap { (request: DataRequest) -> Observable<[T]> in
            return request.rx_responseArray()
        }
    }

}

extension DataRequest {

    func rx_responseObject<T: ImmutableMappable>() -> Observable<T> {
        return Observable.create { observer in
            self.responseObject { (response: DataResponse<T>) in
                guard let value = response.result.value else { return }
                defer { observer.on(.completed) }
                observer.on(.next(value))
            }
            return Disposables.create {
                self.cancel()
            }
        }
    }

    func rx_responseArray<T: ImmutableMappable>() -> Observable<[T]> {
        return Observable.create { observer in
            self.responseArray { (response: DataResponse<[T]>) in
                guard let value = response.result.value else { return }
                defer { observer.on(.completed) }
                observer.on(.next(value))
            }
            return Disposables.create {
                self.cancel()
            }
        }
    }

}
