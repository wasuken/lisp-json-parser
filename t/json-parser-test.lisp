(in-package :cl-user)
(defpackage json-parser-test
  (:use :cl :prove :json-parser))
(in-package #:json-parser-test)

(subtest "based test"
  (is (json-parser:parse "{\"test\": \"test\"}")
	  '(:|test| "test"))
  (is (json-parser:parse "{\"test\": \"test\", \"test2\": \"test2\"}")
	  '(:|test| "test" :|test2| "test2"))
  (is (json-parser:parse "{\"test\": \"test\", \"test2\": \"test2\", \"test3\": {\"test4\": \"test4\"}}")
	  '(:|test| "test" :|test2| "test2" :|test3| (:|test4| "test4")))
  (is (json-parser:parse "{\"test\": \"te,st\", \"test2\": \"t,est2\", \"test3\": {\"test4\": \"test,4\"}}")
	  '(:|test| "te,st" :|test2| "t,est2" :|test3| (:|test4| "test,4")))
  (is (json-parser:parse "{\"test\": \"te:st\", \"test2\": \"t:est2\", \"test3\": {\"test4\": \"test:4\"}}")
	  '(:|test| "te:st" :|test2| "t:est2" :|test3| (:|test4| "test:4")))
  (is (json-parser:parse "{\"test\": 1, \"test2\": 2}")
	  '(:|test| 1 :|test2| 2))
  (is (json-parser:parse "{\"test\": true, \"test2\": false}")
	  '(:|test| t :|test2| nil))
  )

;; (subtest "error mechanism"
;;   (is-error (json-parser:parse "{\"test\":")  'simple-error)
;;   (is-error (json-parser:parse "")  'simple-error)
;;   (is-error (json-parser:parse "}}}}}}}")  'simple-error)
;;   (is-error (json-parser:parse ",,,,,,,{,,,,}{:,a}") 'simple-error))

;; (subtest "mean test"
;;   (is (json-parser:parse "{1:1}")
;; 	  '(:|1| 1))
;;   (is (json-parser:parse "{false:false}")
;; 	  '(:|false| false)))
