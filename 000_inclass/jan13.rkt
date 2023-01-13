#lang racket

;;; Lisps - list processor
(define me_list '(1 2 3 4 5 6 7 8 9 10))
;;; (car me_list)

(define (my_fifth alist)
  (define (aux alist count)
   (if (= count 1)
    (first alist)
    (aux (rest alist) (- count 1))))
  (aux alist 5))

(my_fifth me_list) ;5

(define (doubler x)
  (* x 2))
(define doubler2 
  (λ(x) (* x 2)))

(define a '())
(define (enum alist count output)
  (if (empty? alist)
    output
      (enum (rest alist) 
            (+ count 1) 
            (append output 
           (list (list count (first alist)))))))
(define (enumerate alist)
  (enum alist 0 empty))
(enumerate '(3 4 5 6))
;;; ((0 3 ) (1 4) (2 5) (3 6))
