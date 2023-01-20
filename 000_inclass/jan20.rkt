#lang plait
(define (sqr x)
  (* x x))

(map sqr '(1 2 3 4))
(map (λ(x) (+ x 1)) '(1 2 3 4))

(define (mymap f lst)
  (if (empty? lst)
      '()
      (cons (f (first lst)) (mymap f (rest lst)))))

(mymap sqr '(1 2 3 4))