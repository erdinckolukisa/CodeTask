//
//  AppDelegate.swift
//  MobiquityCodeTask
//
//  Created by Erdinc Kolukisa on 9/13/22.
//

import UIKit
import Swinject
import SwinjectStoryboard

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	var container: Container = {
		let container = Container()
		container.storyboardInitCompleted(MainListViewController.self) { resolver, controller in
			controller.viewModel = resolver.resolve(MainListViewModel.self)
		}
		
		container.register(Networking.self) { _ in
			return WebAPI()
		}
		
		container.register(SearchProviding.self) { _ in
			return SearchProvider()
		}
		
		container.register(MainListViewModel.self) { resolver in
			guard let networking = resolver.resolve(Networking.self),
				  let searchProviding = resolver.resolve(SearchProviding.self) else {
				return MainListViewModel(network: WebAPI(), searchProvider: SearchProvider())
			}
			
			return MainListViewModel(network: networking, searchProvider: searchProviding)
		}
		return container
	}()

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		Container.loggingFunction = nil
		
		let window = UIWindow(frame: UIScreen.main.bounds)
		window.makeKeyAndVisible()
		self.window = window
		
		let storyboard = SwinjectStoryboard.create(name: Constants.storyboardName, bundle: nil, container: container)
		window.rootViewController = storyboard.instantiateInitialViewController()
		
		return true
	}


}

