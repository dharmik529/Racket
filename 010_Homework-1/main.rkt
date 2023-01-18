#lang racket/base

(define-struct leaf [])
(define-struct tree (num left right))

(define empty-tree (make-leaf))
(define tree-one (make-tree 3 empty-tree empty-tree))
(define tree-two (make-tree 1 (make-tree 2 empty-tree empty-tree)
                              (make-tree 3 (make-tree 4 empty-tree empty-tree)
                                            empty-tree)))

(define (tree-sum atree)
  (cond
  [ (leaf? atree) 0]
  [ (tree? atree) (+ (tree-num atree)
                     (tree-sum (tree-left atree))
                     (tree-sum (tree-right atree)))]))

(provide tree-sum empty-tree tree-one tree-two)

;;; https://www.cs.unb.ca/~bremner/teaching/cs4613/racket/plait-demo.rkt/