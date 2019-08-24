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
            do {
                try self.base.save(key, value: value)
                observer(CompletableEvent.completed)
            } catch {
                observer(CompletableEvent.error(error))
            }
            
            return Disposables.create()
        }
    }
    
    func fetch<T: CacheValue>(key: CacheKey<T>) -> Maybe<T?> {
        
        
        return Maybe.create{ (observer: @escaping (MaybeEvent<T?>) -> ()) -> Disposable in
            let element = self.base.fetch(key)
            observer(MaybeEvent.success(element))
            return Disposables.create()
        }
    }
  
    func delete<T: CacheValue>(key: CacheKey<T>) -> Completable {
        return Completable.create { (observer: @escaping PrimitiveSequenceType.CompletableObserver) -> Disposable in
            do {
                try self.base.delete(key)
                observer(CompletableEvent.completed)
            } catch {
                observer(CompletableEvent.error(error))
            }
            return Disposables.create()
        }
    }
}
