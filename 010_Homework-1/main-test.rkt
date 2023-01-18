#lang plait

(require "main.rkt")

(define empty-tree (leaf 0))
(define tree-one (node 1 (leaf 2) (leaf 3)))
(define tree-two (node 1 (node 2 empty-tree empty-tree)
                              (node 3 (node 4 empty-tree empty-tree)
                                            empty-tree)))

(define neg-tree-one (node -3 empty-tree empty-tree))
(define neg-tree-two (node -1 (node -2 empty-tree empty-tree)
                              (node -3 (node -4 empty-tree empty-tree)
                                            empty-tree)))

(test (tree-sum tree-one) 6)    
  

