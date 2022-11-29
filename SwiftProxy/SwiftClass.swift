//
//  SwiftClass.swift
//  SwiftProxy
//
//  Created by Teodor Dermendzhiev on 23.11.22.
//

import Foundation


class AClass{
    
    let count: Int
    
    init(count: Int) {
        self.count = count
    }
    
    func printCount() {
        print(count)
    }
    
}


@_cdecl("aclass_create")
public func AClass_create(count: Int) -> OpaquePointer {
    let type = AClass(count: count)
    let retained = Unmanaged.passRetained(type).toOpaque()
//    retained.deallocate()
//    print(retained)
    return OpaquePointer(retained)
}

@_cdecl("aclass_printCount")
public func AClass_printCount(inst: UnsafeRawPointer) {
    let i = Unmanaged<AClass>.fromOpaque(inst).takeUnretainedValue()
    i.printCount()
}

@_cdecl("test_getProp_int")
func getIntProp(inst: UnsafeRawPointer, key: UnsafeMutablePointer<Int8>) -> Int32 {
    let str = String(cString: key)
    let obj = Unmanaged<AClass>.fromOpaque(inst).takeUnretainedValue()
    let mirrorLib = Mirror(reflecting: obj);
    if let propValue = mirrorLib.children.first(where: { $0.label == str })?.value as? Int {
        return Int32(propValue)
    }
    return 0
}
