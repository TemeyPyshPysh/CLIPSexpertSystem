properties_points = {
    "седан": 1,
    "семейная": 1,
    "средней_ценновой_категории": 1
}

retract_facts_at_final = False

base = """
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
"""

template = """
(defrule rule{0}
    (declare (salience {1}))
{2}=>
    (assert (sendmessagehalt "Рассмотрена продукция: {3} из {4}."))
    (assert ({3}))
)
"""

template_final_production = """
(defrule rule{0}
    (declare (salience {1}))
{2}=>
    (assert (sendmessagehalt "Рассмотрена продукция: {3} из {7}."))
    (assert ({3}))
    (assert (sendmessagehalt "Рекомендуем вам: марка: {4}; модель: {5}.")){6}
)    
"""

not_enough_info_template = """
(defrule not_enough_info 
    (declare (salience 0))
=> 
    (assert (sendmessagehalt "Предоставьте больше характеристик."))
) 
"""

next_block = """
;======================================================================================
"""

retract_template = "    (retract {})\n"

fact_template = "    ?fact{0} <- ({1})\n"

if __name__ == "__main__":
    with open("rules.txt", "r", encoding='utf-8') as file:
        rules = file.read().split("\n")

    clp_rules = base + next_block
    current_salience = 1

    for i in range(0, len(rules)):
        rule = rules[i]

        if_section = rule.split(" - ")[0]
        then_section = rule.split(" - ")[1]

        facts_section = ""
        facts = if_section.split(" ")
        finalize_production = False
        salience_addiction = 0
        the_make_of = ""
        fact_number = 1
        facts_variables = []
        for fact in facts:
            if fact != "":
                facts_section += fact_template.format(fact_number, fact)
                facts_variables.append(f"?fact{fact_number}")

                if fact[0].isupper():
                    finalize_production = True
                    the_make_of = fact

                salience_addiction += properties_points.get(fact, 0)

                fact_number += 1

        result_section = then_section
        rule_number = i + 1

        if i in [24, 43, 84]:
            current_salience *= 10
            clp_rules += next_block

        if finalize_production:
            appendix = ""
            if retract_facts_at_final:
                appendix += "\n"
                for fact in facts_variables:
                    appendix += retract_template.format(fact)
            clp_rules += template_final_production.format(rule_number, current_salience + salience_addiction,
                                                          facts_section, result_section,
                                                          the_make_of, result_section, appendix,
                                                          ", ".join(facts))
        else:
            clp_rules += template.format(rule_number, current_salience + salience_addiction,
                                         facts_section, result_section,
                                         ", ".join(facts))

    clp_rules += not_enough_info_template

    output_filename = "cars_all_available.clp"
    if retract_facts_at_final:
        output_filename = "cars_more_close.clp"

    with open(output_filename, "w", encoding="utf-8") as file:
        file.write(clp_rules)

