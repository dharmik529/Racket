#lang plait

; -------------------------------------------
; FUNCTOR
; -------------------------------------------

(define (even? n) (eq? (modulo n 2) 0))

; -------------------------------------------
; UNIVERSAL UNITARIANISM
; -------------------------------------------

(define (list-unit x) : (Listof 'x)
  (cons x '()))

(define (list-even? [n : Number]) : (Listof Number)
  (if (eq? (modulo n 2) 0)
      (list-unit n)
      '()))

(define (my-filter predicate lst)
  (map predicate lst))

; -------------------------------------------
; JOIN
; -------------------------------------------

(define (list-join xss)
  (foldr (λ ([ y  : (Listof 'a)]
              [ ys : (Listof 'a)]) (append y ys))
    empty xss))

; -------------------------------------------
; BIND
; -------------------------------------------

(define (list-bind lst f)
  (list-join (map f lst)))

(define (get-referrals customer)
  (map (λ ([n : String])
    (string-append (string-append customer " referral: ") n))
    '("1" "2" "3")))

(define (get-customer-referrals customers)
  (list-bind customers get-referrals))


; -------------------------------------------
; TESTS
; -------------------------------------------

(test (map even? '(1 2 3)) '(#f #t #f))
(test (list-unit 3) '(3))
(test (list-even? 3) '())
(test (list-even? 2) '(2))
(test (my-filter list-even? '(1 2 3)) '(() (2) ()))
(test (list-join '(() (2) ())) '(2))
(test (list-join (my-filter list-even? '(1 2 3))) '(2))
(test (list-bind '(1 2 3) list-even?) '(2))

(test (get-referrals "Dave")
      '("Dave referral: 1"
        "Dave referral: 2"
        "Dave referral: 3"))

(test (get-customer-referrals '("Dave" "John"))
      '("Dave referral: 1"
        "Dave referral: 2"
        "Dave referral: 3"
        "John referral: 1"
        "John referral: 2"
        "John referral: 3"))
