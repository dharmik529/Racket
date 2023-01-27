#lang plait
(define option 'extra)

#|PROBLEM 1
returns a list containing n copies of x|#
(define (duple n x)
  (cond [(zero? n) empty]
        [else (cons x (duple (sub1 n) x))]))


(test (duple 2 3)
      '(3 3))
(test (duple 4 '(ha ha))
      '((ha ha) (ha ha) (ha ha) (ha ha)))
(test (duple 0 '(word))
      '())

#|PROBLEM 2
return a sorted list of integers based on operator
less than < ascending
greater than > descending
> |#
(define (merge [op : (Number Number -> Boolean)]
               [int-list1 : (Listof Number)]
               [int-list2 : (Listof Number)]) : (Listof Number)
  (cond
    [(and (empty? int-list1) (empty? int-list2)) '()]
    [(empty? int-list1) (cons (first int-list2) (merge op int-list1 (rest int-list2)))]
    [(empty? int-list2) (cons (first int-list1) (merge op (rest int-list1) int-list2))]
    [(op 0 1) (if (op (first int-list1) (first int-list2))
                  (cons (first int-list1) (merge op (rest int-list1) int-list2))
                  (cons (first int-list2) (merge op int-list1 (rest int-list2))))]
    [(op 1 0) (if (op (first int-list1) (first int-list2))
                  (cons (first int-list1) (merge op (rest int-list1) int-list2))
                  (cons (first int-list2) (merge op int-list1 (rest int-list2))))]))


(test (merge < '(1 4 6) '(2 5 8))
      '(1 2 4 5 6 8))
(test (merge > '(6 4 1) '(8 5 2))
      '(8 6 5 4 2 1))

#|Problem 3
return an association list from a list of symbols and a list of numbers
define a type to allow for the output of a list of associations
?_t is to be replaced with your appropriately named type   |#
(define-type myMap
  (mymap [sym : Symbol]
         [num : Number]))


(define (make-assoc [names : (Listof Symbol)] [values : (Listof Number)]): (Listof myMap)
  (if (empty? names)
      empty
      (cons (mymap (first names) (first values)) (make-assoc(rest names) (rest values)))))

(test (make-assoc '(a b c d) '(1 2 3 4)) (list (mymap 'a 1) (mymap 'b 2) (mymap 'c 3) (mymap 'd 4)))
(test (make-assoc '(w x y z tuesday) '(0 1 34 1729 42)) (list (mymap 'w 0) (mymap 'x 1) (mymap 'y 34) (mymap 'z 1729) (mymap 'tuesday 42)))

