#lang plait

(define (interp exp env)
  (cond
    [(number? exp) exp]
    [(symbol? exp) (lookup env exp)]
    [(list? exp)     (let ((op (car exp))           (args (cdr exp)))       (cond         [(eq? op '+) (apply-op + args env)]
         [(eq? op '-) (apply-op - args env)]
         [(eq? op '*) (apply-op * args env)]
         [(eq? op '/) (apply-op / args env)]
         [(eq? op 'define) (define-var env (car args) (interp (cadr args) env))]
         [(eq? op 'lambda) (make-closure env (cadr args) (cddr args))]
         [(procedure? op) (apply op (map (lambda (arg) (interp arg env)) args))]
         [else (error "Unrecognized operator: " op)]))]))

(define (apply-op op args env)
  (if (null? args)
      0
      (let ((arg-vals (map (lambda (arg) (interp arg env)) args)))
        (if (null? (cdr arg-vals))
            (car arg-vals)
            (apply op arg-vals)))))

(define (define-var env var value)
  (set-car! env (cons (cons var value) (car env)))
  'ok)

(define (make-closure env params body)
  (lambda (args) (interp-sequence body (extend-env env params args))))

(define (extend-env env params args)
  (cons (zip params args) env))

(define (zip params args)
  (if (or (null? params) (null? args))
      '()
      (cons (cons (car params) (car args)) (zip (cdr params) (cdr args)))))
