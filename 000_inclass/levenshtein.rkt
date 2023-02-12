#lang plait

#|
Hand this is by 5:30 pm today 2/8
Correct code will get you a 10/10
https://en.wikipedia.org/wiki/Levenshtein_distance
|#

(define w1 (string->list "carts"))
(define w2 (string->list "fart"))

(define (dist w1 w2)
  (cond
    [(empty? w1) (length w2)]
    [(empty? w2) (length w1)]
    [(equal? (first w1) (first w2)) 
      (dist (rest w1) (rest w2))]
    [else (+ 1 (mins 
                  (dist w1 (rest w2)) 
                  (dist (rest w1) w2) 
                  (dist (rest w1) (rest w2))))]))


(define (mins x y z
  (min x (min y z)))

(test (dist w1 w2) 2 )

;;; you need to cast the strings to lists first
(test (dist (string->list "wild")
            (string->list "salad"))
      3)
(test (dist (string->list "shart") 
            (string->list "shark"))
      1)

#| Write a test for 7/10 |#
(test (dist (string->list "dhamu") 
            (string->list "dhamu")) 
      0) 

#| For 1/10 points make the following code work |#
(define HarderCourse `469_TheoryOfComputation)
(display HarderCourse)