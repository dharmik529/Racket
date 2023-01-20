#lang plait

(define-type (AE)
  (numE [n : Number])
  (plusE [left : AE]
         [right : AE])
  (minusE [left : AE]
          [right : AE]))

(define (parse s)
  (cond
    ([s-expr-number? s] (s-exp-number s))
    ...))

(define s '(+ 1 (- 2 3)))
