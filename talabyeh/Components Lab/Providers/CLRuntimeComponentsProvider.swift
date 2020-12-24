//
//  CLRuntimeComponentsProvider.swift
//  talabyeh
//
//  Created by Hussein Work on 24/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import Foundation

struct CLAutoComponentsSectionListProvider: CLComponentSectionListProvider {
    func sections() -> [CLComponentsSection] {
        // first, get all classes for componentPreview
        let listOfAllClasses = Runtime.classes(conformTo: CLComponentPreview.Type.self)
        let mapped = listOfAllClasses.compactMap { $0 as? CLComponentPreview.Type }
        
        // group them
        let dictionary = Dictionary(grouping: mapped, by: { $0.groupIdentifier })
        
        // now, conver the dictionary back to regular array, but mapping to a section type
        let sections = dictionary.map {
            CLComponentsSection(group: $0.key, items: $0.value.map { $0.toComponentItem() })
        }
        
        return sections
    }
}


private class Runtime {
    public static func allClasses() -> [AnyClass] {
        let numberOfClasses = Int(objc_getClassList(nil, 0))
        if numberOfClasses > 0 {
            let classesPtr = UnsafeMutablePointer<AnyClass>.allocate(capacity: numberOfClasses)
            let autoreleasingClasses = AutoreleasingUnsafeMutablePointer<AnyClass>(classesPtr)
            let count = objc_getClassList(autoreleasingClasses, Int32(numberOfClasses))
            assert(numberOfClasses == count)
            defer { classesPtr.deallocate() }
            let classes = (0 ..< numberOfClasses).map { classesPtr[$0] }
            return classes
        }
        return []
    }

    public static func subclasses(of `class`: AnyClass) -> [AnyClass] {
        return self.allClasses().filter {
            var ancestor: AnyClass? = $0
            while let type = ancestor {
                if ObjectIdentifier(type) == ObjectIdentifier(`class`) { return true }
                ancestor = class_getSuperclass(type)
            }
            return false
        }
    }

    public static func classes(conformToProtocol `protocol`: Protocol) -> [AnyClass] {
        let classes = self.allClasses().filter { aClass in
            var subject: AnyClass? = aClass
            while let aClass = subject {
                if class_conformsToProtocol(aClass, `protocol`) { print(String(describing: aClass)); return true }
                subject = class_getSuperclass(aClass)
            }
            return false
        }
        return classes
    }

    public static func classes<T>(conformTo: T.Type) -> [AnyClass] {
        return self.allClasses().filter { $0 is T }
    }
}
