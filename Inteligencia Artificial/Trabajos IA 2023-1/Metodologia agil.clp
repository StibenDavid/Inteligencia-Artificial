;*******Problemas metodologia agil***********

(deftemplate Problema (slot pair_programming )
		      (slot test_driven_development)
		      (slot continuous_integration))
			

(deffacts Initial
   (Problema ))


; Nuestras primeras reglas se usar n para recopilar s ntomas del usuario.
;********************************************************************

(defrule GetPairProgramming
   (declare (salience 500))
   ?p <- (Problema (pair_programming nil)) 
   =>
   (printout t "Tiene usted problema de Pair Programming (si o no): ")
   (bind ?response (read))
   (modify ?p (pair_programming ?response)))

(defrule GetTestDrivenDevelopment
   (declare (salience 500))
   ?p <- (Problema (test_driven_development nil)) 
   =>
   (printout t "Tiene usted el problema de test driven development (si o no): ")
   (bind ?response (read))
   (modify ?p (test_driven_development ?response)))

(defrule GetContinuousIntegration
   (declare (salience 500))
   ?p <- (Problema (continuous_integration nil)) 
   =>
   (printout t "Presenta usted el problema de continuos integration (si o no): ")
   (bind ?response (read))
   (modify ?p (continuous_integration ?response)))

;*****************************

(defrule trabajoEquipo
   (declare (salience 100))
   (Problema (pair_programming si))
   =>
   (assert (diagnostico PairProgramming ))
   (printout t "Diagnostico: No hay buen trabajo en equipo " crlf))

(defrule pruebasUnitarias
   (declare (salience 100))
   (Problema (test_driven_development si))
   =>
   (assert (diagnostico TestDrivenDevelopment))
   (printout t "Diagnostico: Implementacion apresurada " crlf))

(defrule integracionContinua
   (declare (salience 100))
   (Problema (continuous_integration si))
   =>
   (assert (diagnostico integracionContinua))
   (printout t "Diagnostico: No implementa una infraestructura de integracion continua " crlf))

;*************************************************************************+

; Reglas para recomendar tratamientos sobre la base de los diagn sticos
; Se crearon hechos.


(defrule regla
   (diagnostico PairProgramming)
   =>
   (assert (tratamiento farmacologico))
   (printout t "Recomendación: Asegúrate de que cada tarea se realice en parejas para mejorar la colaboración y la calidad del código." crlf))

(defrule Tratamiento2
   (diagnostico  TestDrivenDevelopment)
   =>
   (assert (tratamiento medicamento))
   (printout t "Recomendación: Enfócate en escribir pruebas unitarias antes de implementar el código para asegurar una mayor calidad y confiabilidad." crlf))

(defrule Tratamiento3
   (diagnostico integracionContinua)
   =>
   (assert (tratamiento controlar))
   (printout t "Recomendación: Implementa una infraestructura de integración continua para automatizar las pruebas y la entrega de software."  crlf))

; Finalmente, si no hay hechos de diagn stico, imprimimos el
; conocimiento de que el sistema experto no se aplica a
; este problema, y ??otro experto debe ser consultado. Nota
; que la importancia debe establecerse para que esta sea la  ltima regla
; comprobado.
(defrule None
   (declare (salience -100))
   (not (diagnostico ?))
   =>
   (printout t "No hay diagn stico posible - consultar Arquitecto software" crlf))