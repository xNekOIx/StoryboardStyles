#!/usr/bin/env xcrun swift -v

import Foundation

let data = NSData(contentsOfFile: "file://TestStoryboard.storyboard")!
print(data)

class StoryboardParser: NSObject, NSXMLParserDelegate {
  lazy var parser: NSXMLParser = {
    let parser = NSXMLParser(data: data)
    parser.delegate = self

    return parser
  }()

  // MARK: - NSXMLParserDelegate

  @objc func parserDidStartDocument(parser: NSXMLParser) {
    print("did start")
  }

  @objc func parserDidEndDocument(parser: NSXMLParser) {
    print("did end")
    // process.shouldExit = true
  }

  @objc func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
    print("parseError: \n\(parseError)")
    // process.shouldExit = true
  }

  @objc func parser(parser: NSXMLParser, validationErrorOccurred validationError: NSError) {
    print("validationError: \n\(validationError)")
    // process.shouldExit = true
  }
}

var storyboardParser: StoryboardParser!

// start runloop

class MainProcess {
    var shouldExit = false

    func start () {
      storyboardParser = StoryboardParser()
      storyboardParser.parser.parse()
    }
}

var runLoop : NSRunLoop
var process : MainProcess

autoreleasepool {
    runLoop = NSRunLoop.currentRunLoop()
    process = MainProcess()

    process.start()

    while (!process.shouldExit && (runLoop.runMode(NSDefaultRunLoopMode, beforeDate: NSDate(timeIntervalSinceNow: 2)))) {
        // do nothing
    }
}
