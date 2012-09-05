#!/usr/bin/expect
#
# @author Nestor Urquiza
#

set host "[lindex $argv 0]"
set port "[lindex $argv 1]"
set from "[lindex $argv 2]"
set to "[lindex $argv 3]"
set subject "[lindex $argv 4]"
set body "[lindex $argv 5]"

if { $host == "" || $port == "" || $from == "" || $to == "" || $subject == "" || $body == "" }  {
  puts "Usage: <host> <port> <from> <to> <subject> <body> \n"
  exit 1
}

set timeout 10
spawn telnet $host $port
expect "Connected*"
send "HELO $host\n"
expect "250"  
send "MAIL FROM: $from\n"
expect "250" 
send "RCPT TO: $to\n"
expect "250" 
send "DATA\n"
expect "354" 
send "Subject: $subject\n\n" 
send "$body\n.\n"
expect "250" 
send "QUIT\n"

