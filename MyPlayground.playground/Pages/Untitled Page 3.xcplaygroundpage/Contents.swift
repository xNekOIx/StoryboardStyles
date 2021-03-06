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

let stylesheetData = ("<?xml version=\"1.0\" encoding=\"UTF-8\"?>" +
    "<xsl:stylesheet version=\"1.0\" xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\">" +
    
    "<xsl:template match=\"//userDefinedRuntimeAttribute[@keyPath='styleClass' and @value='PewPew']\">" +
//    "<xsl:template match=\"@* | node()\">" +
    "<xsl:copy-of select=\".\"/>" +
//    "<color></color>" +
//    "<xsl:copy>" +
//    "<color></color>" +
//    "<xsl:apply-templates select=\"@* | node()\"/>" +
//    "</xsl:copy>" +
    "</xsl:template>" +
    
    "</xsl:stylesheet>").dataUsingEncoding(NSUTF8StringEncoding)!

let doc = try! NSXMLDocument(data: storyboardData, options: Int(NSXMLDocumentContentKind.XMLKind.rawValue))
let xslt = try! doc.objectByApplyingXSLT(stylesheetData, arguments: nil)
print(xslt)

//: [Next](@next)
