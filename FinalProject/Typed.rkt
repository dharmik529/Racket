#lang typed/racket

; -------------------------------------------
; FUNCTOR
; -------------------------------------------

(: even? (-> Integer Boolean))
(define (even? n) (eq? (modulo n 2) 0))

; -------------------------------------------
; TESTS
; -------------------------------------------
(struct: (a) Box ([open : a]))

(: box-map (All (a b) (-> (-> a b) (Box a) (Box b))))
(define (box-map f bx)
  (Box (f (Box-open bx))))

(: box-unit (All (a) (-> a (Box a))))
(define (box-unit x) (Box x))

(: box-join (All (a) (-> (Box (Box a)) (Box a))))
(define (box-join bx) (Box-open bx))

(: box-bind (All (a b) (-> (Box a) (-> a (Box b)) (Box b))))
(define (box-bind ma f) (box-join (box-map f ma)))

(: box-even? (-> Integer (Box Boolean)))
(define (box-even? n)
  (if (eq? (modulo n 2) 0)
    (Box #t)
    (Box #f)))

(: box-return (All (a) (-> a (Box a))))
(define (box-return x)
  (box-unit x))

(: imperative-1 (-> Integer (Box String)))
(define (imperative-1 n)
  (box-bind (box-even? n) (λ: ([b : Boolean])
  (box-return (if b "Even" "Odd")))))

(map even? '(1 2 3))
(eq? (map even? '(1 2 3)) '(#f #t #f))

(eq? (Box-open (box-map add1 (Box 5))) 6)
(eq? (Box-open (box-unit "hello")) "hello")
(eq? (Box-open (box-join (Box (Box "hello")))) "hello")
(eq? (Box-open (box-bind (Box 5) (λ: ([n : Integer]) (box-unit (add1 n))))) 6)
(eq? (Box-open (box-even? 6)) #t)
(eq? (Box-open (box-even? 7)) #f)
(eq? (Box-open (imperative-1 6)) "Even")
(eq? (Box-open (imperative-1 7)) "Odd")