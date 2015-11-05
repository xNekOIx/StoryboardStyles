import Foundation
import XCPlayground

//XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

class StoryboardParser: NSObject, NSXMLParserDelegate {
    
    // MARK: - NSXMLParserDelegate
    
    func parserDidStartDocument(parser: NSXMLParser) {
        print("did start")
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        print("did end")
        // process.shouldExit = true
    }
    
//    func parser(parser: NSXMLParser,
//        foundAttributeDeclarationWithName attributeName: String,
//        forElement elementName: String,
//        type: String?,
//        defaultValue: String?) {
//            print("attr: \(attributeName)\nelem: \(elementName)")
//    }
//    
//    func parser(parser: NSXMLParser, foundCharacters string: String) {
//        print(string)
//    }
//    
//    func parser(parser: NSXMLParser, foundElementDeclarationWithName elementName: String, model: String) {
//        print(elementName)
//    }
//    
    func parser(parser: NSXMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String : String]) {
        print("element: \(elementName)\nattrs: \(attributeDict)")
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        print("parseError: \n\(parseError)")
        // process.shouldExit = true
    }
    
    func parser(parser: NSXMLParser, validationErrorOccurred validationError: NSError) {
        print("validationError: \n\(validationError)")
        // process.shouldExit = true
    }
}

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
"</document>").dataUsingEncoding(NSUTF8StringEncoding)

let sParser = StoryboardParser()
let parser = NSXMLParser(data: storyboardData!)
parser.delegate = sParser
parser.parse()
print(parser.parserError)
