#lang plait 

  (define-type Tree
    (leaf [val : Number])
    (node [val : Number]
          [left : Tree]
          [right : Tree]))

(define (sumt [sometree : Tree])
        (type-case Tree sometree
        (cond
        [(leaf? sometree)
                (leaf-val sometree)]
        [(node? sometree)
                (+ (sumt (node-left sometree))
                   (sumt (node-right sometree)))])))



;;; (test (sumt Tree() ))
