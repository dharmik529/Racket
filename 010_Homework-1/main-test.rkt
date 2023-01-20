#lang plait
(require "main.rkt")

(define empty-tree (leaf 0))
(define tree-one (node 1 (leaf 2) (leaf 3)))
(define tree-two (node 1 (node 2 empty-tree empty-tree)
                       (node 3 (node 4 empty-tree empty-tree)
                             empty-tree)))

(define neg-tree-one (node -1 (leaf -2) (leaf -3)))
(define neg-tree-two (node -1 (node -2 empty-tree empty-tree)
                           (node -3 (node -4 empty-tree empty-tree)
                                 empty-tree)))

;;; Test for Q1
(test (tree-sum empty-tree) 0)
(test (tree-sum tree-one) 6)
(test (tree-sum tree-two) 10)

;;; Test for Q2
(test (negate-tree tree-one) neg-tree-one)
(test (negate-tree tree-two) neg-tree-two)

;;; Test for Q3
(test (contains? tree-one 6) #f)
(test (contains? tree-one 3) #t)
(test (contains? tree-two 1) #t)
(test (contains? tree-two 9) #f)

;;; Test for Q4
(test (big-leaves? (node 5 (leaf 6) (leaf 7))) #t)
(test (big-leaves? (node 5 (node 2 (leaf 8) (leaf 6)) (leaf 7))) #f)

;;; Test for Q5
(test (positive-trees? (cons (leaf 6) empty)) #t)

(test (positive-trees? (cons (leaf -6) empty)) #f)

(test (positive-trees? (cons (node 1 (leaf 6) (leaf -6)) empty)) #t)

(test (positive-trees? (cons (node 1 (leaf 6) (leaf -6))
                             (cons (node 0 (leaf 0) (leaf 1))
                                   empty))) #t)

(test (positive-trees? (cons (node -1 (leaf 6) (leaf -6))
                             (cons (node 0 (leaf 0) (leaf 1))
                                   empty))) #f)