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
(define (contains? atree anum)
  (cond [(leaf? atree) (= (leaf-val atree) anum)]
        [(node? atree) (or (= (node-val atree) anum) (contains? (node-left atree) anum) (contains? (node-right atree) anum))]
        [else #f]))

;;; Implement the function big-leaves?, which takes a tree and
;;; returns #t if every leaf is bigger than the sum of numbers in
;;; the path of nodes from the root that reaches the leaf.
(define (bigger-leaves? atree currSum)
  (cond [(leaf? atree) (> (leaf-val atree) currSum)]
        [(node? atree) (and (bigger-leaves? (node-left atree) (+ currSum (node-val atree))) (bigger-leaves? (node-right atree) (+ currSum (node-val atree))))]
        [else #f]))

(define (big-leaves? atree)
  (bigger-leaves? atree 0))

;;; Implement the function positive-trees?, which takes a list of trees
;;; and returns #t if every member of the list is a positive tree, where
;;; a positive tree is one whose numbers sum to a positive value.
(define (positive-trees? alist)
  (cond [(empty? alist) #t]
        [(leaf? (first alist)) (and (> (tree-sum (first alist)) 0) (positive-trees? (rest alist)))]
        [(node? (first alist)) (and (> (tree-sum (first alist)) 0) (positive-trees? (rest alist)))]
        [else #f]))