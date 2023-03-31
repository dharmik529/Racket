#lang racket
(require rebellion/type/enum)
(require rebellion/type/tuple)

(define-enum-type direction (up down left right))
(define-tuple-type point (x y))
 
#|
(define/contract (point-move pt dir amount)
  (-> point? direction? real? point?)
  (match-define (point x y) pt)
  (match dir
    [(== up) (point x (+ y amount))]
    [(== down) (point x (- y amount))]
    [(== left) (point (- x amount) y)]
    [(== right) (point (+ x amount) y)]))
|#
(define (point-move [pt : point] [dir : direction] [amount : real]) : point
  (match-define (point x y) pt)
  (match dir
         [(== up) (point x (+ y amount))]
         [(== down) (point x (- y amount))]
         [(== left) (point (- x amount) y)]
         [(== up) (point (- x amount) y)]
         ))
(point-move (point 2 2) up 5)
