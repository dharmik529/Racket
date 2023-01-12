#lang plait 


(define (==> [sunny : Boolean] [friday : Boolean] ) : Boolean
  (or (not sunny) friday)) 

(test (==> #t #t) #t)
(test (==> #t #f) #f)
(test (==> #f #t) #t)
(test (==> #f #f) #t)
;;; (test (==> 1 #t) #t)




(define (interest deposit)
  (cond 
    ([< deposit 1000] 0.04 )
    ([< deposit 5000] 0.045 )
    ([>= deposit 5000] 0.05 )
    ))


(test (interest 0) 0.04)
(test (interest 1) 0.04)
(test (interest 1001) 0.045)
(test (interest 5001) 0.05)
(test (interest -5001) 0.04)


(define-type Desk
  (tudy [l : Number]
        [w : Number])
  (3d [l : Number]
      [w : Number]
      [h : Number]))

(define (get-area [somedesk : Desk])
  (type-case Desk somedesk
  [(tudy l w) (* l w)]
  [(3d l w h) (* l w )]
  ))


(test (get-area (tudy 1 2)) 2)
(test (get-area (3d 1 2 3)) 6)
