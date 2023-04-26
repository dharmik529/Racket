#lang typed/racket

(: list-unit (All (a) (-> a (Listof a))))

; This function takes an argument 'x' of any type 'a' and returns a list
; containing 'x' as the only element.

(define (list-unit x)
  (cons x '()))

(: list-even? (-> Integer (Listof Integer)))

; This function takes an integer 'n' and checks if it is even.
; If 'n' is even, it returns a list containing 'n' as the only element,
; otherwise, it returns an empty list.

(define (list-even? n)
  (if (eq? (modulo n 2) 0)
      (list-unit n)
      '()))

(: my-filter (All (a) (-> (-> a (Listof a))
                          (Listof a)
                          (Listof (Listof a)))))

; This function takes a predicate function 'predicate' that takes an
; argument of type 'a' and returns a list of elements of type 'a'.
; It also takes a list 'lst' of elements of type 'a' and applies the
; 'predicate' function to each element in the list 'lst' using the
; 'map' function. It returns a list of lists of elements of type 'a'.

(define (my-filter predicate lst)
  (map predicate lst))

(my-filter list-even? '(1 2 3))

; This code calls the 'my-filter' function with the 'list-even?' predicate
; function and the list '(1 2 3)' as arguments. The 'my-filter' function
; applies the 'list-even?' function to each element of the list and returns
; a list of lists, where each sublist contains either one even number or
; an empty list (if the number is odd). The result of this code is
; '((()) (2) ())'.

(: list-join (All (a) (-> (Listof (Listof a)) (Listof a))))
(define (list-join xss)
  (foldr (λ: ([ y  : (Listof a)]
              [ ys : (Listof a)]) (append y ys))
    empty xss))

(: get-referrals (-> String (Listof String)))
(define (get-referrals customer)
  (map (λ: ([n : String])
    (string-append customer " referral: " n))
    '("1" "2" "3")))