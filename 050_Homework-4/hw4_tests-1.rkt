#lang plait

(require "store-with.rkt")

(module+ test
  (test (parse `2)
        (numE 2))
  (test (parse `x) ; note: backquote instead of normal quote
        (idE 'x))
  (test (parse `{+ 2 1})
        (plusE (numE 2) (numE 1)))
  (test (parse `{* 3 4})
        (multE (numE 3) (numE 4)))
  (test (parse `{+ {* 3 4} 8})
        (plusE (multE (numE 3) (numE 4))
               (numE 8)))
  (test (parse `{let {[x {+ 1 2}]}
                  y})
        (letE 'x (plusE (numE 1) (numE 2))
              (idE 'y)))
  (test (parse `{lambda {x} 9})
        (lamE 'x (numE 9)))
  (test (parse `{double 9})
        (appE (idE 'double) (numE 9)))
  (test (parse `{box 0})
        (boxE (numE 0)))
  (test (parse `{unbox b})
        (unboxE (idE 'b)))
  (test (parse `{set-box! b 0})
        (setboxE (idE 'b) (numE 0)))
  (test (parse `{begin 1 2})
        (beginE (list (numE 1) (numE 2))))
  ;;(test (parse `{record {x 2} {y 3}})
  ;;      (recordE (list 'x 'y)
  ;;               (list (numE 2) (numE 3))))
  ;;(test (parse `{get {+ 1 2} a})
  ;;      (rgetE (plusE (numE 1) (numE 2)) 'a))
  ;;(test (parse `{set! {+ 1 2} a 7})
  ;;      (rsetE (plusE (numE 1) (numE 2)) 'a (numE 7)))
  (test/exn (parse `{{+ 1 2}})
            "invalid input")

  (test (interp (parse `2) mt-env mt-store)
        (v*s (numV 2) 
             mt-store))
  (test/exn (interp (parse `x) mt-env mt-store)
            "free variable")
  (test (interp (parse `x) 
                (extend-env (bind 'x (numV 9)) mt-env)
                mt-store)
        (v*s (numV 9)
             mt-store))
  (test (interp (parse `{+ 2 1}) mt-env mt-store)
        (v*s (numV 3)
             mt-store))
  (test (interp (parse `{* 2 1}) mt-env mt-store)
        (v*s (numV 2)
             mt-store))
  (test (interp (parse `{+ {* 2 3} {+ 5 8}})
                mt-env
                mt-store)
        (v*s (numV 19)
             mt-store))
  (test (interp (parse `{lambda {x} {+ x x}})
                mt-env
                mt-store)
        (v*s (closV 'x (plusE (idE 'x) (idE 'x)) mt-env)
             mt-store))
  (test (interp (parse `{let {[x 5]}
                          {+ x x}})
                mt-env
                mt-store)
        (v*s (numV 10)
             mt-store))
  (test (interp (parse `{let {[x 5]}
                          {let {[x {+ 1 x}]}
                            {+ x x}}})
                mt-env
                mt-store)
        (v*s (numV 12)
             mt-store))
  (test (interp (parse `{let {[x 5]}
                          {let {[y 6]}
                            x}})
                mt-env
                mt-store)
        (v*s (numV 5)
             mt-store))
  (test (interp (parse `{{lambda {x} {+ x x}} 8})
                mt-env
                mt-store)
        (v*s (numV 16)
             mt-store))
  (test (interp (parse `{box 5})
                mt-env
                mt-store)
        (v*s (boxV 1)
             (override-store (cell 1 (numV 5))
                             mt-store)))
  (test (interp (parse `{unbox {box 5}})
                mt-env
                mt-store)
        (v*s (numV 5)
             (override-store (cell 1 (numV 5))
                             mt-store)))
  (test (interp (parse `{set-box! {box 5} 6})
                mt-env
                mt-store)
        (v*s (numV 6)
             (override-store (cell 1 (numV 6))
                             mt-store)))
  (test (interp (parse `{begin 1 2})
                mt-env
                mt-store)
        (v*s (numV 2)
             mt-store))
  (test (interp (parse `{begin 1 2 3})
                mt-env
                mt-store)
        (v*s (numV 3)
             mt-store))
  (test (interp (parse `{unbox {begin {box 5} {box 6}}})
                mt-env
                mt-store)
        (v*s (numV 6)
             (override-store (cell 2 (numV 6))
                             (override-store (cell 1 (numV 5))
                                             mt-store))))
  (test (interp (parse `{let {[b (box 5)]}
                          {begin
                            {set-box! b 6}
                            {unbox b}}})
                mt-env
                mt-store)
        (v*s (numV 6)
             (override-store (cell 1 (numV 6))
                             mt-store)))
  
  (test/exn (interp (parse `{1 2}) mt-env mt-store)
            "not a function")
  (test/exn (interp (parse `{+ 1 {lambda {x} x}}) mt-env mt-store)
            "not a number")
  (test/exn (interp (parse `{let {[bad {lambda {x} {+ x y}}]}
                              {let {[y 5]}
                                {bad 2}}})
                    mt-env
                    mt-store)
            "free variable")
  (test/exn (interp (parse `{unbox 1}) mt-env mt-store)
            "not a box")
  (test/exn (interp (parse `{set-box! 1 1}) mt-env mt-store)
            "not a box")
  ;;(test/exn (interp (parse `{get 1 x}) mt-env mt-store)
  ;;          "not a record")
  ;;(test/exn (interp (parse `{set! 1 x 2}) mt-env mt-store)
  ;;          "not a record")
  ;;(test (interp-expr (parse `{+ 1 4}))
  ;;      `5)
  ;;(test (interp-expr (parse `{lambda {x} x}))
  ;;      `function)
  ;;(test (interp-expr (parse `{box 4}))
  ;;      `box)
  ;;(test (interp-expr (parse `{record {a 10} {b {+ 1 2}}}))
  ;;      `record)
  ;;(test (interp-expr (parse `{get {record {a 10} {b {+ 1 0}}} b}))
  ;;      `1)
  ;;(test/exn (interp-expr (parse `{get {record {a 10}} b}))
  ;;          "no such field")
  ;;(test (interp-expr (parse `{get {record {r {record {z 0}}}} r}))
  ;;      `record)
  ;;(test (interp-expr (parse `{get {get {record {r {record {z 0}}}} r} z}))
  ;;      `0)

  ;;(test (interp-expr (parse `{let {[z {box 1}]}
  ;;                            {begin
  ;;                             {record {x {set-box! z 2}}}
  ;;                             {unbox z}}}))
  ;;     `2)
  ;;(test (interp-expr (parse `{let {[z {box 0}]}
  ;;                            {begin
  ;;                             {record
  ;;                              {x {set-box! z {+ {unbox z} 1}}}
  ;;                              {y {set-box! z {+ {unbox z} 2}}}}
  ;;                             {unbox z}}}))
  ;;     `3)

  ;;(test (interp-expr (parse `{let {[r {record {x 1}}]}
  ;;                             {get r x}}))
  ;;      `1)

  ;;(test (interp-expr (parse `{let {[z {box 1}]}
  ;;                            {let {[r {record {x 1}}]}
  ;;                             {begin
  ;;                              {get {begin {set-box! z 2} r} x}
  ;;                              {unbox z}}}}))
  ;;      `2)

 #|
  (test (interp-expr (parse `{let {[r {record {x 1}}]}
                               {begin
                                 {set! r x 5}
                                 {get r x}}}))
        `5)
  
  (test (interp-expr (parse `{let {[r {record {x 1}}]}
                               {let {[get-r {lambda {d} r}]}
                                 {begin
                                   {set! {get-r 0} x 6}
                                   {get {get-r 0} x}}}}))
        `6)

  (test (interp-expr (parse `{let {[g {lambda {r} {get r a}}]}
                               {let {[s {lambda {r} {lambda {v} {set! r b v}}}]}
                                 {let {[r1 {record {a 0} {b 2}}]}
                                   {let {[r2 {record {a 3} {b 4}}]}
                                     {+ {get r1 b}
                                        {begin
                                          {{s r1} {g r2}}
                                          {+ {begin
                                               {{s r2} {g r1}}
                                               {get r1 b}}
                                             {get r2 b}}}}}}}}))
        `5)

  (test (interp-expr (parse `{let {[r1 {record {x 1}}]}
                               {let {[r2 r1]}
                                 {begin
                                   {set! r1 x 2}
                                   {get r2 x}}}}))
        `2)
  (test (interp-seq (list (numE 1)) mt-env mt-store)
        (v*s (numV 1) mt-store))
  (test (interp-seq (list (boxE (numE 1)) (numE 2)) 
                    mt-env 
                    mt-store)
        (v*s (numV 2) (override-store (cell 1 (numV 1))
                                      mt-store)))
  (test (interp-record empty empty mt-env mt-store)
        (v*s (recV empty empty) mt-store))
  (test (interp-record (list 'x 'y) (list (numE 7) (numE 8)) mt-env mt-store)
        (v*s (recV (list 'x 'y) (list 1 2))
             (override-store (cell 2 (numV 8))
                             (override-store (cell 1 (numV 7))
                                             mt-store))))
   (test (max-address mt-store)
        0)
  (test (max-address (override-store (cell 2 (numV 9))
                                     mt-store))
        2)
  
  (test (fetch 2 (override-store (cell 2 (numV 9))
                                 mt-store))
        (numV 9))
  (test (fetch 2 (override-store (cell 2 (numV 10))
                                 (override-store (cell 2 (numV 9))
                                                 mt-store)))
        (numV 10))
  (test (fetch 3 (override-store (cell 2 (numV 10))
                                 (override-store (cell 3 (numV 9))
                                                 mt-store)))
        (numV 9))
  (test/exn (fetch 2 mt-store)
            "unallocated location")

  (test (update-store (cell 1 (numV 2)) mt-store)
        (override-store (cell 1 (numV 2)) mt-store))
  (test (update-store (cell 1 (numV 3))
                      (override-store (cell 1 (numV 2)) 
                                      mt-store))
        (override-store (cell 1 (numV 3)) mt-store))
  (test (update-store (cell 1 (numV 3))
                      (override-store (cell 2 (numV 2)) 
                                      mt-store))
        (override-store (cell 2 (numV 2))
                        (override-store (cell 1 (numV 3)) 
                                        mt-store))))|#)