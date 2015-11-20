//
//  BinaryTreeGenerator.swift
//  LaberintoLabyrinth
//
//  Created by Pedro Trujillo on 11/19/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import Foundation

class Node
{
    
    var leftNode:Node?
    var rightNode:Node?
    
    var value:Int?
    var level:Int!
    var rotation:Int!
    
    init(val:Int)
    {
        //leftNode = nil
        //rightNode = nil
        level = 0
        rotation = 90
        value = val
    }
}


class BinaryTree
{
    var root:Node
    
    init(rootVal:Int)
    {
        root = Node(val: rootVal)
    }

    
    func sortedInsert(value: Int, newNode:Node)
    {
        
        if value >= newNode.value
        {
            print("Right")
            if newNode.rightNode != nil
            {
                //print("level")
                sortedInsert(value, newNode: newNode.rightNode!)
            }
            else
            {
                print("insert \(value)")
                newNode.rightNode = Node(val: value)
            }
        }
        else
        {
            print("Left")

            if newNode.leftNode != nil
            {
                //print("level")
                sortedInsert(value, newNode: newNode.leftNode!)
            }
            else
            {
                print("insert \(value)")
                newNode.leftNode = Node(val: value)
            }
        }
    }
    
    func BFSearch(dataNode:Node)
    {
        print("Breadth Firs Search :\(dataNode)")

        var Queue: Array<Node> = [];
        Queue.append(dataNode)
        
        
        
        while Queue.count > 0
        {
            let currentNode:Node = Queue.first!
            
            doIt(currentNode)
            
            if currentNode.leftNode != nil
            {
                Queue.append(currentNode.leftNode!)
            }
            if currentNode.rightNode != nil
            {
                Queue.append(currentNode.rightNode!)
            }
            
            Queue.removeLast()
            
        }
        
    }
    func doIt(node:Node)
    {
        print("node value \(node.value): \(node)")
    }
    
}