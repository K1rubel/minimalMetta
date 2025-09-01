!(pragma! interpreter bare-minimal)
(= (div $x $y $accum)
   (chain (eval (- $x $y)) $r1
     (chain (eval (< $r1 0)) $r2
       (chain (unify $r2 True
         $accum
         (chain (eval (+ 1 $accum)) $inc
           (chain (eval (div $r1 $y $inc)) $r4 $r4)
         )) $r3 $r3
       )
     )
   )
)
; !(chain (eval (div 35 5 0)) $rr $rr) ; 7

;; minimal metta style list length

(= (length $list)
    (function 
        (unify $list Nil (return 0)
            (unify $list (Cons $x $xs)
                (chain (eval (length $xs)) $r 
                    (chain (eval (+ 1 $r)) $l (return $l))) 
                (return (Error $list unrecognizedFormat))))))

                
; !(eval (length Nil))
; !(eval (length (Cons A Nil)))
; !(eval (length (Cons A (Cons B Nil))))

;; minimal meta t

; ! (set-random-seed &rng 0)
; ! (random-int &rng 0 10)

;; for metta -- random int 
; ; !(bind! seed (py-atom random.seed))
; !(bind! rndint (py-atom random.randint))
; ; ! (seed 42)
; ! (rndint 0 10)
; ; ! (set-seed &rng 10)
; ! (random-int &rng 0 20)
;; for metta -- random int 

;; metta 2.6 appears to have issues with cdr-atom and car-atom with minimal metta
; ! (eval (cdr-atom (q))) ;; throws error
; ! (eval (car-atom (q))) ;; throws error
(= (len $exp)
    (function 
        (eval (if-equal $exp ()
                (return 0)
                (chain (decons-atom $exp) $decons 
                    (unify $decons ($x $y)
                        (chain (eval (len $y)) $r 
                            (chain (eval (+ 1 $r)) $l (return $l)))
                        (return (Error $exp somethigIsWrong))))))))

                        
; ;; using bindings with minimal metta
; ! (eval (len ()))
; ! (eval (len (A)))
; ! (eval (len (A B)))
; ! (eval (len (A B C)))
; ; ! (decons-atom (1))
; ; ! (eval (if-decons-expr (1) $h $t (return 1) 0))
; ! (eval (cons-atom 1 ()))
; ! (eval (union-atom (1) ()))
(= (takeN $exp $n $acc)
    (function 
       (eval (if-equal $n 0
            (return $acc)
            (chain (decons-atom $exp) $decons
                (unify $decons ($x $y)
                    (chain (eval (union-atom $acc ($x))) $new-acc
                        (chain (eval (- $n 1)) $dec
                            (chain (eval (takeN $y $dec $new-acc)) $r (return $r))))
                        (return (Error $n outOfRange))))))))

; ! (eval (takeN (1 2 3) 1 ()))         
; ! (eval (takeN (1 2 3) 2 ()))         
; ! (eval (takeN (1 2 3) 4 ()))         

;; assertEqual for minimal metta
(= (minialAssertEqual $f $val)
    (function 
        (eval (chain (eval $f) $r 
            (eval (if-equal $r $val
                (return ())
                (return (Error $r assertionError))))))))
; ! (eval (assertMinialEqual (len ()) 1))               