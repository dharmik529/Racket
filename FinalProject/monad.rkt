#lang plait

; -------------------------------------------
; FUNCTOR
; -------------------------------------------

; In a monad, a functor is used to apply a pure function to a value in the context of the monad,
; while preserving the structure of the monad.
; This functor function which looks for even numbers and uses the map test function to map it to a list which is false or true
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
; Function is list-join which takes a list of lists as input and returns a single list that concatenates all
; sub-lists in the input list
; foldr is the function which is taking the binary operator (lambda) which takes 2 lists and applies lambda to the two lists
; this return their concatenation using the append function
; initial foldr function is the empty lists which is the identiy element for the append operation.
(define (list-join xss)
  (foldr (λ ([ y  : (Listof 'a)]
              [ ys : (Listof 'a)]) (append y ys))
    empty xss))

; -------------------------------------------
; BIND
; -------------------------------------------

(define (list-bind lst f)
  (list-join (map f lst)))

; writer monad
(define (get-referrals customer)
  (map (λ ([n : String])
    (string-append (string-append customer " referral: ") n))
    '("1" "2" "3")))

(define (get-customer-referrals customers)
  (list-bind customers get-referrals))


; -------------------------------------------
; TESTS
; -------------------------------------------

(test (map even? '(1 2 3)) '(#f #t #f)) ;maps with the functor which is usign the module in order to determine a false and true value for even numbers.
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
