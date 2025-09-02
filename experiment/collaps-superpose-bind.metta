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
;; what if we have sth like this

(Player (A 0.5))
(Player (B 0.6))
(Player (C 0.3))
(Player (D 0.7))
(Player (E 0.4))

;; not quite what was intended for but .. I learned how match queries are treated in minimal metta
! (eval
    (collapse
        (chain 
            (eval (match &self (Player ($name $score))
                (chain (eval (>= $score 0.5)) $r
                    (eval (if-equal $r True
                        ($name $score)
                        (Empty)))))) $result $result)))

;; wihtout the top most collapse (Empty) is returned as (Empty) -- not recognized                        