#!/usr/bin/expect
#
# smtp-tls-test.sh
#
# Send email over TLS
#
# @author Nestor Urquiza
#

#exp_internal 1

set host "[lindex $argv 0]"
set port "[lindex $argv 1]"
set from "[lindex $argv 2]"
set to "[lindex $argv 3]"
set subject "[lindex $argv 4]"
set body "[lindex $argv 5]"
set userPlain "[lindex $argv 6]"
set passwordPlain "[lindex $argv 7]"

if { $host == "" || $port == "" || $from == "" || $to == "" || $subject == "" || $body == "" || $userPlain == "" || $passwordPlain == ""}  {
  puts "Usage: <host> <port> <from> <to> <subject> <body> <userPlain> <passwordPlain> \n"
  exit 1
}


#send "echo -n \"$userPlain\" | openssl enc -base64"
#expect -re "(.*)"
#set user $expect_out(1, string)
#send "echo -n \"$passwordPlain\" | openssl enc -base64"
#expect -re "(.*)"
#set user $expect_out(1, string)


set user [exec echo -n "$userPlain" | openssl enc -base64]
set password [exec echo -n "$passwordPlain" | openssl enc -base64]

puts "$userPlain:$user"

set timeout 10
spawn openssl s_client -starttls smtp -crlf -connect $host:$port
expect "250" {
  send "ehlo\n"
  expect "250" {
    send "auth login\n"
    expect "334" {
      send "$user\n"
      expect "334" {
        send "$password\n"
        expect "235" {
          send "mail from: <$from>\n"
          expect "250" {
            send "rcpt to: <$to>\n"
            expect "250" {
              send "data\n"
              expect "354" {
                send "from: $from\n"
                send "to: $to\n"
                send "subject: $subject\n\n" 
                send "$body\n.\n"
                expect "250" {
                  send "quit\n"
                }               
              }              
            }            
          }          
        }        
      }      
    }    
  } 
}


