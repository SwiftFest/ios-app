import UIKit

let appDelegateClass: AnyClass = NSClassFromString("SwiftFestTests.TestAppDelegate") ?? AppDelegate.self

let args = UnsafeMutableRawPointer(CommandLine.unsafeArgv).bindMemory(to: UnsafeMutablePointer<Int8>.self,
                                                                      capacity: Int(CommandLine.argc))

UIApplicationMain(CommandLine.argc, args, nil, NSStringFromClass(appDelegateClass))


