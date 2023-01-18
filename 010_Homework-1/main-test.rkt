#lang racket/base

(require rackunit "main.rkt")
(require rackunit/text-ui)

(define empty-tree (make-leaf))
(define tree-one (make-tree 3 empty-tree empty-tree))
(define tree-two (make-tree 1 (make-tree 2 empty-tree empty-tree)
                              (make-tree 3 (make-tree 4 empty-tree empty-tree)
                                            empty-tree)))

(define neg-tree-one (make-tree -3 empty-tree empty-tree))
(define neg-tree-two (make-tree -1 (make-tree -2 empty-tree empty-tree)
                              (make-tree -3 (make-tree -4 empty-tree empty-tree)
                                            empty-tree)))

(define main-test
  (test-suite
  "Test for main-test"
    (test-case
      "Test for tree-sum"
      (check-eq?(tree-sum empty-tree) 0 "Not equal")
      (check-eq?(tree-sum tree-one) 3 "Not equal")
      (check-eq?(tree-sum tree-two) 10 "Not equal"))
    (test-case
      "Test for tree-sum"
      (check-eq?(negate-tree empty-tree) 0 "Not negated")
      (check-eq?(negate-tree tree-one) neg-tree-one "Not negated")
      (check-eq?(negate-tree tree-two) neg-tree-two "Not negated"))  
    ))

(run-tests tree-sum-test)