(in-package :cl-user)
(defpackage inquisitor.names
  (:nickname :inq.names)
  (:export :name-on-impl)
  (:use :cl))
(in-package :inquisitor.names)


(defun name-on-impl (name)
  nil)

(defvar +names-on-impls+
  '(;;; unicode
    ((:utf8 :unicode)
     ;; #+lispworks :utf-8
     #+clisp 'charset:utf-8
     ;; #+ecl :utf-8
     ;; #+sbcl :utf-8
     ;; #+ccl :utf-8
     ;; #+abcl :utf-8
     #-clisp :utf-8)
    ((:ucs-2le :unicode)
     ;; #+lispworks :unicode ; default endian is :little-endian
     #+clisp 'charset:unicode-16-little-endian
     ;; #+ecl :ucs-2le
     ;; #+sbcl :ucs-2le
     ;; #+ccl :ucs-2le
     #+abcl :utf-16le
     #-(or clisp abcl) :ucs-2le)
    ((:ucs-2be :unicode)
     ;; #+lispworks :unicode ; default endian is :little-endian
     #+clisp 'charset:unicode-16-big-endian
     ;; #+ecl :ucs-2be
     ;; #+sbcl :ucs-2be
     ;; #+ccl :ucs-2be
     #+abcl :utf-16be
     #-(or clisp abcl) :ucs-2be)
    ((:utf16 :unicode)
     ;; #+lispworks nil
     #+clisp 'charset:utf-16
     ;; #+ecl nil
     #+sbcl :utf-16be ; or :utf-16le
     #+ccl :utf-16
     #+abcl :utf-16
     #-(or clisp sbcl ccl) :cannot-treat)

    ;;; japanese
    ((:iso2022-jp :jp)  ; jis
     ;; #+allegro :jis
     ;; #+lispworks :jis
     #+clisp 'charset:iso-2022-jp
     #+ecl :iso-2022-jp
     #+abcl :iso-2022-jp
     #+(or sbcl ccl) :cannot-treat)
    ((:euc-jp :jp)
     ;; #+lispworks :euc-jp
     #+clisp 'charset:euc-jp
     #+ecl :cannot-treat
     ;; #+sbcl :euc-jp
     ;; #+ccl :euc-jp
     ;; #+abcl :euc-jp
     #-(or clisp ecl) :euc-jp)
    ((:cp932 :jp)
     ;; #+lispworks :sjis
     #+clisp 'charset:shift-jis
     #+ecl :cp932
     ;; #+sbcl :sjis
     #+ccl :cp932
     #+abcl :|Shift_JIS|
     #-(or clisp ecl ccl) :sjis)

    ;;; taiwanese
    ((:big5 :tw)
     #+clisp 'charset:big5
     #+ecl :cp950
     #+abcl :|Big5|
     #+(or sbcl ccl) :cannot-treat)
    ((:iso2022-tw :tw)
     #+(or clisp ecl sbcl ccl abcl) :cannot-treat)

    ;;; chinese
    ((:gb2312 :cn)
     #+clisp 'charset:euc-cn
     ;; #+ccl :gb2312
     ;; #+abcl :gb2312
     #+(or ecl sbcl) :cannot-treat
     #-(or clisp ecl sbcl) :gb2312)
    ((:gb18030 :cn)
     #+clisp 'charset:gb18030
     ;; #+abcl :gb18030
     #+(or ecl sbcl ccl) :cannot-treat
     #-(or clisp ecl sbcl ccl) :gb18030)
    ((:iso2022-cn :cn)
     #+clisp 'charset:iso-2022-cn
     #+(or ecl sbcl ccl) :cannot-treat
     ;; #+abcl :iso-2022-cn
     #-(or clisp ecl sbcl ccl) :iso-2022-cn)

    ;;; korean
    ((:euc-kr :kr)
     #+clisp 'charset:euc-kr
     ;; #+abcl :euc-kr
     #+(or ecl sbcl ccl) :cannot-treat
     #-(or clisp ecl sbcl ccl) :euc-kr)
    ((:johab :kr)
     #+clisp 'charset:johab
     #+ecl :cp949
     #+abcl :|x-Johab|
     #+(or sbcl ccl) :cannot-treat
     #-(or clisp ecl sbcl ccl abcl) :johab)
    ((:iso2022-kr :kr)
     #+clisp 'charset:iso-2022-kr
     #+(or ecl sbcl ccl abcl) :cannot-treat
     #-(or clisp ecl sbcl ccl abcl) :iso-2022-kr)

    ;;; arabic
    ((:iso8859-6 :ar)
     #+clisp 'charset:iso-8859-6
     ;; #+ecl :iso-8859-6
     ;; #+sbcl :iso-8859-6
     ;; #+ccl :iso-8859-6
     ;; #+abcl :iso-8859-6
     #-clisp :iso-8859-6)
    ((:cp1256 :ar)
     #+clisp 'charset:cp1256
     #+ecl :ms-arab
     ;; #+sbcl :cp1256
     #+ccl :cannot-treat
     #+abcl :|windows-1256|
     #-(or clisp ecl ccl abcl) :cp1256)

    ;;; greek
    ((:iso8859-7 :gr)
     #+clisp 'charset:iso-8859-7
     ;; #+ecl :iso-8859-7
     ;; #+sbcl :iso-8859-7
     ;; #+ccl :iso-8859-7
     ;; #+abcl :iso-8859-7
     #-(or clisp ) :iso-8859-7)
    ((:cp1253 :gr)
     #+clisp 'charset:cp1253
     #+ecl :ms-greek
     ;; #+sbcl :cp1253
     #+ccl :cannot-treat
     #+abcl  :|windows-1253|
     #-(or clisp ecl ccl abcl) :cp1253)

    ;;; hebrew
    ((:iso8859-8 :hw)
     #+clisp 'charset:iso-8859-8
     ;; #+ecl :iso-8859-8
     ;; #+sbcl :iso-8859-8
     ;; #+ccl :iso-8859-8
     ;; #+abcl :iso-8859-8
     #-clisp :iso-8859-8)
    ((:cp1255 :hw)
     #+clisp 'charset:cp1255
     #+ecl :ms-hebr
     ;; #+sbcl :cp1255
     #+ccl :cannot-treat
     #+abcl :|windows-1255|
     #-(or clisp ecl ccl abcl) :cp1255)

    ;;; turkish
    ((:iso8859-9 :tr)
     #+clisp 'charset:iso-8859-9
     ;; #+ecl :iso-8859-9
     ;; #+sbcl :iso-8859-9
     ;; #+ccl :iso-8859-9
     ;; #+abcl :iso-8859-9
     #-clisp :iso-8859-9)
    ((:cp1254 :tr)
     #+clisp 'charset:cp1254
     #+ecl :ms-turk
     ;; #+sbcl :cp1254
     #+ccl :cannot-treat
     #+abcl :|windows-1254|
     #-(or clisp ecl ccl abcl) :cp1254)

    ;;; russian
    ((:iso8859-5 :ru)
     #+clisp 'charset:iso-8859-5
     ;; #+ecl :iso-8859-5
     ;; #+sbcl :iso-8859-5
     ;; #+ccl :iso-8859-5
     ;; #+abcl :iso-8859-5
     #-clisp :iso-8859-5)
    ((:koi8-r :ru)
      #+clisp 'charset:koi8-r
      #+sbcl :koi8-r
      #+(or ecl ccl) :cannot-treat
      ;; #+abcl :koi8-r
      #-(or clisp sbcl ecl ccl) :koi8-r)
    ((:koi8-u :ru)
     #+clisp 'charset:koi8-u
     ;; #+sbcl :koi8-u
     ;; #+abcl :koi8-u
     #+(or ecl ccl) :cannot-treat
     #-(or clisp ecl ccl) :koi8-u)
    ((:cp866 :ru)
     #+clisp 'charset:cp866
     #+ecl :cp866
     ;; #+sbcl :cp866
     #+ccl :cannot-treat
     #+abcl :ibm866
     #-(or clisp ecl ccl abcl) :cp866)
    ((:cp1251 :ru)
     #+clisp 'charset:cp1251
     #+ecl :ms-cyrl
     ;; #+sbcl :cp1251
     #+ccl :cannot-treat
     #+abcl :|windows-1251|
     #-(or clisp ecl ccl abcl) :cp1251)

    ;;; polish
    ((:iso8859-2 :pl)
     #+clisp 'charset:iso-8859-2
     ;; #+ecl :iso-8859-2
     ;; #+sbcl :iso-8859-2
     ;; #+ccl :iso-8859-2
     ;; #+abcl :iso-8859-2
     #-clisp :iso-8859-2)
    ((:cp1250 :pl)
     #+clisp 'charset:cp1250
     #+ecl :ms-ee
     ;; #+sbcl :cp1250
     #+ccl :cannot-treat
     #+abcl :|windows-1250|
     #-(or clisp ecl ccl abcl) :cp1250)

    ;;; baltic
    ((:iso8859-13 :bl)
     #+clisp 'charset:iso-8859-13
     ;; #+ecl :iso-8859-13
     ;; #+sbcl :iso-8859-13
     ;; #+ccl :iso-8859-13
     ;; #+abcl :iso-8859-13
     #-clisp :iso-8859-13)
    ((:cp1257 :bl)
     #+clisp 'charset:cp1257
     #+ecl :winbaltrim
     ;; #+sbcl :cp1257
     #+ccl :cannot-treat
     #+abcl :|windows-1257|
     #-(or clisp ecl ccl abcl) :cp1257))))



;;    (:lf . #+ccl :unix)))
    
