(in-package #:large-object)

(defconstant +INV-ARCHIVE+ #x10000)     ; fe-lobj.c
(defconstant +INV-WRITE+   #x20000)
(defconstant +INV-READ+    #x40000)

(defconstant +SEEK-SET+ 0)
(defconstant +SEEK-CUR+ 1)
(defconstant +SEEK-END+ 2)

(defconstant +LARGE-OBJECT-BUFFER-SIZE+ 1024)

(defprepared-with-names lo-create (&optional (oid 0))
  ((:select (:lo-create '$1)) oid) :single)

(defprepared-with-names lo-open (oid mode)
  ((:select (:lo-open '$1 '$2)) oid mode) :single)

(defprepared-with-names lo-write (fd buf)
  ((:select (:lowrite '$1 '$2)) fd buf) :single)

(defprepared-with-names lo-read (fd len)
  ((:select (:loread '$1 '$2)) fd len) :single)

(defprepared-with-names lo-lseek (fd offset whence)
  ((:select (:lo-lseek '$1 '$2 '$3)) fd offset whence) :single)

(defprepared-with-names lo-tell (fd)
  ((:select (:lo-tell '$1)) fd) :single)

(defprepared-with-names lo-close (fd)
  ((:select (:lo-close '$1)) fd) :single)

(defprepared-with-names lo-unlink (oid)
  ((:select (:lo-unlink '$1)) oid) :single)

(defclass large-object-stream-mixin
    (fundamental-binary-stream
     trivial-gray-stream-mixin)
  ((file-descriptor :initarg :fd :reader fd-of)))

(defclass large-object-input-stream
    (fundamental-input-stream
     large-object-stream-mixin)
  ())

(defclass large-object-output-stream
    (fundamental-output-stream
     large-object-stream-mixin)
  ((buffer :initform (make-array 0 :element-type '(unsigned-byte 8))
	   :reader buffer-of)))

(defmethod stream-element-type ((stream large-object-stream-mixin))
  '(unsigned-byte 8))

(defmethod close (stream &key abort)
  (when (not (null abort))
    
  (lo-close (fd-of stream))

(defmethod stream-file-position ((stream large-object-stream))
  (lo-tell (fd-of stream)))

(defmethod (setf stream-file-position) (position-spec (stream large-object-stream))
  (apply #'lo-lseek (fd-of stream) position-spec))

;;(defmethod stream-clear-input stream

(defmethod stream-read-sequence ((stream large-object-stream)
				 sequence start end
				 &key &allow-other-keys)
  (loop for element being the elements of (lo-read (fd-of stream) (- end start))
     for index from start below end
     do (setf (elt sequence index) element)
     finally (return index)))

;;(defmethod stream-clear-output stream

;;(defmethod stream-finish-output stream

;;(defmethod stream-force-output stream

(defmethod stream-write-sequence ((stream large-object-stream)
				  sequence start end
				  &key &allow-other-keys)
  (lo-write (fd-of stream) (subseq sequence start end)))

(defmethod stream-read-byte ((stream large-object-stream))
  (first (lo-read (fd-of stream) 1)))

(defmethod stream-write-byte ((stream large-object-stream) integer)
  (lo-write (fd-of stream) (vector integer)))

(defun open-large-object (oid mode)
  (make-instance 'large-object-stream
		 :fd (lo-open oid mode)))

;;(defprepared-with-names lo_import (pathname)
;;  ((:select (:lo-create oid)) :single))

;;(defprepared-with-names lo_export (oid pathname)
;;  ((:select (:lo-create oid)) :single))