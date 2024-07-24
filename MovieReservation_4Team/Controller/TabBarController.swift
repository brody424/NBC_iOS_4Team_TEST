//
//  TabBarController.swift
//  MovieReservation_4Team
//
//  Created by t2023-m0112 on 7/23/24.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 탭 바 배경색 설정
        tabBar.barTintColor = .black
        
        // 탭 바 아이템 생성
        let mainViewController = MainViewController() // MainView가 아닌 MainViewController를 사용
        let mainNavController = UINavigationController(rootViewController: mainViewController)
        mainNavController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house.fill"), tag: 0)
        
        let searchViewController = SearchViewController()
        let searchNavController = UINavigationController(rootViewController: searchViewController)
        searchNavController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "magnifyingglass"), tag: 1)
        
        let cartViewController = CartViewController()
        let cartNavController = UINavigationController(rootViewController: cartViewController)
        cartNavController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "ticket"), tag: 2)
        
        let favoritesViewController = FavoritesViewController()
        let favoritesNavController = UINavigationController(rootViewController: favoritesViewController)
        favoritesNavController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "heart.fill"), tag: 3)
        
        // 뷰 컨트롤러 순서 설정
        viewControllers = [mainNavController, searchNavController, cartNavController, favoritesNavController]
        
        // 탭 바 레이아웃 커스터마이즈
        if let items = tabBar.items {
            for item in items {
                item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
                item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0) // 적절히 값을 조정하여 아이콘 위치를 조정
            }
        }
        
        // Delegate 설정
        self.delegate = self
    }
    
    // UITabBarControllerDelegate 메서드
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
            return false
        }
        
        if fromView != toView {
            UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
        }
        
        return true
    }
}
