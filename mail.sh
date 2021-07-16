#!/bin/bash
#send mail with a file
echo "This is the mail body" | mail -a README.md -s "sample mail" test@test.com