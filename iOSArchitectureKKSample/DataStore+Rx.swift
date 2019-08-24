//
//  DataStore+rx.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/24.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import RxSwift

extension LocalCache: ReactiveCompatible {}
extension KeyChainCache: ReactiveCompatible {}

public extension Reactive where Base: Cacheable {
    func save<T: CacheValue>(key: CacheKey<T>, value: T) -> Completable {
        return Completable.create { (observer: @escaping PrimitiveSequenceType.CompletableObserver) -> Disposable in
                self.base.save(key, value: value)
                observer(CompletableEvent.completed)
            return Disposables.create()
        }
    }
    
    func fetch<T: CacheValue>(key: CacheKey<T>) -> Maybe<T?> {
        return Observable<T?>.create { observer in
            let element = self.base.fetch(key)
            observer.on(.next(element))
            observer.on(.completed)
            return Disposables.create()
        }.asMaybe()
    }
  
    func delete<T: CacheValue>(key: CacheKey<T>) -> Completable {
        return Completable.create { (observer: @escaping PrimitiveSequenceType.CompletableObserver) -> Disposable in
            self.base.delete(key)
            observer(CompletableEvent.completed)
            return Disposables.create()
        }
    }
}
