#lang racket/base

(define-struct leaf [])
(define-struct tree (num left right))


;;; Implement a sum function that takes a tree and returns the 
;;; sum of the numbers in the tree. 
(define (tree-sum atree)
  (cond
  [ (leaf? atree) 0]
  [ (tree? atree) (+ (tree-num atree)
                     (tree-sum (tree-left atree))
                     (tree-sum (tree-right atree)))]))

;;; Implement the function negate, which takes a tree and returns 
;;; a tree that has the same shape, but with all the numbers negated.
(define (negate-tree atree output-tree)
  (cond
  [ (leaf? atree) 0]
  [ (tree? atree) ( )]))

(provide tree-sum negate-tree)

;;; https://www.cs.unb.ca/~bremner/teaching/cs4613/racket/plait-demo.rkt/