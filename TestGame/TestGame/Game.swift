//
//  Game.swift
//  TestGame
//
//  Created by user on 16.08.2022.
//

import Foundation
import UIKit

enum StatusGame{      //создадим глобальный енум
    case start
    case win
    case lose
}

class Game {
    
    struct Item {                      //2 свойства в структуре айтэм, первое тайтл и второе по умолчанию фолс и когда надо                                    будет скрыть айтем - тогда тру, Структура находится в классе Гейм и сможет работать                                   только с ним (структура в классе!!!)
        
        var tittle:String
        var isFound:Bool = false
        
    }
    
    
    private let data = Array(1...99)
    var items:[Item] = []      //создаем массив из айтемов (изначально он пустой)
                                       //чтобы знать сколько у нас айтемов создадим свойство countItems и будем передавать это свойство в ините, когда будем создавать экземпляр класса Гейм и передавать кол во кнопок и айтемов
    
    
    
    private var countItems:Int
    var nextItem:Item?            // (будущее) след айтем который нужно найти будет опшинал айтем, опшинал потому что в конце                           игры не будет чисел а будет нил
    
    var status:StatusGame = .start{
        didSet{
            if status != .start{
                stopGame()
            }
        }
    }
        
    
    private var timeForGame:Int {
        didSet {
            if timeForGame == 0 {
                status = .lose
            }
        }
    }
    
    private var timer:Timer?
    private var updateTimer:((StatusGame,Int)->Void)
        
    
    init(countItems:Int, time:Int, updateTimer:( status:StatusGame, seconds:Int)->Void) {
        
        
        //че значит инициализация в ините?
        self.countItems = countItems
        self.timeForGame = time
        self.updateTimer = updateTimer
        setupGame()
    }
    
                                        //Приступаем к созданию айтемов - создаем простую функцию Сетапгейм (цель создать неповторяющийся айтемы в кол ве равным countItems, для каждой игры будем создавать временный массив - digits
        private func setupGame(){
            var digits = data.shuffled()           //массив дата.перемешанный
    
            while items.count < countItems {        //создаем цикл - пока массив наших айтемов меньше countItems мы создаем                                       новые айтемы, для этого создаем тайтл и берем его с массивa диджитс и                                         преобразуем его в строку, но нам надо сделать так чтобы оно не                                                повторялось - отлично подойдет метод removeFirst
               
                
                let item = Item(tittle: String(digits.removeFirst()))
                                                  
                
                
                
                                                    // после этого кладем наш айтем в массив айтемс
                items.append(item)
            
            
                                              //========= Щас сделаем свойство для лэйбл чтобы каждый раз новое рандом число появлялось
            
            
            }
            nextItem = items.shuffled().first  //перемешали айтемы и берем по порядку с первой из перемешанного списка
        
            updateTimer(status,timeForGame)
            
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] (_) in
                self?.timeForGame -= 1
                
            })
        }
    func check(index:Int){                                      //передаем индекс в функцию чек
        
        if items[index].tittle == nextItem?.tittle{             //если верно нажали на кнопку то будем
            items[index].isFound = true                         //скрывать текущий айтем по индексу
            
            nextItem = items.shuffled().first(where: { (item) ->  Bool in   //обновить некст айтем, берем первый перемешанный                                                       но с условием (нам не нужны айтемсы которые уже найдены)
                
            item.isFound == false
            })
            
       
            
            
        }
        
        if nextItem == nil{      //если у нас больше нет айтемов которые нужно искать - значит мы выиграли
            status = .win
        }
    }
    
    private func stopGame() {
        timer?.invalidate()
    }
}
