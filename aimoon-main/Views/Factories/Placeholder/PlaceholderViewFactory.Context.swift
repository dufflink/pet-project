//
//  PlaceholderViewFactory.Context.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 21.09.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

extension PlaceholderViewFactory {
    
    enum Context {
        
        case categoriesIsEmpty
        
        case productsIsEmpty
        case loadingProductDidFail
        
        case favoriteIsEmpty(isAuth: Bool)
        case cartIsEmpty
        
        case loadingFavoriteProductsDidFail
        case homeItemsIsEmpty
        
        case successOrdering(isAuth: Bool)
        case orderListIsEmpty
        
        case loadingOrderDidFail
        
        // MARK: - Public Properties
        
        var title: String {
            switch self {
                case .categoriesIsEmpty:
                    return "Список категорий пуст"
                    
                case .productsIsEmpty:
                    return "В этой категории нет товаров"
                case .loadingProductDidFail:
                    return "Не удалось загрузить информацию по товару"
                    
                case .favoriteIsEmpty:
                    return "В избранном нет товаров"
                case .cartIsEmpty:
                    return "В корзине нет товаров"
                    
                case .loadingFavoriteProductsDidFail:
                    return "Не удалось загрузить список избранных товаров"
                    
                case .homeItemsIsEmpty:
                    return "На этом экране могут быть размещены баннеры"
                
                case .successOrdering:
                    return "Спасибо за заказ!"
                case .orderListIsEmpty:
                    return "Список заказов пуст"
                    
                case .loadingOrderDidFail:
                    return "Не удалось загрузить информацию по заказу"
            }
        }
        
        var subtitle: String? {
            switch self {
                case let .favoriteIsEmpty(isAuth):
                    return isAuth ? "Понравившиеся товары будут отображаться тут" : "Войдите в свою учетную запись, чтобы увидеть товары, добавленные в избранное на других устройствах"
                case .cartIsEmpty:
                    return "Для выбора вещей перейдите в каталог"
                case let .successOrdering(isAuth):
                    return isAuth ? "Список заказов можно посмотреть в профиле" : "Чтобы посмотреть список ваших заказов, войдите в аккаунт. Логин и пароль отправлены на вашу электронную почту."
                case .orderListIsEmpty:
                    return "Вперед за покупками!"
                default:
                    return nil
            }
        }
        
        var buttonTitle: String? {
            switch self {
                case .favoriteIsEmpty:
                    return "Войти"
                case .cartIsEmpty, .orderListIsEmpty:
                    return "Перейти в каталог"
                case .loadingFavoriteProductsDidFail, .loadingProductDidFail, .loadingOrderDidFail:
                    return "Обновить"
                case let .successOrdering(isAuth):
                    return isAuth ? "Посмотреть список заказов" : "Перейти в профиль"
                default:
                    return nil
            }
        }
        
        var image: UIImage {
            switch self {
                case .categoriesIsEmpty:
                    return #imageLiteral(resourceName: "List Clear")
                    
                case .productsIsEmpty:
                    return #imageLiteral(resourceName: "List Clear")
                case .loadingProductDidFail:
                    return #imageLiteral(resourceName: "List Clear")
                    
                case .favoriteIsEmpty:
                    return #imageLiteral(resourceName: "List Clear")
                case .loadingFavoriteProductsDidFail:
                    return #imageLiteral(resourceName: "Profile Header")
                    
                case .homeItemsIsEmpty:
                    return #imageLiteral(resourceName: "Profile Header")
                case .cartIsEmpty:
                    return #imageLiteral(resourceName: "Cart Clear")
                
                case .successOrdering:
                    return #imageLiteral(resourceName: "Profile Header")
                case .orderListIsEmpty:
                    return #imageLiteral(resourceName: "Cart Clear")
                    
                case .loadingOrderDidFail:
                    return #imageLiteral(resourceName: "Cart Clear")
            }
        }
        
    }
    
}
