#lang racket

(provide square total)

(define (square a-square)
  (let ([num (sub1 a-square)])
    (if (or (equal? a-square 1) (equal? a-square 2))
        a-square
        (expt 2 num)))
  )

(define (total)
  (for/sum ([i (in-range 1 65)]) (square i)))
