//
//  main.swift
//  practice2
//
//  Created by 이범준 on 2022/01/08.
//

import Foundation

struct Person {
    var name: String
    var money: Int
    
    var coffee: Coffee
    
    func checkMoney() {
        print(money)
    }
    
    func orderCoffee(coffeeShop: CoffeeShop) {
        do {
            let a: String = try coffeeShop.order(coffee: coffee)
            print(a)
        } catch Lack.lackOfMoney {
            print("잔액이 \(-(misterLee.money - coffee.rawValue))만큼 부족합니다.")
        } catch{
            print("some error")
        }
    }
    
    func showMoney() -> Int {
        return money
    }
}

enum Coffee: Int {
    case americano = 2000
    case caramel = 3000
}

enum Lack : Error {
    case lackOfMoney
}

class CoffeeShop {
    var saleMoney: Int
    var person: Person
    var pickUpTable: String?
    
    init(person: Person, saleMoney: Int) {
        self.person = person
        self.saleMoney = saleMoney
    }
    
    func order(coffee: Coffee) throws -> String {
        
        guard person.money >= coffee.rawValue else {
            throw Lack.lackOfMoney
        }
        
        saleMoney = saleMoney + coffee.rawValue
        person.money = person.money - coffee.rawValue
        pickUpTable = "\(person.name)의 커피가 준비되었습니다. 픽업대에서 가져가주세요"
        if let a = pickUpTable {
            return a
        } else {
            return "x"
        }
    }
    
    func checkSaleMoney() {
        print("지금까지의 판매액은 \(saleMoney)입니다.")
    }
}


var misterLee: Person = Person(name: "misterLee", money: 3000, coffee: .caramel)
var yagomCafe: CoffeeShop = CoffeeShop(person: misterLee, saleMoney: 0)

misterLee.orderCoffee(coffeeShop: yagomCafe)
yagomCafe.checkSaleMoney()
