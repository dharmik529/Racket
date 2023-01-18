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

;;; (test (tree-sum empty-tree) 0)
;;; (test (tree-sum tree-one) 6)
;;; (test (tree-sum tree-two) 10)

(test (negate-tree tree-one) neg-tree-one)
(test (negate-tree tree-two) neg-tree-two)

  

