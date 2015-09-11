;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname hwk1a) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Jesse Steedle
; CS3723
; Homework 1a 

(require 2htdp/batch-io)
(require 2htdp/image)
(require 2htdp/universe)

(define WIDTH-OF-WORLD 300)
(define HEIGHT-OF-WORLD 150)
(define BACKGROUND (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD  ))

; size -> width
; sets the width of block in pixels
; factors of 20px
; given 1; expect 20
; given 5; expect 100
(define (size->width s)
  (cond
    [(< s 6) (* s 20)]
    [else 100]))


; size -> color
; sets the color for sizes of blocks from 1-5
; given 1; expect "blue"
; given 5; expect "orange
(define (size->color s)
  (cond
    [(= s 1) "blue"]
    [(= s 2) "red" ]
    [(= s 3) "green"]
    [(= s 4) "violet"]
    [else "orange"]))


; size -> image disk
; creates a disk using the size input
; calls size->width & size->color as attributes
(define (img-disk s)
  (rectangle (size->width s) 10 "solid" (size->color s)))


; List ->  Image
; takes a list of numbers and calls img-disk
; for each value and stacks the images on top
; of the previous
(define (img-twr stack)
  (cond 
    [(null? stack) (circle 0 "solid" "black")]
    [else
     (above
      (img-disk (first stack))
     (img-twr (rest stack)))]))


; takes the initial list of disk sizes(1-5)
; to create the initial stack on a peg
; when window is clicked, first disk in
; list is moved to top.
(define (launch init-disk-stack)
  (big-bang init-disk-stack
            ;[on-mouse select-disk]
            ;[on-key select-disk-key]
            [to-draw render]))

; list -> Image
; takes a list and recursively calls img-twr
(define (render init-disk-stack)
  (cond
    [(null? init-disk-stack) (circle 0 "solid" "black")]
    [else
     (overlay
      (img-twr init-disk-stack)
      (rectangle 10 80 "solid" "black")BACKGROUND)]))

;
;
;(define (select-disk init-disk-stack)
;  (render (rest init-disk-stack)))

;  key -> World
;  takes the world and key
;  determine the key pressed 1-5
;(define (select-disk-key init-disk-stack ke)
;  (cond
;    [(key=? ke "1") (first init-disk-stack)]
;    [(key=? ke "2") (rest init-disk-stack)]
;    [(key=? ke "3") (rest (rest init-disk-stack))]
;    [(key=? ke "4") (rest (rest  (rest init-disk-stack)))]
;    [(key=? ke "5") (rest (rest (rest (rest init-disk-stack))))]))
    

 (launch (cons 1 (cons 2 (cons 3 (cons 4 (cons 5 '()))))))
 

