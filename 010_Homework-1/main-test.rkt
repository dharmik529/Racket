#lang racket/base

(require rackunit "main.rkt")
(require rackunit/text-ui)

(define tree-sum-test
  (test-suite
    "Test for tree-sum"
    (check-eq?(tree-sum empty-tree) 0 "Not equal")
    (check-eq?(tree-sum tree-one) 3 "Not equal")
    (check-eq?(tree-sum tree-two) 10 "Not equal")))

(run-tests tree-sum-test)