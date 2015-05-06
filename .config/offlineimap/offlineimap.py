#!/usr/bin/python
import subprocess
def getpassword(acct):
    return subprocess.check_output(["pass", acct]).strip()
