#lang plait

(define m 3)
(define b 0)
(define line 
  (λ (m b x)
  (+ b (* m x))))

(define pnts '(1 2 3 4 5 6 7 8 9))
(map (λ (x) (+ x 1)) pnts)
(map (λ (pnt) (line m b pnt)) pnts)