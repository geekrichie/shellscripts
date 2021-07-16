#!/bin/bash
#send mail with a file
#echo "This is the mail body" | mail -a README.md -s "sample mail" test@test.com


#read mail body from a file
#mail -s "multiple lines" test@test.com <README.md

#read a file and create a table to send the recipient
# (
# echo "To: test@test.com"
# echo "Subject: hello"
# echo "Content-Type: text/html"
# awk '
#     BEGIN{
#     print "<!DOCTYPE html>\n<html>\n<head>\n<style>\ntable,th,td\n{\nborder:1px solid black ;   \nborder-collapse:collapse;\n}\n</style>\n</head>\n<Body>\n<table>"
#     } 
#     {print "<tr>"
#     for(i=1;i<=NF;i++)
#         print "<td>" $i"</td>"
#     print "</tr>"
#     }
#     END{
#     print "\n</table>\n</Body>\n</html>\n"
#     }' a.txt 
# echo
# ) | /usr/sbin/sendmail -t


(
    echo "To: test@test.com"
    echo "Subject: send a csv"
    echo "MIME-Version: 1.0"
    echo "Content-Type: multipart/mixed; boundary=frontier"
    echo
    echo "--frontier"
    echo "Content-Type: text/plain;Charset: utf-8"
    echo
    echo "这是样例消息的内容"
    echo "--frontier"
    echo "Content-Type: application/octet-stream"
    echo "Content-Disposition: attachment;filename=\"test.html\""
    echo "Content-Transfer-Encoding: base64"
    echo
    echo "PGh0bWw+CiAgPGhlYWQ+CiAgPC9oZWFkPgogIDxib2R5PgogICAgPHA+VGhpcyBpcyB0aGUg 
        Ym9keSBvZiB0aGUgbWVzc2FnZS48L3A+CiAgPC9ib2R5Pgo8L2h0bWw+Cg=="
    echo "--frontier"
    echo "Content-Type: text/csv"
    echo "Content-Disposition: attachment;filename=\"word.csv\""
    echo "Content-Transfer-Encoding: base64"
    echo
    /usr/bin/base64 "word.csv"
    echo "--frontier--"
) | /usr/sbin/sendmail -t