(in-package #:projects-managment)

(defpclass* expense-group ()
  ((name :type string)))

(defpclass* expense-item ()
  ((name :type string)))

(defpassociation*
  ((:class expence-group
	   :slot expense-items
	   :type (hu.dwim.perec:set expense-item))
   (:class expense-item
	   :slot parent-group
	   :type expence-group)))

(defpclass* common-expense-group (expense-group)
  ())

(defpassociation*
  ((:class expense-group
	   :slot expense-items
	   :type (hu.dwim.perec:set common-expense-group)
   (:class common-expense-group
	   :slot parent-group
	   :type expense-group)))

(defpclass* root-expence-group (expence-group)
  ())