//
//  ShopViewModel.swift
//  DymGet
//
//  Created by Михаил Щербаков on 22.10.2021.
//

import SwiftUI

class ShopViewModel: ObservableObject {
    
    @Published var hookahHookah: [Item] = []
    @Published var hookahTobacco: [Item] = []
    @Published var hookahCharcoal: [Item] = []
    @Published var vapeVape: [Item] = []
    @Published var vapeLiquid: [Item] = []
    
    @Published var itemList: [Item] = []
    
    func getItems(shop: Shop) {
        self.itemList = shop.assort
    }
    
//    func mapData() {
//        ForEach(itemList) {item in
//            if item.category == "Кальяны" {
//                if item.type == "Кальян" {
//                    self.hookahHookah.append(item)
//                }
//                else if item.type == "Табак" {
//                    self.hookahTobacco.append(item)
//                }
//                else if item.type == "Уголь" {
//                    self.hookahCharcoal.append(item)
//                }
//            }
//            else if item.category == "Вейп" Х
//                        if item.type == "Вейп" {
//                self.vapeVape.append(item)
//            } else if item.type == "Жидкость" {
//                self.vapeLiquid.append(item)
//            }
//        }
//    }
}
