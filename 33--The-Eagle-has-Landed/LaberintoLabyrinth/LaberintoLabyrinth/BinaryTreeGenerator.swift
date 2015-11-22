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
    var height:Int = 1
    
    init(rootVal:Int)
    {
        root = Node(val: rootVal)
    }

    
    func sortedInsert(value: Int, newNode:Node)
    {
        if newNode.level+1 > height
        {
            height = newNode.level+1
        }
        
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
            newNode.rightNode?.level = 1 + newNode.level

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
            newNode.leftNode?.level = 1 + newNode.level
        }
        
        
    }
    
    func BFSearchMatix(dataNode:Node, size:Int)
    {
        print("Breadth Firs Search :\(dataNode)")

        var Queue: Array<Node> = [];
        Queue.append(dataNode)
        
        
        var matrixNodes: Array<Array<Int>> = []
        
        for x in 1...(height+1)*2
        {
            var row: Array<Int> = []
            
            for y in 1...size
            {

                row.append(0)
            }
            
            matrixNodes.append(row)
        }
        
        print(matrixNodes)
        
        
        
        
        while Queue.count > 0
        {
            let currentNode:Node = Queue.first!
            
            matrixNodes[currentNode.level*2][currentNode.value!] = Int(currentNode.value!)
            matrixNodes[currentNode.level*2+1][currentNode.value!] = 1//Int(currentNode.value!)
            
           doIt(currentNode)
            print("Queue \(Queue)")

            
            if currentNode.leftNode != nil
            {
                Queue.append(currentNode.leftNode!)
                matrixNodes[currentNode.level*2+1] = setPathsSecondRow(currentNode.leftNode!,nodeB:currentNode ,rowArray: matrixNodes[currentNode.level*2+1])//setting the second row, with the connetion with the parent
            }
            if currentNode.rightNode != nil
            {
                Queue.append(currentNode.rightNode!)
                matrixNodes[currentNode.level*2+1] = setPathsSecondRow(currentNode,nodeB: currentNode.rightNode!,rowArray: matrixNodes[currentNode.level*2+1])//setting the second row, with the connetion with the parent

            }
            
            Queue.removeFirst()
            
        }
        
        for x in 1...(height+1)*2
        {
            print(matrixNodes[x-1])

        }
        
    }
    
    func setPathsSecondRow(nodeA:Node,nodeB:Node,var rowArray:Array<Int>) -> Array<Int>
    {
        for x in 1...rowArray.count-1
        {
            if x >= nodeA.value && x <= nodeB.value
            {
                rowArray[x] = 1
            }
            
        }
        
        return rowArray
    }
    
    func doIt(node:Node)
    {
        print("node value \(node.value) level \(node.level)")
    }
    
}