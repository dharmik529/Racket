#lang plait

;;; (define-struct leaf [])
;;; (define-struct tree (num left right))

(define-type Tree 
    (leaf [val : Number]) 
    (node [val : Number] 
          [left : Tree] 
          [right : Tree]))


;;; Implement a sum function that takes a tree and returns the 
;;; sum of the numbers in the tree. 
(define (tree-sum atree)
  (cond
  [ (leaf? atree) (leaf-val atree)]
  [ (node? atree) (+(+ (node-val atree) (tree-sum (node-left atree))) (tree-sum (node-right atree)))]))

;;; Implement the function negate, which takes a tree and returns 
;;; a tree that has the same shape, but with all the numbers negated.
(define (negate-tree atree)
  (cond [ (leaf? atree) (leaf (* (leaf-val atree) -1))]
        [ (node? atree) (node (* (node-val atree) -1) (negate-tree (node-left atree)) (negate-tree (node-right atree)))]))

;;; Implement the function contains?, which takes a tree and a number 
;;; and returns #t if the number is in the tree, #f otherwise.
