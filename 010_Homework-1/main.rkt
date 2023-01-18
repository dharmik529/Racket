#lang racket/base

(define-struct leaf [])
(define-struct tree (num left right))



(define (tree-sum atree)
  (cond
  [ (leaf? atree) 0]
  [ (tree? atree) (+ (tree-num atree)
                     (tree-sum (tree-left atree))
                     (tree-sum (tree-right atree)))]))

(define (negate-tree atree output-tree)
  (cond
  [ (leaf? atree) 0]
  [ (tree? atree) ( )]))

(provide tree-sum negate-tree)

;;; https://www.cs.unb.ca/~bremner/teaching/cs4613/racket/plait-demo.rkt/