
(deftemplate ioproxy  
   (slot fact-id)       
   (multislot answers)   
   (multislot messages)   
   (slot value)          
)


(deffacts proxy-fact
   (ioproxy
      (fact-id 0112)
      (value none)   
      (messages)    
   )
)

(defrule clear-messages
   (declare (salience 1090))
   ?clear-msg-flg <- (clearmessage)
   ?proxy <- (ioproxy)
   =>
   (modify ?proxy (messages))
   (retract ?clear-msg-flg)
   (printout t "Messages cleared ..." crlf)   
)

(defrule set-output-and-halt
   (declare (salience 1099))
   ?current-message <- (sendmessagehalt ?new-msg)
   ?proxy <- (ioproxy (messages $?msg-list))
   =>
   (printout t "Message set : " ?new-msg " ... halting ..." crlf)
   (modify ?proxy (messages ?new-msg))
   (retract ?current-message)
   (halt)
)

(defrule append-output-and-halt
   (declare (salience 1099))
   ?current-message <- (appendmessagehalt $?new-msg)
   ?proxy <- (ioproxy (messages $?msg-list))
   =>
   (printout t "Messages appended : " $?new-msg " ... halting ..." crlf)
   (modify ?proxy (messages $?msg-list $?new-msg))
   (retract ?current-message)
   (halt)
)

(defrule set-output-and-proceed
   (declare (salience 1099))
   ?current-message <- (sendmessage ?new-msg)
   ?proxy <- (ioproxy)
   =>
   (printout t "Message set : " ?new-msg " ... proceed ..." crlf)
   (modify ?proxy (messages ?new-msg))
   (retract ?current-message)
)

(defrule append-output-and-proceed
   (declare (salience 1099))
   ?current-message <- (appendmessage ?new-msg)
   ?proxy <- (ioproxy (messages $?msg-list))
   =>
   (printout t "Message appended : " ?new-msg " ... proceed ..." crlf)
   (modify ?proxy (messages $?msg-list ?new-msg))
   (retract ?current-message)
)

(defrule print-messages
   (declare (salience 1099))
   ?proxy <- (ioproxy (messages ?msg-list))
   ?update-key <- (updated True)
   =>
   (retract ?update-key)
   (printout t "Messages received : " ?msg-list crlf)
)

;======================================================================================

(defrule rule1
    (declare (salience 1))
    ?fact1 <- (экономичная)
    ?fact2 <- (переднеприводная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: купе из экономичная, переднеприводная."))
    (assert (купе))
)

(defrule rule2
    (declare (salience 1))
    ?fact1 <- (экономичная)
    ?fact2 <- (компактная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: купе из экономичная, компактная."))
    (assert (купе))
)

(defrule rule3
    (declare (salience 1))
    ?fact1 <- (экономичная)
    ?fact2 <- (заднеприводная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: купе из экономичная, заднеприводная."))
    (assert (купе))
)

(defrule rule4
    (declare (salience 2))
    ?fact1 <- (семейная)
    ?fact2 <- (экономичная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: седан из семейная, экономичная."))
    (assert (седан))
)

(defrule rule5
    (declare (salience 2))
    ?fact1 <- (семейная)
    ?fact2 <- (заднеприводная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: седан из семейная, заднеприводная."))
    (assert (седан))
)

(defrule rule6
    (declare (salience 2))
    ?fact1 <- (семейная)
    ?fact2 <- (быстрая)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: седан из семейная, быстрая."))
    (assert (седан))
)

(defrule rule7
    (declare (salience 1))
    ?fact1 <- (представительская)
    ?fact2 <- (вместительная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: седан из представительская, вместительная."))
    (assert (седан))
)

(defrule rule8
    (declare (salience 2))
    ?fact1 <- (семейная)
    ?fact2 <- (переднеприводная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: кроссовер  из семейная, переднеприводная."))
    (assert (кроссовер ))
)

(defrule rule9
    (declare (salience 1))
    ?fact1 <- (компактная)
    ?fact2 <- (внедорожная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: кроссовер из компактная, внедорожная."))
    (assert (кроссовер))
)

(defrule rule10
    (declare (salience 1))
    ?fact1 <- (компактная)
    ?fact2 <- (полноприводная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: кроссовер из компактная, полноприводная."))
    (assert (кроссовер))
)

(defrule rule11
    (declare (salience 1))
    ?fact1 <- (внедорожная)
    ?fact2 <- (полноприводная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: пикап из внедорожная, полноприводная."))
    (assert (пикап))
)

(defrule rule12
    (declare (salience 1))
    ?fact1 <- (полноприводная)
    ?fact2 <- (вместительная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: пикап из полноприводная, вместительная."))
    (assert (пикап))
)

(defrule rule13
    (declare (salience 1))
    ?fact1 <- (полноприводная)
    ?fact2 <- (экономичная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: пикап из полноприводная, экономичная."))
    (assert (пикап))
)

(defrule rule14
    (declare (salience 1))
    ?fact1 <- (мощная)
    ?fact2 <- (внедорожная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: внедорожник из мощная, внедорожная."))
    (assert (внедорожник))
)

(defrule rule15
    (declare (salience 1))
    ?fact1 <- (вместительная)
    ?fact2 <- (внедорожная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: внедорожник из вместительная, внедорожная."))
    (assert (внедорожник))
)

(defrule rule16
    (declare (salience 1))
    ?fact1 <- (представительская)
    ?fact2 <- (внедорожная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: внедорожник из представительская, внедорожная."))
    (assert (внедорожник))
)

(defrule rule17
    (declare (salience 1))
    ?fact1 <- (представительская)
    ?fact2 <- (полноприводная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: внедорожник из представительская, полноприводная."))
    (assert (внедорожник))
)

(defrule rule18
    (declare (salience 1))
    ?fact1 <- (внедорожная)
    ?fact2 <- (быстрая)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: внедорожник из внедорожная, быстрая."))
    (assert (внедорожник))
)

(defrule rule19
    (declare (salience 1))
    ?fact1 <- (экономичная)
    ?fact2 <- (полноприводная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: внедорожник из экономичная, полноприводная."))
    (assert (внедорожник))
)

(defrule rule20
    (declare (salience 1))
    ?fact1 <- (переднеприводная)
    ?fact2 <- (вместительная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: микроавтобус из переднеприводная, вместительная."))
    (assert (микроавтобус))
)

(defrule rule21
    (declare (salience 1))
    ?fact1 <- (экономичная)
    ?fact2 <- (вместительная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: микроавтобус из экономичная, вместительная."))
    (assert (микроавтобус))
)

(defrule rule22
    (declare (salience 1))
    ?fact1 <- (заднеприводная)
    ?fact2 <- (мощная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: спорткар из заднеприводная, мощная."))
    (assert (спорткар))
)

(defrule rule23
    (declare (salience 1))
    ?fact1 <- (заднеприводная)
    ?fact2 <- (спортивная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: спорткар из заднеприводная, спортивная."))
    (assert (спорткар))
)

(defrule rule24
    (declare (salience 1))
    ?fact1 <- (спортивная)
    ?fact2 <- (быстрая)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: спорткар из спортивная, быстрая."))
    (assert (спорткар))
)

;======================================================================================

(defrule rule25
    (declare (salience 10))
    ?fact1 <- (экономичная)
    ?fact2 <- (купе)
    (antonym ?antonym&~дорогая)
    (antonym ?antonym&~средней_ценновой_категории)
    (antonym ?antonym&~очень_дорогая)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: бюджетная из экономичная, купе."))
    (assert (бюджетная))
)

(defrule rule26
    (declare (salience 11))
    ?fact1 <- (экономичная)
    ?fact2 <- (седан)
    (antonym ?antonym&~дорогая)
    (antonym ?antonym&~средней_ценновой_категории)
    (antonym ?antonym&~очень_дорогая)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: бюджетная из экономичная, седан."))
    (assert (бюджетная))
)

(defrule rule27
    (declare (salience 10))
    ?fact1 <- (экономичная)
    ?fact2 <- (внедорожник)
    (antonym ?antonym&~дорогая)
    (antonym ?antonym&~средней_ценновой_категории)
    (antonym ?antonym&~очень_дорогая)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: бюджетная из экономичная, внедорожник."))
    (assert (бюджетная))
)

(defrule rule28
    (declare (salience 10))
    ?fact1 <- (мощная)
    ?fact2 <- (внедорожник)
    (antonym ?antonym&~бюджетная)
    (antonym ?antonym&~средней_ценновой_категории)
    (antonym ?antonym&~экономичная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: дорогая из мощная, внедорожник."))
    (assert (дорогая))
)

(defrule rule29
    (declare (salience 11))
    ?fact1 <- (семейная)
    ?fact2 <- (внедорожник)
    (antonym ?antonym&~бюджетная)
    (antonym ?antonym&~средней_ценновой_категории)
    (antonym ?antonym&~экономичная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: дорогая из семейная, внедорожник."))
    (assert (дорогая))
)

(defrule rule30
    (declare (salience 11))
    ?fact1 <- (быстрая)
    ?fact2 <- (седан)
    (antonym ?antonym&~бюджетная)
    (antonym ?antonym&~средней_ценновой_категории)
    (antonym ?antonym&~экономичная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: дорогая из быстрая, седан."))
    (assert (дорогая))
)

(defrule rule31
    (declare (salience 10))
    ?fact1 <- (быстрая)
    ?fact2 <- (купе)
    (antonym ?antonym&~бюджетная)
    (antonym ?antonym&~средней_ценновой_категории)
    (antonym ?antonym&~экономичная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: дорогая из быстрая, купе."))
    (assert (дорогая))
)

(defrule rule32
    (declare (salience 10))
    ?fact1 <- (быстрая)
    ?fact2 <- (внедорожник)
    (antonym ?antonym&~бюджетная)
    (antonym ?antonym&~средней_ценновой_категории)
    (antonym ?antonym&~экономичная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: дорогая из быстрая, внедорожник."))
    (assert (дорогая))
)

(defrule rule33
    (declare (salience 10))
    ?fact1 <- (пикап)
    ?fact2 <- (мощная)
    (antonym ?antonym&~бюджетная)
    (antonym ?antonym&~средней_ценновой_категории)
    (antonym ?antonym&~экономичная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: дорогая из пикап, мощная."))
    (assert (дорогая))
)

(defrule rule34
    (declare (salience 10))
    ?fact1 <- (мощная)
    ?fact2 <- (купе)
    (antonym ?antonym&~бюджетная)
    (antonym ?antonym&~средней_ценновой_категории)
    (antonym ?antonym&~экономичная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: дорогая из мощная, купе."))
    (assert (дорогая))
)

(defrule rule35
    (declare (salience 11))
    ?fact1 <- (семейная)
    ?fact2 <- (кроссовер)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: средней_ценновой_категории из семейная, кроссовер."))
    (assert (средней_ценновой_категории))
)

(defrule rule36
    (declare (salience 12))
    ?fact1 <- (семейная)
    ?fact2 <- (седан)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: средней_ценновой_категории из семейная, седан."))
    (assert (средней_ценновой_категории))
)

(defrule rule37
    (declare (salience 10))
    ?fact1 <- (микроавтобус)
    ?fact2 <- (вместительная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: средней_ценновой_категории из микроавтобус, вместительная."))
    (assert (средней_ценновой_категории))
)

(defrule rule38
    (declare (salience 11))
    ?fact1 <- (седан)
    ?fact2 <- (переднеприводная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: средней_ценновой_категории из седан, переднеприводная."))
    (assert (средней_ценновой_категории))
)

(defrule rule39
    (declare (salience 10))
    ?fact1 <- (кроссовер)
    ?fact2 <- (переднеприводная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: средней_ценновой_категории из кроссовер, переднеприводная."))
    (assert (средней_ценновой_категории))
)

(defrule rule40
    (declare (salience 10))
    ?fact1 <- (пикап)
    ?fact2 <- (полноприводная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: средней_ценновой_категории из пикап, полноприводная."))
    (assert (средней_ценновой_категории))
)

(defrule rule41
    (declare (salience 11))
    ?fact1 <- (седан)
    ?fact2 <- (представительская)
    (antonym ?antonym&~бюджетная)
    (antonym ?antonym&~средней_ценновой_категории)
    (antonym ?antonym&~экономичная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: очень_дорогая из седан, представительская."))
    (assert (очень_дорогая))
)

(defrule rule42
    (declare (salience 10))
    ?fact1 <- (быстрая)
    ?fact2 <- (спорткар)
    (antonym ?antonym&~бюджетная)
    (antonym ?antonym&~средней_ценновой_категории)
    (antonym ?antonym&~экономичная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: очень_дорогая из быстрая, спорткар."))
    (assert (очень_дорогая))
)

(defrule rule43
    (declare (salience 10))
    ?fact1 <- (мощная)
    ?fact2 <- (спорткар)
    (antonym ?antonym&~бюджетная)
    (antonym ?antonym&~средней_ценновой_категории)
    (antonym ?antonym&~экономичная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: очень_дорогая из мощная, спорткар."))
    (assert (очень_дорогая))
)

;======================================================================================

(defrule rule44
    (declare (salience 100))
    ?fact1 <- (спорткар)
    ?fact2 <- (очень_дорогая)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Honda из спорткар, очень_дорогая."))
    (assert (Honda))
)

(defrule rule45
    (declare (salience 101))
    ?fact1 <- (кроссовер)
    ?fact2 <- (средней_ценновой_категории)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Honda из кроссовер, средней_ценновой_категории."))
    (assert (Honda))
)

(defrule rule46
    (declare (salience 102))
    ?fact1 <- (седан)
    ?fact2 <- (средней_ценновой_категории)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Honda из седан, средней_ценновой_категории."))
    (assert (Honda))
)

(defrule rule47
    (declare (salience 101))
    ?fact1 <- (седан)
    ?fact2 <- (дорогая)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Mercedes-Benz из седан, дорогая."))
    (assert (Mercedes-Benz))
)

(defrule rule48
    (declare (salience 101))
    ?fact1 <- (пикап)
    ?fact2 <- (средней_ценновой_категории)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Mercedes-Benz из пикап, средней_ценновой_категории."))
    (assert (Mercedes-Benz))
)

(defrule rule49
    (declare (salience 100))
    ?fact1 <- (внедорожник)
    ?fact2 <- (дорогая)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Mercedes-Benz из внедорожник, дорогая."))
    (assert (Mercedes-Benz))
)

(defrule rule50
    (declare (salience 100))
    ?fact1 <- (спорткар)
    ?fact2 <- (очень_дорогая)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Mercedes-Benz из спорткар, очень_дорогая."))
    (assert (Mercedes-Benz))
)

(defrule rule51
    (declare (salience 101))
    ?fact1 <- (микроавтобус)
    ?fact2 <- (средней_ценновой_категории)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Mercedes_Benz из микроавтобус, средней_ценновой_категории."))
    (assert (Mercedes_Benz))
)

(defrule rule52
    (declare (salience 101))
    ?fact1 <- (седан)
    ?fact2 <- (очень_дорогая)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Mercedes-Benz из седан, очень_дорогая."))
    (assert (Mercedes-Benz))
)

(defrule rule53
    (declare (salience 100))
    ?fact1 <- (бюджетная)
    ?fact2 <- (внедорожник)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: LADA из бюджетная, внедорожник."))
    (assert (LADA))
)

(defrule rule54
    (declare (salience 101))
    ?fact1 <- (бюджетная)
    ?fact2 <- (седан)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: LADA из бюджетная, седан."))
    (assert (LADA))
)

(defrule rule55
    (declare (salience 100))
    ?fact1 <- (бюджетная)
    ?fact2 <- (микроавтобус)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: LADA из бюджетная, микроавтобус."))
    (assert (LADA))
)

(defrule rule56
    (declare (salience 100))
    ?fact1 <- (внедорожник)
    ?fact2 <- (дорогая)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Toyota из внедорожник, дорогая."))
    (assert (Toyota))
)

(defrule rule57
    (declare (salience 102))
    ?fact1 <- (седан)
    ?fact2 <- (средней_ценновой_категории)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Toyota из седан, средней_ценновой_категории."))
    (assert (Toyota))
)

(defrule rule58
    (declare (salience 101))
    ?fact1 <- (пикап)
    ?fact2 <- (средней_ценновой_категории)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Toyota из пикап, средней_ценновой_категории."))
    (assert (Toyota))
)

(defrule rule59
    (declare (salience 101))
    ?fact1 <- (кроссовер)
    ?fact2 <- (средней_ценновой_категории)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Toyota из кроссовер, средней_ценновой_категории."))
    (assert (Toyota))
)

(defrule rule60
    (declare (salience 100))
    ?fact1 <- (купе)
    ?fact2 <- (дорогая)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Toyota из купе, дорогая."))
    (assert (Toyota))
)

(defrule rule61
    (declare (salience 101))
    ?fact1 <- (седан)
    ?fact2 <- (экономичная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Ford из седан, экономичная."))
    (assert (Ford))
)

(defrule rule62
    (declare (salience 100))
    ?fact1 <- (пикап)
    ?fact2 <- (дорогая)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Ford из пикап, дорогая."))
    (assert (Ford))
)

(defrule rule63
    (declare (salience 101))
    ?fact1 <- (микроавтобус)
    ?fact2 <- (средней_ценновой_категории)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Ford из микроавтобус, средней_ценновой_категории."))
    (assert (Ford))
)

(defrule rule64
    (declare (salience 100))
    ?fact1 <- (внедорожник)
    ?fact2 <- (дорогая)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Ford из внедорожник, дорогая."))
    (assert (Ford))
)

(defrule rule65
    (declare (salience 101))
    ?fact1 <- (кроссовер)
    ?fact2 <- (средней_ценновой_категории)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Ford из кроссовер, средней_ценновой_категории."))
    (assert (Ford))
)

(defrule rule66
    (declare (salience 100))
    ?fact1 <- (купе)
    ?fact2 <- (дорогая)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Ford из купе, дорогая."))
    (assert (Ford))
)

(defrule rule67
    (declare (salience 100))
    ?fact1 <- (спорткар)
    ?fact2 <- (очень_дорогая)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Ford из спорткар, очень_дорогая."))
    (assert (Ford))
)

(defrule rule68
    (declare (salience 101))
    ?fact1 <- (кроссовер)
    ?fact2 <- (средней_ценновой_категории)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Hyundai из кроссовер, средней_ценновой_категории."))
    (assert (Hyundai))
)

(defrule rule69
    (declare (salience 101))
    ?fact1 <- (седан)
    ?fact2 <- (бюджетная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Hyundai из седан, бюджетная."))
    (assert (Hyundai))
)

(defrule rule70
    (declare (salience 102))
    ?fact1 <- (седан)
    ?fact2 <- (средней_ценновой_категории)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Hyundai из седан, средней_ценновой_категории."))
    (assert (Hyundai))
)

(defrule rule71
    (declare (salience 101))
    ?fact1 <- (микроавтобус)
    ?fact2 <- (средней_ценновой_категории)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Hyundai из микроавтобус, средней_ценновой_категории."))
    (assert (Hyundai))
)

(defrule rule72
    (declare (salience 100))
    ?fact1 <- (внедорожник)
    ?fact2 <- (дорогая)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: BMW из внедорожник, дорогая."))
    (assert (BMW))
)

(defrule rule73
    (declare (salience 101))
    ?fact1 <- (седан)
    ?fact2 <- (дорогая)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: BMW из седан, дорогая."))
    (assert (BMW))
)

(defrule rule74
    (declare (salience 101))
    ?fact1 <- (седан)
    ?fact2 <- (очень_дорогая)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: BMW из седан, очень_дорогая."))
    (assert (BMW))
)

(defrule rule75
    (declare (salience 101))
    ?fact1 <- (кроссовер)
    ?fact2 <- (средней_ценновой_категории)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Audi из кроссовер, средней_ценновой_категории."))
    (assert (Audi))
)

(defrule rule76
    (declare (salience 100))
    ?fact1 <- (внедорожник)
    ?fact2 <- (дорогая)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Audi из внедорожник, дорогая."))
    (assert (Audi))
)

(defrule rule77
    (declare (salience 101))
    ?fact1 <- (седан)
    ?fact2 <- (дорогая)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Audi из седан, дорогая."))
    (assert (Audi))
)

(defrule rule78
    (declare (salience 101))
    ?fact1 <- (седан)
    ?fact2 <- (очень_дорогая)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Audi из седан, очень_дорогая."))
    (assert (Audi))
)

(defrule rule79
    (declare (salience 100))
    ?fact1 <- (спорткар)
    ?fact2 <- (очень_дорогая)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Audi из спорткар, очень_дорогая."))
    (assert (Audi))
)

(defrule rule80
    (declare (salience 101))
    ?fact1 <- (седан)
    ?fact2 <- (бюджетная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Chevrolet из седан, бюджетная."))
    (assert (Chevrolet))
)

(defrule rule81
    (declare (salience 100))
    ?fact1 <- (мощная)
    ?fact2 <- (купе)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Chevrolet из мощная, купе."))
    (assert (Chevrolet))
)

(defrule rule82
    (declare (salience 101))
    ?fact1 <- (кроссовер)
    ?fact2 <- (средней_ценновой_категории)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Chevrolet из кроссовер, средней_ценновой_категории."))
    (assert (Chevrolet))
)

(defrule rule83
    (declare (salience 100))
    ?fact1 <- (внедорожник)
    ?fact2 <- (бюджетная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Chevrolet из внедорожник, бюджетная."))
    (assert (Chevrolet))
)

(defrule rule84
    (declare (salience 100))
    ?fact1 <- (внедорожник)
    ?fact2 <- (дорогая)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Chevrolet из внедорожник, дорогая."))
    (assert (Chevrolet))
)

;======================================================================================

(defrule rule85
    (declare (salience 1002))
    ?fact1 <- (семейная)
    ?fact2 <- (переднеприводная)
    ?fact3 <- (кроссовер)
    ?fact4 <- (средней_ценновой_категории)
    ?fact5 <- (Honda)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: CRV из семейная, переднеприводная, кроссовер, средней_ценновой_категории, Honda."))
    (assert (CRV))
    (assert (sendmessagehalt "Рекомендуем вам: марка: Honda; модель: CRV."))
)    

(defrule rule86
    (declare (salience 1003))
    ?fact1 <- (седан)
    ?fact2 <- (быстрая)
    ?fact3 <- (семейная)
    ?fact4 <- (средней_ценновой_категории)
    ?fact5 <- (Honda)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Accord из седан, быстрая, семейная, средней_ценновой_категории, Honda."))
    (assert (Accord))
    (assert (sendmessagehalt "Рекомендуем вам: марка: Honda; модель: Accord."))
)    

(defrule rule87
    (declare (salience 1000))
    ?fact1 <- (спорткар)
    ?fact2 <- (спортивная)
    ?fact3 <- (быстрая)
    ?fact4 <- (Honda)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: NSX из спорткар, спортивная, быстрая, Honda."))
    (assert (NSX))
    (assert (sendmessagehalt "Рекомендуем вам: марка: Honda; модель: NSX."))
)    

(defrule rule88
    (declare (salience 1001))
    ?fact1 <- (пикап)
    ?fact2 <- (внедорожная)
    ?fact3 <- (полноприводная)
    ?fact4 <- (средней_ценновой_категории)
    ?fact5 <- (Mercedes-Benz)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: X250 из пикап, внедорожная, полноприводная, средней_ценновой_категории, Mercedes-Benz."))
    (assert (X250))
    (assert (sendmessagehalt "Рекомендуем вам: марка: Mercedes-Benz; модель: X250."))
)    

(defrule rule89
    (declare (salience 1002))
    ?fact1 <- (седан)
    ?fact2 <- (семейная)
    ?fact3 <- (быстрая)
    ?fact4 <- (дорогая)
    ?fact5 <- (Mercedes-Benz)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: E63 из седан, семейная, быстрая, дорогая, Mercedes-Benz."))
    (assert (E63))
    (assert (sendmessagehalt "Рекомендуем вам: марка: Mercedes-Benz; модель: E63."))
)    

(defrule rule90
    (declare (salience 1000))
    ?fact1 <- (внедорожник)
    ?fact2 <- (мощная)
    ?fact3 <- (внедорожная)
    ?fact4 <- (быстрая)
    ?fact5 <- (Mercedes-Benz)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: G500 из внедорожник, мощная, внедорожная, быстрая, Mercedes-Benz."))
    (assert (G500))
    (assert (sendmessagehalt "Рекомендуем вам: марка: Mercedes-Benz; модель: G500."))
)    

(defrule rule91
    (declare (salience 1000))
    ?fact1 <- (спорткар)
    ?fact2 <- (быстрая)
    ?fact3 <- (спортивная)
    ?fact4 <- (очень_дорогая)
    ?fact5 <- (Mercedes-Benz)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: SLS из спорткар, быстрая, спортивная, очень_дорогая, Mercedes-Benz."))
    (assert (SLS))
    (assert (sendmessagehalt "Рекомендуем вам: марка: Mercedes-Benz; модель: SLS."))
)    

(defrule rule92
    (declare (salience 1001))
    ?fact1 <- (микроавтобус)
    ?fact2 <- (вместительная)
    ?fact3 <- (экономичная)
    ?fact4 <- (Mercedes-Benz)
    ?fact5 <- (средней_ценновой_категории)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Vito из микроавтобус, вместительная, экономичная, Mercedes-Benz, средней_ценновой_категории."))
    (assert (Vito))
    (assert (sendmessagehalt "Рекомендуем вам: марка: Mercedes-Benz; модель: Vito."))
)    

(defrule rule93
    (declare (salience 1001))
    ?fact1 <- (седан)
    ?fact2 <- (представительская)
    ?fact3 <- (вместительная)
    ?fact4 <- (полноприводная)
    ?fact5 <- (Mercedes-Benz)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: S63 из седан, представительская, вместительная, полноприводная, Mercedes-Benz."))
    (assert (S63))
    (assert (sendmessagehalt "Рекомендуем вам: марка: Mercedes-Benz; модель: S63."))
)    

(defrule rule94
    (declare (salience 1002))
    ?fact1 <- (седан)
    ?fact2 <- (LADA)
    ?fact3 <- (бюджетная)
    ?fact4 <- (экономичная)
    ?fact5 <- (семейная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Vesta  из седан, LADA, бюджетная, экономичная, семейная, ."))
    (assert (Vesta ))
    (assert (sendmessagehalt "Рекомендуем вам: марка: LADA; модель: Vesta ."))
)    

(defrule rule95
    (declare (salience 1000))
    ?fact1 <- (внедорожник)
    ?fact2 <- (экономичная)
    ?fact3 <- (полноприводная)
    ?fact4 <- (LADA)
    ?fact5 <- (бюджетная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Нива из внедорожник, экономичная, полноприводная, LADA, бюджетная, ."))
    (assert (Нива))
    (assert (sendmessagehalt "Рекомендуем вам: марка: LADA; модель: Нива."))
)    

(defrule rule96
    (declare (salience 1000))
    ?fact1 <- (микроавтобус)
    ?fact2 <- (LADA)
    ?fact3 <- (экономичная)
    ?fact4 <- (вместительная)
    ?fact5 <- (бюджетная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Газель из микроавтобус, LADA, экономичная, вместительная, бюджетная."))
    (assert (Газель))
    (assert (sendmessagehalt "Рекомендуем вам: марка: LADA; модель: Газель."))
)    

(defrule rule97
    (declare (salience 1000))
    ?fact1 <- (внедорожник)
    ?fact2 <- (Toyota)
    ?fact3 <- (дорогая)
    ?fact4 <- (мощная)
    ?fact5 <- (внедорожная)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: LC200 из внедорожник, Toyota, дорогая, мощная, внедорожная."))
    (assert (LC200))
    (assert (sendmessagehalt "Рекомендуем вам: марка: Toyota; модель: LC200."))
)    

(defrule rule98
    (declare (salience 1003))
    ?fact1 <- (седан)
    ?fact2 <- (быстрая)
    ?fact3 <- (семейная)
    ?fact4 <- (средней_ценновой_категории)
    ?fact5 <- (Toyota)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Camry из седан, быстрая, семейная, средней_ценновой_категории, Toyota."))
    (assert (Camry))
    (assert (sendmessagehalt "Рекомендуем вам: марка: Toyota; модель: Camry."))
)    

(defrule rule99
    (declare (salience 1002))
    ?fact1 <- (семейная)
    ?fact2 <- (переднеприводная)
    ?fact3 <- (кроссовер)
    ?fact4 <- (средней_ценновой_категории)
    ?fact5 <- (Toyota)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Rav4 из семейная, переднеприводная, кроссовер, средней_ценновой_категории, Toyota."))
    (assert (Rav4))
    (assert (sendmessagehalt "Рекомендуем вам: марка: Toyota; модель: Rav4."))
)    

(defrule rule100
    (declare (salience 1002))
    ?fact1 <- (седан)
    ?fact2 <- (семейная)
    ?fact3 <- (экономичная)
    ?fact4 <- (бюджетная)
    ?fact5 <- (Ford)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Focus из седан, семейная, экономичная, бюджетная, Ford."))
    (assert (Focus))
    (assert (sendmessagehalt "Рекомендуем вам: марка: Ford; модель: Focus."))
)    

(defrule rule101
    (declare (salience 1000))
    ?fact1 <- (пикап)
    ?fact2 <- (вместительная)
    ?fact3 <- (полноприводная)
    ?fact4 <- (мощная)
    ?fact5 <- (дорогая)
    ?fact6 <- (Ford)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Raptor из пикап, вместительная, полноприводная, мощная, дорогая, Ford."))
    (assert (Raptor))
    (assert (sendmessagehalt "Рекомендуем вам: марка: Ford; модель: Raptor."))
)    

(defrule rule102
    (declare (salience 1001))
    ?fact1 <- (микроавтобус)
    ?fact2 <- (экономичная)
    ?fact3 <- (вместительная)
    ?fact4 <- (Ford)
    ?fact5 <- (средней_ценновой_категории)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Transit из микроавтобус, экономичная, вместительная, Ford, средней_ценновой_категории."))
    (assert (Transit))
    (assert (sendmessagehalt "Рекомендуем вам: марка: Ford; модель: Transit."))
)    

(defrule rule103
    (declare (salience 1000))
    ?fact1 <- (внедорожник)
    ?fact2 <- (быстрая)
    ?fact3 <- (внедорожная)
    ?fact4 <- (дорогая)
    ?fact5 <- (Ford)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Explorer из внедорожник, быстрая, внедорожная, дорогая, Ford."))
    (assert (Explorer))
    (assert (sendmessagehalt "Рекомендуем вам: марка: Ford; модель: Explorer."))
)    

(defrule rule104
    (declare (salience 1002))
    ?fact1 <- (кроссовер)
    ?fact2 <- (компактная)
    ?fact3 <- (внедорожная)
    ?fact4 <- (семейная)
    ?fact5 <- (средней_ценновой_категории)
    ?fact6 <- (Ford)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Cuga из кроссовер, компактная, внедорожная, семейная, средней_ценновой_категории, Ford."))
    (assert (Cuga))
    (assert (sendmessagehalt "Рекомендуем вам: марка: Ford; модель: Cuga."))
)    

(defrule rule105
    (declare (salience 1000))
    ?fact1 <- (быстрая)
    ?fact2 <- (спортивная)
    ?fact3 <- (спорткар)
    ?fact4 <- (очень_дорогая)
    ?fact5 <- (Ford)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Mustang из быстрая, спортивная, спорткар, очень_дорогая, Ford."))
    (assert (Mustang))
    (assert (sendmessagehalt "Рекомендуем вам: марка: Ford; модель: Mustang."))
)    

(defrule rule106
    (declare (salience 1002))
    ?fact1 <- (седан)
    ?fact2 <- (семейная)
    ?fact3 <- (экономичная)
    ?fact4 <- (бюджетная)
    ?fact5 <- (Hyundai)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Solaris из седан, семейная, экономичная, бюджетная, Hyundai."))
    (assert (Solaris))
    (assert (sendmessagehalt "Рекомендуем вам: марка: Hyundai; модель: Solaris."))
)    

(defrule rule107
    (declare (salience 1003))
    ?fact1 <- (седан)
    ?fact2 <- (быстрая)
    ?fact3 <- (семейная)
    ?fact4 <- (средней_ценновой_категории)
    ?fact5 <- (Hyundai)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Sonata из седан, быстрая, семейная, средней_ценновой_категории, Hyundai."))
    (assert (Sonata))
    (assert (sendmessagehalt "Рекомендуем вам: марка: Hyundai; модель: Sonata."))
)    

(defrule rule108
    (declare (salience 1001))
    ?fact1 <- (микроавтобус)
    ?fact2 <- (экономичная)
    ?fact3 <- (вместительная)
    ?fact4 <- (средней_ценновой_категории)
    ?fact5 <- (Hyundai)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: H1 из микроавтобус, экономичная, вместительная, средней_ценновой_категории, Hyundai."))
    (assert (H1))
    (assert (sendmessagehalt "Рекомендуем вам: марка: Hyundai; модель: H1."))
)    

(defrule rule109
    (declare (salience 1000))
    ?fact1 <- (внедорожник)
    ?fact2 <- (дорогая)
    ?fact3 <- (мощная)
    ?fact4 <- (внедорожная)
    ?fact5 <- (BMW)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: X5 из внедорожник, дорогая, мощная, внедорожная, BMW."))
    (assert (X5))
    (assert (sendmessagehalt "Рекомендуем вам: марка: BMW; модель: X5."))
)    

(defrule rule110
    (declare (salience 1002))
    ?fact1 <- (седан)
    ?fact2 <- (семейная)
    ?fact3 <- (быстрая)
    ?fact4 <- (дорогая)
    ?fact5 <- (BMW)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: M5 из седан, семейная, быстрая, дорогая, BMW."))
    (assert (M5))
    (assert (sendmessagehalt "Рекомендуем вам: марка: BMW; модель: M5."))
)    

(defrule rule111
    (declare (salience 1001))
    ?fact1 <- (седан)
    ?fact2 <- (представительская)
    ?fact3 <- (вместительная)
    ?fact4 <- (полноприводная)
    ?fact5 <- (BMW)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Series7 из седан, представительская, вместительная, полноприводная, BMW."))
    (assert (Series7))
    (assert (sendmessagehalt "Рекомендуем вам: марка: BMW; модель: Series7."))
)    

(defrule rule112
    (declare (salience 1000))
    ?fact1 <- (внедорожник)
    ?fact2 <- (дорогая)
    ?fact3 <- (мощная)
    ?fact4 <- (внедорожная)
    ?fact5 <- (Audi)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Q7 из внедорожник, дорогая, мощная, внедорожная, Audi."))
    (assert (Q7))
    (assert (sendmessagehalt "Рекомендуем вам: марка: Audi; модель: Q7."))
)    

(defrule rule113
    (declare (salience 1002))
    ?fact1 <- (седан)
    ?fact2 <- (семейная)
    ?fact3 <- (быстрая)
    ?fact4 <- (дорогая)
    ?fact5 <- (Audi)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: A7 из седан, семейная, быстрая, дорогая, Audi."))
    (assert (A7))
    (assert (sendmessagehalt "Рекомендуем вам: марка: Audi; модель: A7."))
)    

(defrule rule114
    (declare (salience 1001))
    ?fact1 <- (седан)
    ?fact2 <- (представительская)
    ?fact3 <- (вместительная)
    ?fact4 <- (полноприводная)
    ?fact5 <- (Audi)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: A8 из седан, представительская, вместительная, полноприводная, Audi."))
    (assert (A8))
    (assert (sendmessagehalt "Рекомендуем вам: марка: Audi; модель: A8."))
)    

(defrule rule115
    (declare (salience 1000))
    ?fact1 <- (спорткар)
    ?fact2 <- (быстрая)
    ?fact3 <- (спортивная)
    ?fact4 <- (очень_дорогая)
    ?fact5 <- (Audi)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: R8 из спорткар, быстрая, спортивная, очень_дорогая, Audi."))
    (assert (R8))
    (assert (sendmessagehalt "Рекомендуем вам: марка: Audi; модель: R8."))
)    

(defrule rule116
    (declare (salience 1002))
    ?fact1 <- (седан)
    ?fact2 <- (семейная)
    ?fact3 <- (экономичная)
    ?fact4 <- (бюджетная)
    ?fact5 <- (Chevrolet)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Cruz из седан, семейная, экономичная, бюджетная, Chevrolet."))
    (assert (Cruz))
    (assert (sendmessagehalt "Рекомендуем вам: марка: Chevrolet; модель: Cruz."))
)    

(defrule rule117
    (declare (salience 1000))
    ?fact1 <- (внедорожник)
    ?fact2 <- (экономичная)
    ?fact3 <- (полноприводная)
    ?fact4 <- (бюджетная)
    ?fact5 <- (Chevrolet)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: NIVA из внедорожник, экономичная, полноприводная, бюджетная, Chevrolet."))
    (assert (NIVA))
    (assert (sendmessagehalt "Рекомендуем вам: марка: Chevrolet; модель: NIVA."))
)    

(defrule rule118
    (declare (salience 1000))
    ?fact1 <- (внедорожник)
    ?fact2 <- (дорогая)
    ?fact3 <- (мощная)
    ?fact4 <- (внедорожная)
    ?fact5 <- (Chevrolet)
=>
    (assert (sendmessagehalt "Рассмотрена продукция: Tahoe из внедорожник, дорогая, мощная, внедорожная, Chevrolet."))
    (assert (Tahoe))
    (assert (sendmessagehalt "Рекомендуем вам: марка: Chevrolet; модель: Tahoe."))
)    

(defrule not_enough_info 
    (declare (salience 0))
=> 
    (assert (sendmessagehalt "Предоставьте больше характеристик."))
) 
