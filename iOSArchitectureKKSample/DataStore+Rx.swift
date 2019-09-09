//
//  DataStore+rx.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/24.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import RxSwift

extension Cache: ReactiveCompatible {}


extension Reactive where Base: Cache {
    func save<T: CacheValue>(key: CacheKey<T>, value: T) -> Completable {
        return Completable.create { observer in
            do {
                try self.base.save(key, value: value)
                observer(CompletableEvent.completed)
            } catch {
                observer(CompletableEvent.error(error))
            }
            
            return Disposables.create()
        }
    }
    
    func fetch<T: CacheValue>(key: CacheKey<T>) -> Single<T?> {
        return Single.create{observer in
            do {
                let element = try self.base.fetch(key)
                observer(SingleEvent.success(element))
            } catch {
                observer(SingleEvent.error(error))
            }
            
            return Disposables.create()
        }
    }
  
    func delete<T: CacheValue>(key: CacheKey<T>) -> Completable {
        return Completable.create { observer in
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
