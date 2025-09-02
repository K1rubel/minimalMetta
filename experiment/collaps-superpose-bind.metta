!(pragma! interpreter bare-minimal)

(= (xoo a) xa) 
(= (xoo b) xb) 

! (chain
    (collapse-bind (eval (xoo $a))) $c
    ($c $a))

! (eval (collapse (chain
    (collapse-bind (eval (xoo $a))) $c
    (chain
        (superpose-bind $c) $x
        ($x $a)))))    

;; I feel like this collapse/superpose-bind thing could be super useful -- just dont know when and where for now        