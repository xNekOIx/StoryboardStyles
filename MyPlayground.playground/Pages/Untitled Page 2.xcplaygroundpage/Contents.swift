//: [Previous](@previous)

import Foundation

let storyboardData = ("<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>" +
    "<document type=\"com.apple.InterfaceBuilder3.CocoaTouch.Storyboard.XIB\" version=\"3.0\" toolsVersion=\"9059\" systemVersion=\"15B42\" targetRuntime=\"iOS.CocoaTouch\" propertyAccessControl=\"none\" useAutolayout=\"YES\" useTraitCollections=\"YES\">" +
    "<dependencies>" +
    "<plugIn identifier=\"com.apple.InterfaceBuilder.IBCocoaTouchPlugin\" version=\"9049\"/>" +
    "</dependencies>" +
    "<scenes>" +
    "<!--View Controller-->" +
    "<scene sceneID=\"X5B-PV-zIh\">" +
    "<objects>" +
    "<viewController id=\"iHD-XU-1t3\" sceneMemberID=\"viewController\">" +
    "<layoutGuides>" +
    "<viewControllerLayoutGuide type=\"top\" id=\"vBi-pL-j8v\"/>" +
    "<viewControllerLayoutGuide type=\"bottom\" id=\"YIc-tN-jzC\"/>" +
    "</layoutGuides>" +
    "<view key=\"view\" contentMode=\"scaleToFill\" id=\"D67-Go-AuY\">" +
    "<rect key=\"frame\" x=\"0.0\" y=\"0.0\" width=\"600\" height=\"600\"/>" +
    "<autoresizingMask key=\"autoresizingMask\" widthSizable=\"YES\" heightSizable=\"YES\"/>" +
    "<animations/>" +
    "<color key=\"backgroundColor\" white=\"1\" alpha=\"1\" colorSpace=\"calibratedWhite\"/>" +
    "<userDefinedRuntimeAttributes>" +
    "<userDefinedRuntimeAttribute type=\"string\" keyPath=\"styleClass\" value=\"PewPew\"/>" +
    "</userDefinedRuntimeAttributes>" +
    "</view>" +
    "</viewController>" +
    "<placeholder placeholderIdentifier=\"IBFirstResponder\" id=\"wG4-Wr-g0G\" userLabel=\"First Responder\" sceneMemberID=\"firstResponder\"/>" +
    "</objects>" +
    "<point key=\"canvasLocation\" x=\"977\" y=\"394\"/>" +
    "</scene>" +
    "</scenes>" +
    "</document>").dataUsingEncoding(NSUTF8StringEncoding)!

let stylesheetData = ("[{" +
        "\"class\": \"PewPew\"," +
        "\"styles\": [{" +
        "\"node\": \"color\"," +
        "\"key\": \"backgroundColor\"," +
        "\"white\": \"0\"," +
        "\"alpha\": \"1\"," +
        "\"colorSpace\": \"calibratedWhite\"}]}]").dataUsingEncoding(NSUTF8StringEncoding)!

let doc = try! NSXMLDocument(data: storyboardData, options: Int(NSXMLDocumentContentKind.XMLKind.rawValue))
let style = try! NSJSONSerialization.JSONObjectWithData(stylesheetData, options: NSJSONReadingOptions.MutableContainers) as! [AnyObject]

guard let topClass = style[0] as? [String: AnyObject] else { fatalError() }
guard let className = topClass["class"] as? String else { fatalError() }
guard let styles = topClass["styles"] as? [[String: String]] else { fatalError() }

let colorStyle = styles[0]
let colorNode = NSXMLElement(name: colorStyle["node"]!)
colorStyle.forEach { (key, value) in
    if key == "node" { return }
    colorNode.addAttribute(NSXMLNode.attributeWithName(key, stringValue: value) as! NSXMLNode)
}

let viewNode = try doc.nodesForXPath("//userDefinedRuntimeAttribute[@keyPath='styleClass' and @value='\(className)']/../..")
viewNode.map { el -> NSXMLElement in return el as! NSXMLElement }
    .forEach { viewNode in
        let inds = viewNode.children!
            .enumerate()
            .reduce([Int]()) { (var acc, en) in
                let (ind, el) = en
                guard var elem = el as? NSXMLElement else { return acc }
                if el.name == colorNode.name &&
                    elem.attributeForName("key") == colorNode.attributeForName("key") {
                        return acc + [ind]
                } else { return acc }
        }
        if inds.count > 0 {
            inds.forEach { viewNode.replaceChildAtIndex($0, withNode: colorNode) }
        } else { viewNode.addChild(colorNode) }
}

print(doc)

//: [Next](@next)
